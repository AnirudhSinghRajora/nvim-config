# Neovim Comprehensive Keybindings & Cheatsheet

This cheatsheet covers all navigation motions, editing operations, register manipulations, and plugin workflows configured in this Neovim environment.

---

## 1. Essential Basics & Window Management

### Modes & Exit
| Key | Mode | Description |
| :--- | :--- | :--- |
| `jj` | Insert | Quick escape from Insert mode back to Normal mode |
| `Q` | Normal | Disabled (prevents accidental Ex-mode entry) |
| `<C-t>` | Terminal | Exit terminal mode back to normal terminal buffer navigation |

### Buffer & Window Management
| Key | Description |
| :--- | :--- |
| `<leader>q` | Close current buffer (`:bd`) |
| `<leader>w` | Close current buffer while **preserving split layout** (`:bp\|bd #`) |
| `<C-h>` | Navigate to window / tmux pane on the left |
| `<C-j>` | Navigate to window / tmux pane below |
| `<C-k>` | Navigate to window / tmux pane above |
| `<C-l>` | Navigate to window / tmux pane on the right |
| `<C-S-Down>` | Resize horizontal split taller |
| `<C-S-Up>` | Resize horizontal split shorter |
| `<C-Left>` | Resize vertical split narrower |
| `<C-Right>` | Resize vertical split wider |

### Terminal
| Key | Description |
| :--- | :--- |
| `<leader>ft` | Open centered floating terminal (Floaterm) |
| `<leader>flt` | Toggle floating terminal visibility (works in Normal and Terminal modes) |

---

## 2. Navigation, Motions & Centering

### Line & Buffer Navigation
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<s-h>` | `n`, `v`, `o` | Jump to first non-blank character of line (`^`) |
| `<s-l>` | `n`, `v`, `o` | Jump to last character of line (`g_`) |
| `<C-d>` | Normal | Half-page down and center cursor (`zz`) |
| `<C-u>` | Normal | Half-page up and center cursor (`zz`) |
| `n` | Normal | Next search result (centered `zzzv`) |
| `N` | Normal | Previous search result (centered `zzzv`) |
| `J` | Normal | Join line below while preserving cursor position |
| `==` | Normal | Select entire buffer (`gg<S-v>G`) |

### Flash Fast Motions
| Key | Mode | Description |
| :--- | :--- | :--- |
| `s` | Normal, Visual, Operator | Flash 2-character jump anywhere on screen |
| `S` | Normal | Flash Treesitter node jump |
| `r` | Operator | Remote Flash operation (e.g., `yr` to yank a remote word) |
| `R` | Operator, Visual | Treesitter search |

### File Explorers
| Key | Description |
| :--- | :--- |
| `-` | Open parent directory in floating buffer (**Oil**) |
| `<C-b>` | Toggle file tree sidebar (**Neo-tree**) |

---

## 3. Editing, Selection & Clipboard

### System Clipboard & Registers
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>y` | `n`, `v` | Yank selection to system clipboard (`"+y`) |
| `<leader>Y` | Normal | Yank whole line to system clipboard (`"+Y`) |
| `<leader>p` | `n`, `v` | Paste from system clipboard (`"+p`) |
| `<leader>d` | `n`, `v` | Blackhole delete (does not overwrite default register) |
| `p` | Visual | Paste over selection **without** clobbering paste register (`"_dP`) |
| `Y` | Normal | Yank to end of line (consistent with `D` and `C`) |

### Moving & Duplicating Lines (VSCode Style)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<A-Down>` | Normal, Visual, Insert | Move current line or block down |
| `<A-Up>` | Normal, Visual, Insert | Move current line or block up |
| `<A-S-Down>` | Normal, Visual, Insert | Duplicate current line or selection down |
| `<A-S-Up>` | Normal, Visual, Insert | Duplicate current line or selection up |
| `J` / `K` | Visual | Move selected block down / up |
| `<` / `>` | Visual | Indent / unindent staying in visual selection mode |

