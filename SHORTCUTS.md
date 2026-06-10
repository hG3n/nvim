# Neovim Shortcuts

Leader key: `,`

## General

| Mode | Key | Action |
|------|-----|--------|
| Insert | `jk` | Exit to normal mode |
| Normal | `n` | Next search result (centered) |
| Normal | `N` | Prev search result (centered) |
| Normal | `,qq` | Quit all buffers and exit (with confirmation) |

## Movement

| Mode | Key | Action |
|------|-----|--------|
| Normal / Visual | `H` | Start of line |
| Normal / Visual | `L` | End of line |

## Splits

| Mode | Key | Action |
|------|-----|--------|
| Normal | `<Tab>` | Cycle to next split (skips file tree) |

## Tabs

| Mode | Key | Action |
|------|-----|--------|
| Normal | `tn` | New tab |
| Normal | `tq` | Close tab |
| Normal | `<S-Tab>` | Next tab |

## Buffers

| Mode | Key | Action |
|------|-----|--------|
| Normal | `<C-k>` | Prev buffer |
| Normal | `<C-j>` | Next buffer |
| Normal | `,1` – `,9` | Jump to buffer by position |
| Normal | `,bd` | Close buffer |
| Normal | `,bD` | Force close buffer |

## Fuzzy Finder (Telescope)

| Mode | Key | Action |
|------|-----|--------|
| Normal | `<C-p>` | Find files |
| Normal | `,fg` | Live grep (search file contents) |
| Normal | `,fb` | Find open buffers |
| Normal | `,fh` | Search help tags |

## File Tree

| Mode | Key | Action |
|------|-----|--------|
| Normal | `<C-n>` | Toggle file tree |
| Normal | `,e` | Focus file tree |

## Command-line Aliases

| Typed | Expands to |
|-------|-----------|
| `W` | `w` |
| `Q` | `q` |
| `X` | `x` |
| `Wq` / `wQ` | `wq` |
| `Tabe` | `tabe` |
| `qq` | `q!` |
| `ww` | `w!` |
| `xx` | `x!` |

## LSP

| Mode | Key | Action |
|------|-----|--------|
| Normal | `K` | Hover documentation |
| Normal | `grd` | Go to definition |
| Normal | `grD` | Go to declaration |
| Normal | `gri` | Go to implementation |
| Normal | `grr` | References |
| Normal | `grn` | Rename symbol |
| Normal | `gra` | Code action |
| Normal / Visual | `gra` | Code action |
| Normal | `grf` | Format buffer |
| Normal | `grk` | Signature help |
| Normal | `grs` | Document symbols |
| Normal | `grt` | Type definition |

## Custom Commands

| Command | Action |
|---------|--------|
| `:ReloadConfig` | Re-source `init.lua` without restarting |
