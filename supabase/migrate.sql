-- Updates a scores table created with an older setup.sql to the current layout:
-- millisecond times, recorded games (demos) instead of seeds, the device played on, the
-- number of clicks and the game mode.
-- Run once in the Supabase dashboard: SQL Editor -> New query -> paste -> Run.
-- Safe to run more than once.
--
-- `time` stays (whole seconds); `ms` holds the exact time, existing entries get their
-- seconds converted. The `seed` column and its checks are removed; old entries have no demo
-- and no device, get their clicks counted from the demo if they have one, and count as
-- standard mode (`logic` = false).

alter table public.scores
  add column if not exists ms integer check (ms between 0 and 99999999);
update public.scores set ms = time * 1000 where ms is null;
create index if not exists scores_level_ms on public.scores (level, ms, created_at);

alter table public.scores
  add column if not exists demo jsonb check (pg_column_size(demo) <= 65536);

alter table public.scores
  add column if not exists device text check (device in ('pc', 'mobile', 'tablet'));

alter table public.scores
  add column if not exists clicks integer check (clicks between 0 and 99999);
update public.scores set clicks = jsonb_array_length(demo -> 'ev')
  where clicks is null and jsonb_typeof(demo -> 'ev') = 'array';

alter table public.scores
  add column if not exists logic boolean not null default false;

alter table public.scores drop column if exists seed;   -- also drops the checks on it
