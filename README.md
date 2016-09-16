# atom-npm

[![dependencies Status](https://david-dm.org/tomi77/atom-npm/status.svg)](https://david-dm.org/tomi77/atom-npm)
[![Code Climate](https://codeclimate.com/github/tomi77/atom-npm/badges/gpa.svg)](https://codeclimate.com/github/tomi77/atom-npm)

NPM integration for Atom.

## Commands

| Command | Effect | Default key binding |
|---------|--------|---------------------|
| `NPM install` | Install dependencies from `package.json` or `npm-shrinkwrap.json` | `Ctrl-Alt-n i` |
| `NPM update` | Update installed packages | `Ctrl-Alt-n u` |
| `NPM outdated` | List of outdated packages | `Ctrl-Alt-n o` |
| `NPM run <script>` | Run script | `Ctrl-Alt-n r` |

## Multi-project support

When two or more projects are opened in one window, You must choose the project on which command are executed.
