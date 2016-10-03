# atom-npm

[![dependencies Status](https://david-dm.org/tomi77/atom-npm/status.svg)](https://david-dm.org/tomi77/atom-npm)
[![Code Climate](https://codeclimate.com/github/tomi77/atom-npm/badges/gpa.svg)](https://codeclimate.com/github/tomi77/atom-npm)
![Downloads](https://img.shields.io/apm/dm/atom-npm.svg)

NPM integration for Atom.

## Commands

| Command                    | Effect                                                            | Default Windows/Linux key binding | Default MacOS X key binding |
|----------------------------|-------------------------------------------------------------------|-----------------------------------|-----------------------------|
| `npm:install-dependencies` | Install dependencies from `package.json` or `npm-shrinkwrap.json` | `Ctrl+Alt+N I`                    | `Cmd+Alt+N I`               |
| `npm:update-dependencies`  | Update installed packages                                         | `Ctrl+Alt+N U`                    | `Cmd+Alt+N U`               |
| `npm:outdated`             | List of outdated packages                                         | `Ctrl+Alt+N O`                    | `Cmd+Alt+N O`               |
| `npm:run`                  | Run script                                                        | `Ctrl+Alt+N R`                    | `Cmd+Alt+N R`               |

## Multi-project support

When two or more projects are opened in one window, You must choose the project on which command are executed.
