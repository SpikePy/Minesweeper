# 💣 Minesweeper

Classic Minesweeper in a single HTML file — no build step, no dependencies, works on desktop and mobile. Available in English and German.

**Play it:** https://spikepy.github.io/Minesweeper

## Features

- Three presets: Beginner (9×9, 10 mines), Intermediate (16×16, 40), Expert (30×16, 99)
- Custom boards up to 50×30
- No guessing: the first click is always safe and opens an area, and from there every cell can be worked out from the numbers (and the mine counter). The board is generated around your first click. Only extremely dense custom boards may still need a guess; the game says so
- Seeds: every game shows a short seed such as `B-K3F9QX` (level + 6 characters). Together with the cell you click first it fully describes the board: enter the seed and click the same first cell to replay exactly that board, including custom boards (`C20x12x35-K3F9QX`). Seeds from before the no-guess change give different boards now. Replays don't count for best times, and each best time stores the seed it was set with
- Chording: click a number with the matching number of flags to open all its neighbours
- Touch support: long-press to flag, or switch on the 🚩 button so that taps set and remove flags
- Shared high-score list: the 5 best times per difficulty, to the millisecond, with player name and seed, stored online in [Supabase](https://supabase.com) so it is the same on every device. Without Supabase configured, or when offline, the list is kept in the browser instead
- Automatic light and dark theme
- Installable as an app (PWA): on Android use the 📲 button or *Install app* in the Chrome menu, on iOS *Share → Add to Home Screen*, on desktop the install icon in the address bar. It then runs standalone without browser bars and also works offline (high scores need a connection)
- English and German interface: follows the browser language, switchable with the DE/EN toggle in the top right corner

## Controls

| Action | Mouse | Touch | Keyboard |
| --- | --- | --- | --- |
| Open a cell | Left click | Tap | |
| Flag a cell (again: remove flag) | Right click | Long press / 🚩 mode | |
| Open neighbours (chord) | Click a number | Tap a number | |
| New game | Click the face, or the board once the game is over | Tap the face, or the board once the game is over | `R` or `F2` |
| Toggle 🚩 mode | | Tap 🚩 | `F` |
| Replay a board | Enter a seed and press ▶ | | `Enter` in the seed field |

## Shared high scores (one-time setup)

The game stays a static page on GitHub Pages; the browser talks to Supabase directly.

1. Create a free project at [supabase.com](https://supabase.com).
2. In the dashboard open **SQL Editor**, paste [`supabase/setup.sql`](supabase/setup.sql) and run it. It creates the `scores` table and allows visitors only to read scores and add new ones. If your table was created before millisecond times existed, run [`supabase/add-ms.sql`](supabase/add-ms.sql) once as well; until then times are saved online in whole seconds.
3. Under **Project Settings → API** copy the project URL and the publishable (anon) key into `SUPABASE_URL` and `SUPABASE_KEY` in `index.html`. That key is meant to be public.

Note: like any leaderboard in a static page, scores are submitted by the browser and can be faked by someone determined. Entries can be removed in the Supabase table editor.

## Run locally

Open `index.html` in any browser. That's it.

Installing and offline mode need the page served over HTTP(S), e.g. `python3 -m http.server` and then http://localhost:8000.

## License

[GPL-3.0](LICENSE)
