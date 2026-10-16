# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Classic Minesweeper as a single static page: all HTML, CSS and JS live in `index.html` (no build step, no dependencies, no package manager, no tests, no linter). It is deployed as-is via GitHub Pages (https://spikepy.github.io/Minesweeper). To run it, open `index.html` in a browser. Keep the game itself in that one file.

PWA support: `manifest.webmanifest`, `icons/` (PNGs generated from the `favicon.svg` flag) and `sw.js`. The service worker is network-first for same-origin GETs with a cache fallback, so updates ship without bumping anything; it ignores cross-origin requests (Supabase). If you add a file the page needs offline, add it to `SHELL` in `sw.js` and bump `CACHE`. Service worker and install only work over HTTP(S), not `file://` (`python3 -m http.server`).

`supabase/setup.sql` is the one-time schema for the shared high-score table; it is run by hand in the Supabase SQL editor, not by any tooling.

## Architecture of `index.html`

All script code is in one IIFE. Main pieces:

- **State** is a set of closure variables (`W, H, M, cells, mode, flagMode, rec, replaying, ...`). Each cell is `{ mine, open, flag, n }`; `cellEls[i]` is its DOM node. `drawCell(i)` re-renders one cell from its state; `render()` rebuilds the whole board.
- **All game actions go through `act(a, i)`** (`'o'` = open, or chord on an open number; `'f'` = toggle flag). Input handlers (`handlePrimary`, right click, long press) only decide which action; `act` records it into `rec` as `[ms since first open, 0|1, cell]` and applies it. Mines are placed on the first open by `generate(start)` (with `Math.random`).
- **Replays (demos):** a win stores `makeDemo()` = `{ w, h, m, mines: [cell indices], ev: rec }` with the score. `playDemo(level, entry)` rebuilds the board from `mines` (no generation) and schedules each event with `setTimeout` through the same `act`, with `replaying = true` (user input ignored, no score saved, the win shows the recorded `ms`). `newGame()` calls `stopReplay()`. A demo is self-contained, so changes to the generator never break old replays; changes to `act`/`chord`/`reveal` semantics could.
- **No-guess generation** (between the `Spielfeld ohne Raten` markers): `generate` places mines outside the start cell's 3×3 area, then runs `solve`, a solver limited to what the player can see (single-number rule, enumeration around each number, then the whole frontier plus the mine counter). When it gets stuck, `perturb` moves one mine at the frontier; after `PERTURBS` failed moves it re-rolls. Work is capped by `BUDGET / (W*H)` steps; if that runs out (very dense custom boards) it uses the best board found and shows `mayGuess`. To benchmark, extract the code between those markers plus `neighbors` and run it in Deno (`~/.deno/bin/deno`).
- **Replays** and **custom boards** never count for high scores.
- **High scores** (top 10 per preset level, `TOP`; the list is hidden behind the 🏆 button, `showScores`): `loadScores()` reads from Supabase's REST API (`api()` is a thin `fetch` wrapper using `SUPABASE_URL`/`SUPABASE_KEY`); if that fails, `online = false` and the localStorage list (`ms-top-<level>`) is used. `submitScore()` always writes the local copy and additionally POSTs when online. Times are milliseconds (`ms`, measured with `performance.now()`); the table keeps whole seconds in `time` plus `ms` and the `demo` (jsonb); `supabase/migrate.sql` upgrades older tables. If the query with `ms`/`demo` is rejected (columns missing), `fullSchema` turns false and the code falls back to seconds without demos. `readBest()` migrates the old single best-time format (`ms-best-<level>`). The publishable key in the source is intentionally public; RLS in `setup.sql` only allows select + insert. If you change score fields, keep `setup.sql` and `migrate.sql` in sync (level names `easy|medium|hard`, name length 1–16, demo size limit).
- **i18n:** all UI strings live in `I18N.de` / `I18N.en` (add every new key to both). Static elements use `data-i18n`, `data-i18n-title`, `data-i18n-placeholder`, `data-i18n-aria`; `setLang()` re-applies them. Messages are stored as a key (`setMessage(key, arg)`) so they re-translate on language switch — don't write translated text into the DOM directly.
- **Input:** pointer events: mouse and pen act on press, touch on release (click opens, right click toggles a flag or chords on numbers), long press = flag, flag mode (`flagMode`, toggled by the 🚩 button or `F`) makes taps toggle flags, keyboard `R`/`F2` for new game.
- **Persistence:** always go through the `store` wrapper (try/catch around localStorage). Keys are prefixed `ms-` (`ms-lang`, `ms-mode`, `ms-name`, `ms-top-*`).

## Conventions

- Code comments are in German; README and commit messages are in English.
- `README.md` documents features and the controls table, and the in-game `help` string summarises the controls in both languages, so keep both in step with input changes.