### Search, Replace & Utility
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>s` | Normal | Interactive search & replace word under cursor across entire file |
| `//` | Visual | Search buffer for visually highlighted text |
| `<leader>x` | Normal | Make current file executable (`chmod +x %`) |
| `<leader><leader>` | Normal | Re-source current Lua file (`:so`) |
| `<leader>cf` | Normal | Copy relative file path to clipboard |
| `<leader>cp` | Normal | Copy absolute file path to clipboard |
| `<leader>nd` | Normal | Dismiss active Noice notifications |

---

## 4. Quickfix & Location Lists

| Key | Description |
| :--- | :--- |
| `]q` | Next quickfix item (centered `zz`) |
| `[q` | Previous quickfix item (centered `zz`) |
| `]l` | Next location list item (centered `zz`) |
| `[l` | Previous location list item (centered `zz`) |
| `:copen` / `:cclose` | Open / close quickfix list window |
| `:lopen` / `:lclose` | Open / close location list window |

---

## 5. Harpoon 2 Navigation

| Key | Description |
| :--- | :--- |
| `<leader>a` | Add current file to Harpoon |
| `<C-e>` | Toggle Harpoon quick menu window |
| `<C-t>` | Jump directly to Harpoon slot 1 |
| `<C-s>` | Jump directly to Harpoon slot 2 |
| `<C-y>` | Jump directly to Harpoon slot 3 |
| `<C-g>` | Jump directly to Harpoon slot 4 |

---

## 6. Telescope Fuzzy Finder

| Key | Description |
| :--- | :--- |
| `<leader>ff` | Find files (including hidden, excluding `.git`) |
| `<leader>fg` | Live grep with optional arguments (`--iglob`, etc.) |
| `<leader>fc` | Live grep code only (excluding tests and specs) |
| `<leader>fb` | Find open buffers |
| `<leader>fo` | Find recent / old files |
| `<leader>fh` | Find help tags |
| `<leader>fs` | LSP document symbols |
| `<leader>fw` | Find word under cursor across workspace |
| `<leader>fk` | Find registered keymaps |
| `<leader>/` | Fuzzy find in current buffer (dropdown theme) |
| `<leader>gc` | Search git commits |
| `<leader>gb` | Search git commits for current buffer |
| `<leader>fi` | Advanced Git Search |
| `<leader>uc` / `<leader>uC` | Preview and select colorschemes |
| `<leader>uu` | Telescope undo tree history |
| `<leader>uU` / `<leader>U` | Undotree toggle window |
| `<leader>fy` | Neoclip (clipboard & macro history) |
| `<leader>Z` | Zoxide interactive directory jumping |

### Inside Telescope Picker
| Key | Mode | Action |
| :--- | :--- | :--- |
| `<CR>` | Insert | Open single selected file (or multiple if tagged) |
| `<C-j>` / `<C-k>` | Insert | History next / previous |
| `<C-w>` | Insert | Send selected items to quickfix list and open |
| `<C-S-d>` | Insert | Delete selected buffer from list |
| `<C-s>` / `<C-a>` | Insert | Cycle through previewers |

---

## 7. LSP (Language Server Protocol)

| Key | Mode | Description |
| :--- | :--- | :--- |
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references |
| `gI` | Normal | Go to implementation |
| `K` | Normal | Hover documentation window |
| `<C-h>` | Insert | Signature help popup |
| `<leader>rn` | Normal | Rename symbol across workspace |
| `<leader>ca` | `n`, `v` | Code actions |
| `<leader>ws` | Normal | Search workspace symbols |
| `<leader>d` | Normal | Show diagnostic details float for current line |
| `[d` | Normal | Jump to previous diagnostic |
| `]d` | Normal | Jump to next diagnostic |
| `<leader>vrr` | Normal | *(Legacy alias)* References |
| `<leader>vrn` | Normal | *(Legacy alias)* Rename symbol |
| `<leader>vca` | Normal | *(Legacy alias)* Code action |

---

