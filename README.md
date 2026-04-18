# fcd — Fuzzy `cd`

A lightweight Zsh or bash function that works like macOS Spotlight, but for your terminal. Type a directory name (or part of it) and jump straight there.

## Installation

Add the code to your `~/.zshrc` or `~/.bashrc`:

## Usage

```
fcd <query> [-e]
```

| Command | Description |
|---|---|
| `fcd project` | cd into the best-matching directory |
| `fcd project -e` | print the matched path instead of cd-ing |

## Matching Behavior

Exact matches (case-insensitive) always take priority over partial matches.

| Query | Directories found | Result |
|---|---|---|
| `fcd project` | `Project`, `PythonProject`, `school_project` | ✅ cd into `Project` |
| `fcd python` | `PythonProject`, `school_python` | 📋 lists both |
| `fcd python` | `Python`, `PythonProject` | ✅ cd into `Python` |
