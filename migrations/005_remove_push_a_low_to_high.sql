delete from public.exercises
where workout_type = 'Push A'
and name = 'Cable Crossover (Low to High)'
and not exists (
  select 1
  from public.exercise_logs
  where exercise_logs.exercise_id = exercises.id
);
