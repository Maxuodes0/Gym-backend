create table if not exists public.cardio_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  machine_type text not null check (length(trim(machine_type)) > 0 and length(machine_type) <= 80),
  duration_minutes numeric(6,2) not null check (duration_minutes > 0 and duration_minutes <= 1440),
  created_at timestamptz not null default now()
);

create index if not exists idx_cardio_logs_user_created_at on public.cardio_logs(user_id, created_at desc);

alter table public.cardio_logs enable row level security;

drop policy if exists "Cardio logs are readable by owner" on public.cardio_logs;
create policy "Cardio logs are readable by owner"
on public.cardio_logs for select
to authenticated
using (user_id = auth.uid());

drop policy if exists "Cardio logs are insertable by owner" on public.cardio_logs;
create policy "Cardio logs are insertable by owner"
on public.cardio_logs for insert
to authenticated
with check (user_id = auth.uid());

drop policy if exists "Cardio logs are editable by owner" on public.cardio_logs;
create policy "Cardio logs are editable by owner"
on public.cardio_logs for update
to authenticated
using (user_id = auth.uid())
with check (user_id = auth.uid());

drop policy if exists "Cardio logs are deletable by owner" on public.cardio_logs;
create policy "Cardio logs are deletable by owner"
on public.cardio_logs for delete
to authenticated
using (user_id = auth.uid());
