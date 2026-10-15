# 💣 Minesweeper

Classic Minesweeper in a single HTML file — no build step, no dependencies, works on desktop and mobile. Available in English and German.

**Play it:** https://spikepy.github.io/Minesweeper

## Features

- Three presets: Beginner (9×9, 10 mines), Intermediate (16×16, 40), Expert (30×16, 99)
- Custom boards up to 50×30
- The first click is always safe (it and its neighbours stay mine-free)
- Question marks for unsure cells: right click a flag again
- Chording: click a number with the matching number of flags to open all its neighbours
- Touch support: long-press to flag, or toggle flag mode
- Best times per difficulty, saved in the browser
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

## Run locally

Open `index.html` in any browser. That's it.

## License

[GPL-3.0](LICENSE)
