# Neovim Comprehensive Keybindings & Cheatsheet

This cheatsheet is the complete, definitive reference for every keybinding, navigation motion, text object, operator, register workflow, and plugin keymap available in this Neovim environment.

---

## Quick Navigation Index

1. [Core Vim Foundations](#1-core-vim-foundations)
   - [Basic & Word Motions](#basic--word-motions)
   - [Line & Viewport Motions](#line--viewport-motions)
   - [Core Operators](#core-operators)
   - [Standard Text Objects](#standard-text-objects)
   - [Marks & Jump List](#marks--jump-list)
   - [Macros & Registers](#macros--registers)
   - [Command-Line & File Operations](#command-line--file-operations)
2. [Commenting & Annotations](#2-commenting--annotations)
3. [Surround, Multi-Cursor & Text Manipulation](#3-surround-multi-cursor--text-manipulation)
4. [Treesitter Text Objects & Selection](#4-treesitter-text-objects--selection)
5. [Code Folding & Focus Modes](#5-code-folding--focus-modes)
6. [Window, Buffer, Tab & Terminal Management](#6-window-buffer-tab--terminal-management)
7. [File Explorers](#7-file-explorers)
8. [Fast Navigation & Harpoon](#8-fast-navigation--harpoon)
9. [Telescope Fuzzy Finder](#9-telescope-fuzzy-finder)
10. [Autocompletion & Snippets](#10-autocompletion--snippets)
11. [LSP (Language Server Protocol)](#11-lsp-language-server-protocol)
12. [Formatting & Linting](#12-formatting--linting)
13. [Git Workflows](#13-git-workflows)
14. [Competitive Programming & QuickRun](#14-competitive-programming--quickrun)
15. [Debugging (DAP)](#15-debugging-dap)
16. [Test Runner (Neotest)](#16-test-runner-neotest)
17. [Obsidian & Markdown](#17-obsidian--markdown)
18. [Quickfix & Location Lists](#18-quickfix--location-lists)

---

## 1. Core Vim Foundations

### Basic & Word Motions
| Key | Mode | Description |
| :--- | :--- | :--- |
| `h` / `j` / `k` / `l` | Normal, Visual | Move left / down / up / right by one character |
| `w` | Normal, Visual | Jump forward to start of next word |
| `W` | Normal, Visual | Jump forward to start of next WORD (space-delimited) |
| `b` | Normal, Visual | Jump backward to start of previous word |
| `B` | Normal, Visual | Jump backward to start of previous WORD (space-delimited) |
| `e` | Normal, Visual | Jump forward to end of current/next word |
| `E` | Normal, Visual | Jump forward to end of current/next WORD |
| `ge` | Normal, Visual | Jump backward to end of previous word |
| `f{char}` | Normal, Visual | Jump forward onto next occurrence of `{char}` on current line |
| `F{char}` | Normal, Visual | Jump backward onto previous occurrence of `{char}` on current line |
| `t{char}` | Normal, Visual | Jump forward till before next occurrence of `{char}` |
| `T{char}` | Normal, Visual | Jump backward till after previous occurrence of `{char}` |
| `;` | Normal, Visual | Repeat last `f`, `F`, `t`, or `T` motion forward |
| `,` | Normal, Visual | Repeat last `f`, `F`, `t`, or `T` motion backward |
| `%` | Normal, Visual | Jump to matching bracket, parenthesis, or curly brace |
| `*` | Normal | Search forward for word currently under cursor |
| `#` | Normal | Search backward for word currently under cursor |

### Line & Viewport Motions
| Key | Mode | Description |
| :--- | :--- | :--- |
| `0` | Normal, Visual | Jump to absolute beginning of current line (column 0) |
| `^` / `<s-h>` | Normal, Visual | Jump to first non-blank character of current line |
| `$` / `<s-l>` | Normal, Visual | Jump to end of current line |
| `g_` | Normal, Visual | Jump to last non-blank character of line |
| `gg` | Normal, Visual | Jump to first line of buffer |
| `G` | Normal, Visual | Jump to last line of buffer |
| `{number}G` / `:{number}<CR>` | Normal | Jump directly to line `{number}` |
| `<C-d>` | Normal | Scroll half-page down and center viewport (`zz`) |
| `<C-u>` | Normal | Scroll half-page up and center viewport (`zz`) |
| `<C-f>` | Normal | Scroll full-page down |
| `<C-b>` | Normal | Scroll full-page up |
| `<C-e>` | Normal | Scroll viewport down one line (cursor stays) |
| `<C-y>` | Normal | Scroll viewport up one line (cursor stays) |
| `zz` | Normal | Center current line in viewport |
| `zt` | Normal | Scroll viewport so current line is at the top |
| `zb` | Normal | Scroll viewport so current line is at the bottom |
| `H` | Normal | Move cursor to top (High) line on screen |
| `M` | Normal | Move cursor to middle (Middle) line on screen |
| `L` | Normal | Move cursor to bottom (Low) line on screen |
| `n` | Normal | Jump to next search match and center cursor (`nzzzv`) |
| `N` | Normal | Jump to previous search match and center cursor (`Nzzzv`) |
| `J` | Normal | Join line below while preserving cursor position (`mzJ`z`) |
| `==` | Normal | Select entire buffer (`gg<S-v>G`) |

### Core Operators
*Combine operators with motions or text objects (e.g., `dw` = delete word, `ci"` = change inside quotes, `yap` = yank paragraph).*

| Key | Mode | Description |
| :--- | :--- | :--- |
| `d` | Normal | Delete (cut) operator |
| `c` | Normal | Change operator (deletes text and enters Insert mode) |
| `y` | Normal | Yank (copy) operator |
| `Y` | Normal | Yank to end of line (`y$`) |
| `x` | Normal | Delete character under cursor |
| `s` | Normal | Delete character under cursor and enter Insert mode |
| `r{char}` | Normal | Replace single character under cursor with `{char}` |
| `R` | Normal | Enter Replace mode (overwrite text) |
| `u` | Normal | Undo last change |
| `<C-r>` | Normal | Redo last undone change |
| `.` | Normal | Repeat last edit command |
| `~` | Normal, Visual | Switch case of character under cursor |
| `gU{motion}` | Normal | Make text uppercase across motion |
| `gu{motion}` | Normal | Make text lowercase across motion |
| `>` / `<` | Visual | Indent / unindent lines (preserves visual selection mode) |
| `jj` | Insert | Fast escape back to Normal mode |
| `Q` | Normal | Disabled (prevents accidental Ex-mode entry) |

### Standard Text Objects
*Used after operators like `d`, `c`, `y`, `v` (e.g., `diw` = delete inner word, `ca(` = change around parentheses).*

| Text Object | Description |
| :--- | :--- |
| `iw` / `aw` | Inner / around word |
| `iW` / `aW` | Inner / around WORD (separated only by whitespace) |
| `is` / `as` | Inner / around sentence |
| `ip` / `ap` | Inner / around paragraph |
| `i"` / `a"` | Inner / around double quotes (`"..."`) |
| `i'` / `a'` | Inner / around single quotes (`'...'`) |
| `i\`` / `a\`` | Inner / around backticks (`` `...` ``) |
| `i(` / `a(` or `ib` / `ab` | Inner / around parentheses (`(...)`) |
| `i[` / `a[` | Inner / around square brackets (`[...]`) |
| `i{` / `a{` or `iB` / `aB` | Inner / around curly braces (`{...}`) |
| `i<` / `a<` | Inner / around angle brackets (`<...>`) |
| `it` / `at` | Inner / around HTML/XML tag block (`<div>...</div>`) |

### Marks & Jump List
| Key | Mode | Description |
| :--- | :--- | :--- |
| `m{a-z}` | Normal | Set buffer-local mark at cursor position |
| `m{A-Z}` | Normal | Set global project mark across all files |
| `'{mark}` | Normal | Jump to beginning of line containing `{mark}` |
| ``{mark}` | Normal | Jump to exact line and column containing `{mark}` |
| `''` / ` `` ` | Normal | Jump back to position before previous jump |
| `<C-o>` | Normal | Navigate backward in jump list |
| `<C-i>` | Normal | Navigate forward in jump list (jump list restored) |
| `:jumps` | Normal | View full history of cursor jump locations |
| `:marks` | Normal | View all active marks |

### Macros & Registers
| Key | Mode | Description |
| :--- | :--- | :--- |
| `q{a-z}` | Normal | Start recording macro into register `{a-z}` |
| `q` | Normal | Stop macro recording |
| `@{a-z}` | Normal | Execute macro stored in register `{a-z}` |
| `@@` | Normal | Replay most recently executed macro |
| `"{reg}y` | Normal, Visual | Yank into specific register `{reg}` |
| `"{reg}p` | Normal, Visual | Paste from specific register `{reg}` |
| `"+` | Normal, Visual | System clipboard register (`<leader>y`, `<leader>p`) |
| `"_` | Normal, Visual | Black hole register (`<leader>D` deletes without touching clipboard) |
| `"0` | Normal | Yank register (stores last explicit yank, untouched by `x` or `d`) |
| `:reg` | Normal | View contents of all Neovim registers |

### Command-Line & File Operations
| Command | Description |
| :--- | :--- |
| `:w` / `:w!` | Save current buffer / force save |
| `:q` / `:q!` | Quit window / quit without saving changes |
| `:wq` / `:x` / `ZZ` | Save and quit window |
| `:wa` / `:qa` | Save all modified buffers / quit all windows |
| `:%s/old/new/g` | Search and replace `old` with `new` across entire buffer |
| `:%s/old/new/gc` | Search and replace with confirmation prompt for each occurrence |
| `<leader>sr` | Interactive search & replace for word currently under cursor |
| `//` | Visual | Search buffer for visually highlighted text |
| `<Esc>` | Normal | **Clear search highlights & dismiss all active notifications/popups** |
| `<leader>nd` | Normal | Dismiss active notifications |
| `<leader>nh` | Normal | Show notification history |
| `:noh` | Normal | Clear active search highlighting |
| `<leader>x` | Normal | Make current file executable (`chmod +x %`) |
| `<leader><leader>` | Normal | Re-source active Lua configuration file (`:so`) |
| `<leader>cf` | Normal | Copy relative file path to system clipboard |
| `<leader>cp` | Normal | Copy absolute file path to system clipboard |

---

## 2. Commenting & Annotations

*Powered by `Comment.nvim` and native Neovim commenting engine.*

### Line Comments (`//`, `#`, `--`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `gcc` | Normal | Toggle comment on the current line |
| `gc{motion}` | Normal | Toggle comment across motion (e.g., `gc4j` for 4 lines down, `gcap` for paragraph) |
| `gc` | Visual | Toggle comment on selected lines |
| `gcA` | Normal | Insert comment at the end of current line and enter Insert mode |
| `gco` | Normal | Insert comment on new line below and enter Insert mode |
| `gcO` | Normal | Insert comment on new line above and enter Insert mode |

### Block Comments (`/* ... */`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `gbc` | Normal | Toggle block comment on current line |
| `gb{motion}` | Normal | Toggle block comment across motion |
| `gb` | Visual | Toggle block comment on selected lines |

### Todo Comments (`todo-comments.nvim`)
| Key | Description |
| :--- | :--- |
| `]t` | Jump to next `TODO`, `FIXME`, `BUG`, `NOTE`, or `PERF` comment |
| `[t` | Jump to previous `TODO`, `FIXME`, `BUG`, `NOTE`, or `PERF` comment |
| `<leader>st` | Search all workspace `TODO` / `FIXME` comments via Telescope picker |

---

## 3. Surround, Multi-Cursor & Text Manipulation

### Surround Operations (`nvim-surround`)
| Key | Mode | Description | Example |
| :--- | :--- | :--- | :--- |
| `ys{motion}{char}` | Normal | Add surround `{char}` around `{motion}` | `ysiw"` &rarr; `word` becomes `"word"` |
| `ds{char}` | Normal | Delete surround `{char}` | `ds"` &rarr; `"word"` becomes `word` |
| `cs{target}{replacement}` | Normal | Change `{target}` surround to `{replacement}` | `cs"'` &rarr; `"word"` becomes `'word'` |
| `S{char}` | Visual | Wrap visual selection with `{char}` | Highlight text, press `S]` &rarr; `[text]` |

### Multi-Cursor Editing (`vim-visual-multi`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<C-n>` | Normal | Select word under cursor; press again to add next match |
| `q` | VM mode | Skip current occurrence and jump to next match |
| `[` / `]` | VM mode | Jump backward / forward between active cursors |
| `\\c` | VM mode | Clear all multi-cursors and return to normal mode |
| `<C-Down>` / `<C-Up>` | Normal | Add vertical cursor directly below / above |

### Moving & Duplicating Lines (VSCode Style)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<A-Down>` | Normal, Visual, Insert | Move current line or selected block down |
| `<A-Up>` | Normal, Visual, Insert | Move current line or selected block up |
| `<A-S-Down>` | Normal, Visual, Insert | Duplicate current line or selection down |
| `<A-S-Up>` | Normal, Visual, Insert | Duplicate current line or selection up |
| `J` / `K` | Visual | Move selected block down / up preserving selection |

---

## 4. Treesitter Text Objects & Selection

### Incremental Syntax Selection
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<C-space>` | Normal | Initialize syntax selection under cursor |
| `<C-space>` | Visual | Increment selection to parent AST node |
| `<C-CR>` | Visual | Increment selection to outer scope (function / class) |
| `<bs>` | Visual | Decrement selection to child AST node |

### Code Text Objects (`nvim-treesitter-textobjects`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `af` / `if` | Operator, Visual | Around / inside function body |
| `ac` / `ic` | Operator, Visual | Around / inside class / struct body |
| `aa` / `ia` | Operator, Visual | Around / inside parameter or function argument |

### Code Navigation by AST Nodes
| Key | Description |
| :--- | :--- |
| `]m` / `[m` | Jump to next / previous function start |
| `]M` / `[M` | Jump to next / previous function end |
| `]]` / `[[` | Jump to next / previous class start |
| `][` / `[]` | Jump to next / previous class end |
| `<leader>sp` | Swap parameter under cursor with next parameter |
| `<leader>sP` | Swap parameter under cursor with previous parameter |

---

## 5. Code Folding & Focus Modes

### Modern Code Folding (`nvim-ufo`)
| Key | Description |
| :--- | :--- |
| `zR` | Open all folds across current buffer |
| `zM` | Close all folds across current buffer |
| `zr` | Open fold level one step |
| `zm` | Close fold level one step |
| `za` | Toggle fold under cursor |
| `zo` / `zc` | Open / close fold under cursor |
| `zK` | Peek Fold: If cursor is on a closed fold, peeks fold preview in floating window (falls back to Hover) |

### Focus & Zen Modes
| Key | Description |
| :--- | :--- |
| `<leader>z` | Toggle Zen Mode (centered distraction-free buffer view) |
| `<leader>tw` | Toggle Twilight (dims all code paragraphs outside cursor scope) |

---

## 6. Window, Buffer, Tab & Terminal Management

### Bufferline Tabs (`bufferline.nvim`)
| Key | Description |
| :--- | :--- |
| `<leader>bn` | Switch to next open buffer tab |
| `<leader>bp` | Switch to previous open buffer tab |
| `<leader>bc` | Close active buffer tab (`:bd`) |
| `<leader>bco` | Close all other buffers except current |
| `<leader>1` - `<leader>9` | Jump directly to buffer tab number 1 through 9 |

### Window Splits & Navigation
| Key | Description |
| :--- | :--- |
| `<C-h>` | Navigate to window / tmux pane on the left |
| `<C-j>` | Navigate to window / tmux pane below |
| `<C-k>` | Navigate to window / tmux pane above |
| `<C-l>` | Navigate to window / tmux pane on the right |
| `<leader>q` | Close current window buffer (`:bd`) |
| `<leader>w` | Close current buffer while **preserving split layout** (`:bp\|bd #`) |
| `<C-S-Down>` | Resize horizontal split taller (+2) |
| `<C-S-Up>` | Resize horizontal split shorter (-2) |
| `<C-Left>` | Resize vertical split narrower (-2) |
| `<C-Right>` | Resize vertical split wider (+2) |

### Terminal Operations (`floaterm`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>ft` | Normal | Open centered floating terminal (70% height, 80% width) |
| `<leader>flt` | Normal, Terminal | Toggle centered floating terminal visibility |
| `<leader>fv` / `<leader>tv` | Normal, Terminal | **Toggle 35% right-hand vertical split terminal** (`vterm`) |
| `<leader>fh` / `<leader>th` | Normal, Terminal | **Toggle 35% bottom horizontal split terminal (VSCode style)** (`hterm`) |
| `<leader>fn` / `<M-n>` | Normal, Terminal | **Cycle to next terminal** in the queue |
| `<leader>fp` / `<M-p>` | Normal, Terminal | **Cycle to previous terminal** in the queue |
| `<C-t>` | Terminal | Exit terminal input mode back to Normal mode |
| `:FloatermNew` | Command | Create a new terminal in the queue |
| `:FloatermKill` | Command | Kill active terminal |

---

## 7. File Explorers

| Key | Description |
| :--- | :--- |
| `-` | Open parent directory in floating buffer (**Oil.nvim**) |
| `<C-b>` | Toggle file tree sidebar (**Neo-tree**) |

### Inside Oil File Manager
| Key | Action |
| :--- | :--- |
| `<CR>` | Open file or directory |
| `<C-v>` | Open file in vertical split |
| `<C-s>` | Open file in horizontal split |
| `<C-p>` | Preview file in floating window |
| `_` | Open current working directory |
| `g.` | Toggle hidden files visibility |

---

## 8. Fast Navigation & Harpoon

### Flash Screen Motions (`flash.nvim`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `s` | Normal, Visual, Op | Type 2 characters to jump anywhere on screen instantly |
| `S` | Normal | Flash Treesitter node jump |
| `r` | Operator | Remote flash operation (e.g., `yr` to yank a word across the screen) |
| `R` | Operator, Visual | Treesitter AST search |

### Harpoon File Pinning
| Key | Description |
| :--- | :--- |
| `<leader>a` | Add / pin current file to Harpoon list |
| `<C-e>` | Toggle Harpoon quick menu window |
| `<C-t>` | Jump directly to Harpoon slot 1 |
| `<C-s>` | Jump directly to Harpoon slot 2 |
| `<C-y>` | Jump directly to Harpoon slot 3 |
| `<C-g>` | Jump directly to Harpoon slot 4 |

---

## 9. Telescope Fuzzy Finder

### Search Pickers
| Key | Description |
| :--- | :--- |
| `<leader>ff` | Find files (includes hidden, ignores `.git`) |
| `<leader>fg` | Live grep workspace with ripgrep |
| `<leader>fc` | Live grep code only (excludes tests, specs, fixtures) |
| `<leader>fb` | Find currently open buffers |
| `<leader>fo` | Find recent / old files |
| `<leader>fH` | Search Neovim help documentation |
| `<leader>fs` | Search LSP document symbols in current buffer |
| `<leader>fw` | Find word currently under cursor across workspace |
| `<leader>fk` | Search all registered keymaps |
| `<leader>/` | Fuzzy find in current buffer (dropdown theme) |
| `<leader>gc` | Search git commits |
| `<leader>gb` | Search git commits for current buffer |
| `<leader>fi` | Advanced Git search |
| `<leader>uc` / `<leader>uC` | Interactive colorscheme selector |
| `<leader>uu` | Telescope undo tree history picker |
| `<leader>uU` / `<leader>U` | Undotree toggle window |
| `<leader>fy` | Neoclip (clipboard & yank history) |
| `<leader>Z` | Zoxide interactive directory jumping |

### Inside Telescope Picker Window
| Key | Mode | Action |
| :--- | :--- | :--- |
| `<CR>` | Insert | Open single selected file (or all tagged files) |
| `<C-j>` / `<C-k>` | Insert | History next / previous query |
| `<C-w>` | Insert | Send selected results to Quickfix list and open |
| `<C-S-d>` | Insert | Delete selected buffer from list |
| `<C-s>` / `<C-a>` | Insert | Cycle through previewers |
| `<Esc>` / `<C-c>` | Insert | Close Telescope picker |

---

## 10. Autocompletion & Snippets

*Powered by `nvim-cmp` and `LuaSnip`.*

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<C-Space>` | Insert | Manually trigger autocomplete suggestions menu |
| `<C-n>` | Insert | Next suggestion in completion menu |
| `<C-p>` | Insert | Previous suggestion in completion menu |
| `<C-y>` | Insert | Confirm and accept selected suggestion |
| `<C-e>` | Insert | Abort / dismiss completion menu |
| `<C-b>` / `<C-f>` | Insert | Scroll documentation float window up / down |
| `<Tab>` | Insert | Jump forward to next snippet placeholder (e.g. in CP template) |
| `<S-Tab>` | Insert | Jump backward to previous snippet placeholder |

---

## 11. LSP (Language Server Protocol)

| Key | Mode | Description |
| :--- | :--- | :--- |
| `gd` | Normal | Go to definition |
| `gr` | Normal | Find all references |
| `gI` | Normal | Go to implementation |
| `K` | Normal | Show hover documentation popup |
| `<C-h>` | Insert | Show signature help popup |
| `<leader>rn` | Normal | Rename symbol workspace-wide |
| `<leader>ca` | Normal, Visual | Show LSP code actions |
| `<leader>ws` | Normal | Search workspace symbols |
| `gl` / `<leader>cd` | Normal | Show line diagnostics float |
| `[d` | Normal | Jump to previous diagnostic error/warning |
| `]d` | Normal | Jump to next diagnostic error/warning |
| `<leader>vrr` | Normal | *(Legacy)* References |
| `<leader>vrn` | Normal | *(Legacy)* Rename symbol |
| `<leader>vca` | Normal | *(Legacy)* Code action |

---

## 12. Formatting & Linting

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>lf` | Normal, Visual | Format buffer or selected range (**Conform.nvim**) |
| `<leader>ll` | Normal | Trigger manual linting pass (**nvim-lint**) |

---

## 13. Git Workflows

### Git Signs & Hunks (`gitsigns.nvim`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `]c` | Normal | Jump to next Git diff hunk |
| `[c` | Normal | Jump to previous Git diff hunk |
| `<leader>hs` | Normal, Visual | Stage current hunk (or selected visual range) |
| `<leader>hr` | Normal, Visual | Reset / discard current hunk |
| `<leader>hS` | Normal | Stage entire buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk diff in floating popup |
| `<leader>hb` | Normal | Blame current line with commit details |
| `<leader>htb` | Normal | Toggle inline virtual blame line |
| `<leader>hd` | Normal | Diff current file against git index |
| `<leader>hD` | Normal | Diff current file against `HEAD~1` |
| `<leader>htd` | Normal | Toggle inline deleted lines preview |
| `ih` | Operator, Visual | Text object: select inside Git hunk |

### Fugitive, Diffview & Octo
| Key | Description |
| :--- | :--- |
| `<leader>gs` | Open Fugitive Git status panel (`:Git`) |
| `<leader>Oo` | Open Octo GitHub dashboard |
| `<leader>Op` | List GitHub pull requests |
| `:DiffviewOpen` | Open side-by-side branch / commit diff view |
| `:DiffviewClose` | Close Diffview panels |
| `:DiffviewFileHistory` | Open full file commit history panel |
| `:Neogit` | Open interactive Magit-style Git interface |

---

## 14. Competitive Programming & QuickRun

### CompetiTest (`lua/plugins/competitive.lua`)
| Key | Description |
| :--- | :--- |
| `<leader>cl` | Start listening for problems from **Competitive Companion** browser extension (port 27121) |
| `<leader>cr` | Save current solution, compile C++, and run testcases with diffs |
| `<leader>cta` | Add manual testcase input & expected output |
| `<leader>cte` | Edit existing testcase |
| `<leader>ctd` | Delete testcases |
| `<leader>cs` | Auto-submit C++ solution to **Codeforces** via `cph-submit` |
| `<leader>lc` | Start custom **LeetCode** problem listener on port 27121 |

### QuickRun & Input
| Key | Description |
| :--- | :--- |
| `<leader>r` | Run active file redirected from `input.txt` |
| `<leader>ci` | Split open `input.txt` vertically (`:vsplit input.txt`) |

---

## 15. Debugging (DAP)

| Key | Description |
| :--- | :--- |
| `<leader>dt` / `<leader>dc` | Start or continue debugging session |
| `<leader>dso` | Step over |
| `<leader>dsi` | Step into |
| `<leader>dsu` | Step out |
| `<leader>dst` | Terminate debugger session |
| `<leader>b` | Toggle line breakpoint |
| `<leader>B` | Set conditional breakpoint with expression |
| `<leader>E` | Set exception breakpoint |
| `<leader>do` | Toggle DAP UI layout |
| `<leader>dr` | Open floating DAP REPL console |
| `<leader>dsc` | Open floating Scopes inspector |
| `<leader>df` | Open floating Call Stacks inspector |
| `<leader>db` | Open floating Breakpoints manager |
| `<leader>dl` | Re-run last debugging session |

---

## 16. Test Runner (`neotest`)

| Key | Description |
| :--- | :--- |
| `<leader>tr` | Run nearest test under cursor |
| `<leader>tf` | Run entire test file |
| `<leader>td` | Run tests in current working directory |
| `<leader>tp` | Toggle floating test output panel |
| `<leader>tl` | Re-run most recent test |
| `<leader>ts` | Toggle test summary sidebar tree |

---

## 17. Obsidian & Markdown

| Key | Description |
| :--- | :--- |
| `<leader>on` | Create new Obsidian note |
| `<leader>os` | Search Obsidian notes across vault |
| `<leader>oq` | Quick switch between vault notes |
| `<leader>oo` | Open active note inside Obsidian desktop application |
| `<leader>ob` | Show backlinks for current note |
| `<leader>ol` | Show links inside current note |
| `<leader>oc` | Toggle Markdown checkbox (`[ ]` <-> `[x]`) |
| `<leader>ot` | Insert Obsidian template |
| `gj` / `gk` | Jump to next / previous Markdown heading (`##`) |
| `:MarkdownPreview` | Open live browser preview of Markdown |
| `:MarkdownPreviewStop` | Stop live browser preview |

---

## 18. Quickfix & Location Lists

| Key | Description |
| :--- | :--- |
| `]q` | Next quickfix error/item (centered `zz`) |
| `[q` | Previous quickfix error/item (centered `zz`) |
| `]l` | Next location list item (centered `zz`) |
| `[l` | Previous location list item (centered `zz`) |
| `:copen` / `:cclose` | Open / close quickfix list window |
| `:lopen` / `:lclose` | Open / close location list window |
| `:cfirst` / `:clast` | Jump to very first / very last quickfix item |
