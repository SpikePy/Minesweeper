# 💣 Minesweeper

Classic Minesweeper in a single HTML file — no build step, no dependencies, works on desktop and mobile. Available in English and German.

**Play it:** https://spikepy.github.io/Minesweeper

## Features

- Three presets: Beginner (9×9, 10 mines), Intermediate (16×16, 40), Expert (30×16, 99)
- Custom boards up to 50×30
- No guessing: the first click is always safe and opens an area, and from there every cell can be worked out. The board is generated around your first click. Two game modes (in the settings): *Standard*, where some spots need the mine counter or a long chain of cases and can feel like a guess, and *Pure logic*, where every cell follows from the numbers near it, without the mine counter. Each mode has its own best times. Only extremely dense custom boards may still need a guess; the game says so
- Replays: every game is recorded (each click with its time). A best time stores that recording, and ▶ next to it in the list plays the game back. Below the board you can pause and resume it (⏸/▶), restart it (⏮) and switch the speed between 1×, ½× and ¼×. Click the face to stop a replay
- Chording: click a number with the matching number of flags to open all its neighbours
- Touch support: long-press to flag, or switch on the 🚩 button so that taps set and remove flags
- High-score lists as an overlay that opens after every win and with the 🏆 Best times button: the 10 best times per difficulty, to the millisecond, with player name, the device it was played on (computer, tablet or smartphone), the number of clicks and a replay of the game. Switch between *This device* (kept in the browser) and *Online* (shared through [Supabase](https://supabase.com), the same on every device); the list you picked last is shown next time. A win goes into every list it makes the top 10 of
- Two styles: *Classic* with smileys, emoji icons and bright retro sounds generated in the browser, and *DOOM* with a Doom skull-wall texture, metal-plate fields, Doom faces, a spiked mine, a skull banner as the flag and Doom sounds
- Settings behind the ⚙️ button next to 🚩: sound volume, language, style, difficulty, game mode and player name
- Automatic light and dark theme
- Installable as an app (PWA): on Android use the 📲 button or *Install app* in the Chrome menu, on iOS *Share → Add to Home Screen*, on desktop the install icon in the address bar. It then runs standalone without browser bars and also works offline (high scores need a connection)
- English and German interface: follows the browser language, switchable in the settings

## Controls

| Action | Mouse | Touch | Keyboard |
| --- | --- | --- | --- |
| Open a cell | Left click | Tap | |
| Flag a cell (again: remove flag) | Right click | Long press / 🚩 mode | |
| Open neighbours (chord) | Click a number | Tap a number | |
| New game | Click the face, or the board once the game is over | Tap the face, or the board once the game is over | `R` or `F2` |
| Toggle 🚩 mode | | Tap 🚩 | `F` |
| Watch a best time | ▶ in the best times | Tap ▶ | |

## Shared high scores (one-time setup)

The game stays a static page on GitHub Pages; the browser talks to Supabase directly.

1. Create a free project at [supabase.com](https://supabase.com).
2. In the dashboard open **SQL Editor**, paste [`supabase/setup.sql`](supabase/setup.sql) and run it. It creates the `scores` table and allows visitors only to read scores and add new ones. If your table was created with an older `setup.sql`, run [`supabase/migrate.sql`](supabase/migrate.sql) once instead; until then the online list leaves out what the table has no columns for (the device, or with a `seed` column also replays and milliseconds).
3. Under **Project Settings → API** copy the project URL and the publishable (anon) key into `SUPABASE_URL` and `SUPABASE_KEY` in `index.html`. That key is meant to be public.

Note: like any leaderboard in a static page, scores are submitted by the browser and can be faked by someone determined. Entries can be removed in the Supabase table editor.

## Run locally

Open `index.html` in any browser. That's it.

Installing and offline mode need the page served over HTTP(S), e.g. `python3 -m http.server` and then http://localhost:8000.

## License

[GPL-3.0](LICENSE)

The wall texture, sprites and sounds in `doom/` come from [Freedoom](https://freedoom.github.io) 0.13.0 (BSD license, see [`doom/COPYING-freedoom.txt`](doom/COPYING-freedoom.txt)); `doom/gear.png`, `doom/mine.png` and `doom/flag.png` are drawn for this project in the Doom palette.
