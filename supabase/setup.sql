-- Shared high-score table for Minesweeper.
-- Run once in the Supabase dashboard: SQL Editor -> New query -> paste -> Run.
--
-- Visitors use the public (publishable/anon) key, so Row Level Security limits them
-- to reading scores and adding new ones. Nobody can edit or delete entries through
-- the page; do that in the dashboard if needed.

create table public.scores (
  id         bigint generated always as identity primary key,
  level      text        not null check (level in ('easy', 'medium', 'hard')),
  time       integer     not null check (time between 0 and 99999),           -- whole seconds
  ms         integer              check (ms between 0 and 99999999),         -- exact time in milliseconds
  demo       jsonb                check (pg_column_size(demo) <= 65536),     -- recorded game for the replay; null = none
  name       text        not null check (char_length(name) between 1 and 16),
  created_at timestamptz not null default now()
);

create index scores_level_time on public.scores (level, time, created_at);
create index scores_level_ms on public.scores (level, ms, created_at);

alter table public.scores enable row level security;

create policy "anyone can read scores" on public.scores
  for select to anon using (true);

create policy "anyone can add scores" on public.scores
  for insert to anon with check (true);

grant select, insert on public.scores to anon;
