-- Adds millisecond times to an existing scores table (created with an older setup.sql).
-- Run once in the Supabase dashboard: SQL Editor -> New query -> paste -> Run.
--
-- `time` stays (whole seconds) so older clients keep working; `ms` holds the exact time.
-- Existing entries get their seconds converted to milliseconds.

alter table public.scores
  add column if not exists ms integer check (ms between 0 and 99999999);

update public.scores set ms = time * 1000 where ms is null;

create index if not exists scores_level_ms on public.scores (level, ms, created_at);
