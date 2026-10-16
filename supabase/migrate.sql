-- Updates a scores table created with an older setup.sql to the current layout:
-- millisecond times and recorded games (demos) instead of seeds.
-- Run once in the Supabase dashboard: SQL Editor -> New query -> paste -> Run.
-- Safe to run more than once.
--
-- `time` stays (whole seconds); `ms` holds the exact time, existing entries get their
-- seconds converted. The `seed` column and its checks are removed; old entries have no demo.

alter table public.scores
  add column if not exists ms integer check (ms between 0 and 99999999);
update public.scores set ms = time * 1000 where ms is null;
create index if not exists scores_level_ms on public.scores (level, ms, created_at);

alter table public.scores
  add column if not exists demo jsonb check (pg_column_size(demo) <= 65536);

alter table public.scores drop column if exists seed;   -- also drops the checks on it
