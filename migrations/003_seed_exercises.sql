truncate table public.exercises restart identity cascade;

insert into public.exercises (workout_type, name, sets, reps, notes, sort_order) values
('Push A', 'Chest Press Machine', 4, '10-12', 'Controlled eccentric. Keep shoulder blades pinned.', 10),
('Push A', 'Incline Chest Press Machine', 4, '10-12', 'Drive through upper chest without locking elbows hard.', 20),
('Push A', 'Chest Fly Machine (Pec Deck)', 3, '12-15', 'Soft elbows. Pause briefly at peak contraction.', 30),
('Push A', 'Shoulder Press Machine', 3, '10-12', 'Brace core and keep tempo smooth.', 50),
('Push A', 'Lateral Raise Machine', 3, '12-15', 'Lead with elbows. Avoid shrugging.', 60),
('Push A', 'Triceps Pushdown', 3, '12-15', 'Elbows fixed. Full extension each rep.', 70),
('Push A', 'Overhead Triceps Extension', 3, '12', 'Deep stretch, controlled lockout.', 80),

('Pull A', 'Lat Pulldown Machine', 4, '10-12', 'Pull elbows down and back. Avoid leaning too far.', 10),
('Pull A', 'Seated Cable Row', 4, '10-12', 'Neutral spine. Squeeze mid-back.', 20),
('Pull A', 'Machine Row (Chest Supported)', 3, '12', 'Chest stays planted. Pause at contraction.', 30),
('Pull A', 'Rear Delt Fly Machine', 3, '15', 'Move through rear delts, not traps.', 40),
('Pull A', 'Bicep Curl Machine', 3, '12', 'Full extension and controlled curl.', 50),
('Pull A', 'Cable Hammer Curl', 3, '12-15', 'Neutral grip. Keep wrists stacked.', 60),

('Legs', 'Leg Press Machine', 4, '10-15', 'Full foot pressure. Do not bounce at depth.', 10),
('Legs', 'Leg Extension Machine', 3, '12-15', 'Pause at top. Lower under control.', 20),
('Legs', 'Lying Leg Curl Machine', 3, '12-15', 'Hips down. Squeeze hamstrings.', 30),
('Legs', 'Hip Abductor Machine', 3, '15-20', 'Controlled outward drive.', 40),
('Legs', 'Hip Adductor Machine', 3, '15-20', 'Controlled inward squeeze.', 50),
('Legs', 'Calf Raise Machine', 4, '15-20', 'Deep stretch and full raise.', 60),

('Push B', 'Incline Chest Press Machine', 4, '10-12', 'Prioritize upper chest. Smooth tempo.', 10),
('Push B', 'Chest Press Machine', 3, '10-12', 'Strong brace and steady press.', 20),
('Push B', 'Cable Crossover (High to Low)', 3, '12-15', 'High-to-low line. Finish near lower chest.', 30),
('Push B', 'Shoulder Press Machine', 4, '10-12', 'Keep ribs down and press vertically.', 40),
('Push B', 'Lateral Raise Machine', 3, '12-15', 'Strict reps. No torso swing.', 50),
('Push B', 'Front Raise Machine', 3, '12', 'Lift to shoulder height with control.', 60),
('Push B', 'Triceps Pushdown', 4, '12-15', 'Strong lockout with elbows close.', 70),

('Pull B', 'Wide Grip Lat Pulldown', 4, '10-12', 'Wide grip with controlled scapular depression.', 10),
('Pull B', 'Narrow Grip Cable Row', 4, '10-12', 'Drive elbows close to body.', 20),
('Pull B', 'Lower Back Extension Machine', 3, '15', 'Move through hips. Avoid hyperextension.', 30),
('Pull B', 'Face Pull', 3, '15', 'Pull toward forehead with external rotation.', 40),
('Pull B', 'Preacher Curl Machine', 4, '10-12', 'No bouncing. Full range.', 50),
('Pull B', 'Cable Curl', 3, '12-15', 'Constant cable tension.', 60);