## 8. Formatting & Linting

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>lf` / `<leader>l` | Normal, Visual | Format buffer or selected range (**Conform.nvim**) |
| `<leader>ll` | Normal | Trigger manual linting pass (**nvim-lint**) |

---

## 9. Git Workflows

### Git Signs & Hunks (`gitsigns.nvim`)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `]c` | Normal | Jump to next Git hunk |
| `[c` | Normal | Jump to previous Git hunk |
| `<leader>hs` | Normal, Visual | Stage hunk (or visual range) |
| `<leader>hr` | Normal, Visual | Reset hunk (or visual range) |
| `<leader>hS` | Normal | Stage entire buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk diff in popup |
| `<leader>hb` | Normal | Blame current line with full commit details |
| `<leader>htb` | Normal | Toggle real-time virtual line blame |
| `<leader>hd` | Normal | Diff current file against index |
| `<leader>hD` | Normal | Diff current file against `HEAD~1` |
| `<leader>htd` | Normal | Toggle inline deleted lines preview |
| `ih` | Operator, Visual | Text object: select inside Git hunk |

### Fugitive, Diffview & Octo
| Key | Description |
| :--- | :--- |
| `<leader>gs` | Open Fugitive status panel (`:Git`) |
| `<leader>O` | Open Octo dashboard |
| `<leader>Op` | List GitHub Pull Requests via Octo |
| `:DiffviewOpen` | Open file history / branch diff view |
| `:Neogit` | Open interactive Magit-style Git interface |

---

## 10. Competitive Programming & Testing

### CompetiTest (`lua/plugins/competitive.lua`)
| Key | Description |
| :--- | :--- |
| `<leader>cl` | Start listening for problems/contests via **Competitive Companion** (port 27121) |
| `<leader>cr` | Save current file, compile, and run all test cases with diffs |
| `<leader>cta` / `<leader>ca` | Add a new manual testcase |
| `<leader>cte` / `<leader>ce` | Edit existing testcase |
| `<leader>ctd` / `<leader>cd` | Delete testcases |
| `<leader>cs` | Auto-submit C++ solution to **Codeforces** via `cph-submit` extension |
| `<leader>lc` | Start custom **LeetCode** listener on port 27121 |

### QuickRun
| Key | Description |
| :--- | :--- |
| `<leader>r` | Run current file with `input.txt` redirected |
| `<leader>ci` | Split open `input.txt` (`:vsplit input.txt`) |

---

## 11. Debugging (DAP)

| Key | Description |
| :--- | :--- |
| `<leader>dt` / `<leader>dc` | Start or continue debugging session |
| `<leader>dso` | Step over |
| `<leader>dsi` | Step into |
| `<leader>dsu` | Step out |
| `<leader>dst` | Terminate debugger session |
| `<leader>b` | Toggle line breakpoint |
| `<leader>B` | Set conditional breakpoint |
| `<leader>E` | Set exception breakpoint |
| `<leader>do` | Toggle DAP UI layout |
| `<leader>dr` | Open floating DAP REPL |
| `<leader>ds` | Open floating Scopes inspector |
| `<leader>df` | Open floating Stacks inspector |
| `<leader>db` | Open floating Breakpoints list |
| `<leader>dl` | Re-run last debugging session |

---

## 12. Test Runner (`neotest`)

| Key | Description |
| :--- | :--- |
| `<leader>t` | Run nearest test |
| `<leader>tf` | Run entire test file |
| `<leader>td` | Run tests in current working directory |
| `<leader>tp` | Toggle test output panel |
| `<leader>tl` | Re-run last test |
| `<leader>ts` | Toggle test summary sidebar |

---

## 13. Obsidian & Markdown

| Key | Description |
| :--- | :--- |
| `<leader>on` | Create new Obsidian note |
| `<leader>os` | Search Obsidian notes |
| `<leader>oq` | Quick switch notes |
| `<leader>oo` | Open current note in Obsidian desktop app |
| `<leader>ob` | Show backlinks for current note |
| `<leader>ol` | Show links in current note |
| `<leader>oc` | Toggle Markdown checkbox (`[ ]` <-> `[x]`) |
| `<leader>ot` | Insert Obsidian template |
| `gj` / `gk` | Jump to next / previous Markdown heading (scoped to `*.md`) |
| `:MarkdownPreview` | Open live browser preview of Markdown |
| `:MarkdownPreviewStop` | Stop live browser preview |
