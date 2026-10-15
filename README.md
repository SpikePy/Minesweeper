# 💣 Minesweeper

Classic Minesweeper in a single HTML file — no build step, no dependencies, works on desktop and mobile. Available in English and German.

**Play it:** https://spikepy.github.io/Minesweeper

## Features

- Three presets: Beginner (9×9, 10 mines), Intermediate (16×16, 40), Expert (30×16, 99)
- Custom boards up to 50×30
- Seeds: every game shows a short seed such as `B-K3F9QX` (level + 6 characters) that fully describes the board. Enter it to replay exactly that board, including custom boards (`C20x12x35-K3F9QX`). Replays don't count for best times, and each best time stores the seed it was set with
- Question marks for unsure cells: right click a flag again
- Chording: click a number with the matching number of flags to open all its neighbours
- Touch support: long-press to flag, or toggle flag mode
- Best times per difficulty, saved in the browser and always shown below the board
- Automatic light and dark theme
- English and German interface: follows the browser language, switchable with the DE/EN toggle in the top right corner

## Controls

| Action | Mouse | Touch | Keyboard |
| --- | --- | --- | --- |
| Open a cell | Left click | Tap | |
| Flag a cell (again: question mark, again: clear) | Right click | Long press / flag mode | |
| Open neighbours (chord) | Click a number | Tap a number | |
| New game | Click the face | Tap the face | `R` or `F2` |
| Toggle flag mode | | | `F` |
| Replay a board | Enter a seed and press ▶ | | `Enter` in the seed field |

## Run locally

Open `index.html` in any browser. That's it.

## License

[GPL-3.0](LICENSE)
