create extension if not exists "pgcrypto";

do $$ begin
  create type workout_type as enum ('Push A', 'Pull A', 'Legs', 'Push B', 'Pull B', 'Rest Day');
exception
  when duplicate_object then null;
end $$;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  full_name text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.weight_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  weight numeric(5,2) not null check (weight > 0 and weight < 1000),
  body_fat_percentage numeric(4,1) not null check (body_fat_percentage >= 0 and body_fat_percentage <= 100),
  created_at timestamptz not null default now()
);

create table if not exists public.workouts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  workout_type workout_type not null,
  workout_date date not null default current_date,
  is_rest_day boolean not null default false,
  created_at timestamptz not null default now(),
  constraint rest_day_type_check check (
    (is_rest_day = true and workout_type = 'Rest Day') or
    (is_rest_day = false and workout_type <> 'Rest Day')
  )
);

create table if not exists public.exercises (
  id uuid primary key default gen_random_uuid(),
  workout_type workout_type not null,
  name text not null,
  sets integer not null check (sets > 0 and sets <= 12),
  reps text not null,
  notes text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.exercise_logs (
  id uuid primary key default gen_random_uuid(),
  workout_id uuid not null references public.workouts(id) on delete cascade,
  exercise_id uuid not null references public.exercises(id) on delete restrict,
  set_number integer not null check (set_number > 0),
  weight_used numeric(6,2) not null check (weight_used >= 0),
  reps_completed integer not null check (reps_completed >= 0 and reps_completed <= 200),
  created_at timestamptz not null default now(),
  unique (workout_id, exercise_id, set_number)
);

create index if not exists idx_weight_logs_user_created_at on public.weight_logs(user_id, created_at desc);
create index if not exists idx_workouts_user_date on public.workouts(user_id, workout_date desc);
create index if not exists idx_exercises_workout_type on public.exercises(workout_type, sort_order);
create index if not exists idx_exercise_logs_workout on public.exercise_logs(workout_id, exercise_id, set_number);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists profiles_set_updated_at on public.profiles;
create trigger profiles_set_updated_at
before update on public.profiles
for each row execute procedure public.set_updated_at();

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, full_name)
  values (new.id, new.email, coalesce(new.raw_user_meta_data->>'full_name', 'TURA Athlete'))
  on conflict (id) do update set email = excluded.email;

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();
