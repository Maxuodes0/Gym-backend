# TURA Backend API

TURA uses Supabase directly from the Next.js application. All data access goes through the typed service layer in `frontend/services`.

## Environment

Required frontend variables:

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=
```

## Auth

The app is a single-user product. Create exactly one Supabase Auth user in the Supabase dashboard, then sign in with email and password from `/login`.

Registration is intentionally not exposed in the UI.

## Tables

`profiles`
- Created automatically by the `on_auth_user_created` trigger.
- User can read and update only their own profile.

`weight_logs`
- User-owned body metrics.
- `created_at` is generated automatically. The UI does not expose manual date entry.

`workouts`
- User-owned workout sessions.
- `workout_date` defaults to the current date.
- `is_rest_day` enforces `workout_type = 'Rest Day'`.

`exercises`
- Global seed table containing the Push A, Pull A, Legs, Push B, and Pull B plan.
- Readable by authenticated users.

`exercise_logs`
- Stores each set as an individual row.
- Access is inherited from the owning workout.

`cardio_logs`
- User-owned cardio sessions.
- Stores the cardio machine type and duration in minutes.
- `created_at` is generated automatically. The UI does not expose manual date entry.

## Service Operations

Weight:
- `getWeightLogs()`
- `createWeightLog(weight, bodyFatPercentage)`
- `updateWeightLog(id, values)`
- `deleteWeightLog(id)`

Workouts:
- `getExercises(workoutType)`
- `getWorkouts()`
- `getWorkoutDetails(id)`
- `createWorkout(workoutType)`
- `createRestDay()`
- `upsertExerciseLogs(workoutId, rows)`
- `deleteWorkout(id)`

Cardio:
- `getCardioLogs()`
- `createCardioLog(machineType, durationMinutes)`
- `updateCardioLog(id, values)`
- `deleteCardioLog(id)`

Dashboard:
- Aggregates weight trends, body fat trends, workout frequency, monthly workouts, total training days, and current streak from Supabase rows.

## Deployment Notes

1. Create a Supabase project.
2. Run `backend/migrations/001_initial_schema.sql`.
3. Run `backend/migrations/002_rls_policies.sql`.
4. Run `backend/migrations/003_seed_exercises.sql`.
5. Run `backend/migrations/004_cardio_logs.sql`.
6. Create one Auth user in Supabase.
7. Add `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` to Vercel.
8. Deploy `/frontend` to Vercel.
