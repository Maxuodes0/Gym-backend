alter table public.profiles enable row level security;
alter table public.weight_logs enable row level security;
alter table public.workouts enable row level security;
alter table public.exercises enable row level security;
alter table public.exercise_logs enable row level security;

drop policy if exists "Profiles are readable by owner" on public.profiles;
create policy "Profiles are readable by owner"
on public.profiles for select
to authenticated
using (id = auth.uid());

drop policy if exists "Profiles are editable by owner" on public.profiles;
create policy "Profiles are editable by owner"
on public.profiles for update
to authenticated
using (id = auth.uid())
with check (id = auth.uid());

drop policy if exists "Weight logs are readable by owner" on public.weight_logs;
create policy "Weight logs are readable by owner"
on public.weight_logs for select
to authenticated
using (user_id = auth.uid());

drop policy if exists "Weight logs are insertable by owner" on public.weight_logs;
create policy "Weight logs are insertable by owner"
on public.weight_logs for insert
to authenticated
with check (user_id = auth.uid());

drop policy if exists "Weight logs are editable by owner" on public.weight_logs;
create policy "Weight logs are editable by owner"
on public.weight_logs for update
to authenticated
using (user_id = auth.uid())
with check (user_id = auth.uid());

drop policy if exists "Weight logs are deletable by owner" on public.weight_logs;
create policy "Weight logs are deletable by owner"
on public.weight_logs for delete
to authenticated
using (user_id = auth.uid());

drop policy if exists "Workouts are readable by owner" on public.workouts;
create policy "Workouts are readable by owner"
on public.workouts for select
to authenticated
using (user_id = auth.uid());

drop policy if exists "Workouts are insertable by owner" on public.workouts;
create policy "Workouts are insertable by owner"
on public.workouts for insert
to authenticated
with check (user_id = auth.uid());

drop policy if exists "Workouts are editable by owner" on public.workouts;
create policy "Workouts are editable by owner"
on public.workouts for update
to authenticated
using (user_id = auth.uid())
with check (user_id = auth.uid());

drop policy if exists "Workouts are deletable by owner" on public.workouts;
create policy "Workouts are deletable by owner"
on public.workouts for delete
to authenticated
using (user_id = auth.uid());

drop policy if exists "Exercises are readable by authenticated users" on public.exercises;
create policy "Exercises are readable by authenticated users"
on public.exercises for select
to authenticated
using (true);

drop policy if exists "Exercise logs are readable by workout owner" on public.exercise_logs;
create policy "Exercise logs are readable by workout owner"
on public.exercise_logs for select
to authenticated
using (
  exists (
    select 1 from public.workouts
    where workouts.id = exercise_logs.workout_id
    and workouts.user_id = auth.uid()
  )
);

drop policy if exists "Exercise logs are insertable by workout owner" on public.exercise_logs;
create policy "Exercise logs are insertable by workout owner"
on public.exercise_logs for insert
to authenticated
with check (
  exists (
    select 1 from public.workouts
    where workouts.id = exercise_logs.workout_id
    and workouts.user_id = auth.uid()
  )
);

drop policy if exists "Exercise logs are editable by workout owner" on public.exercise_logs;
create policy "Exercise logs are editable by workout owner"
on public.exercise_logs for update
to authenticated
using (
  exists (
    select 1 from public.workouts
    where workouts.id = exercise_logs.workout_id
    and workouts.user_id = auth.uid()
  )
)
with check (
  exists (
    select 1 from public.workouts
    where workouts.id = exercise_logs.workout_id
    and workouts.user_id = auth.uid()
  )
);

drop policy if exists "Exercise logs are deletable by workout owner" on public.exercise_logs;
create policy "Exercise logs are deletable by workout owner"
on public.exercise_logs for delete
to authenticated
using (
  exists (
    select 1 from public.workouts
    where workouts.id = exercise_logs.workout_id
    and workouts.user_id = auth.uid()
  )
);
