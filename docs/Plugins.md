# Neovim Plugin Reference Guide (Linux)

This document provides a complete reference for all plugins configured in this modular Neovim setup. Plugins are organized domain-by-domain under `lua/plugins/*.lua`.

---

## 1. UI & Appearance (`lua/plugins/ui.lua`, `colorscheme.lua`)

### `folke/tokyonight.nvim`
- **Purpose**: Default high-contrast dark theme with transparent background.
- **Config**: Loads eagerly (`lazy = false`, `priority = 1000`) with transparent sidebars and floating windows.
- **Alternatives included**: `catppuccin/nvim` and `ellisonleao/gruvbox.nvim` (loaded lazily on demand).

### `nvimdev/dashboard-nvim`
- **Purpose**: Clean, fast, centered start screen (`theme = "doom"`).
- **Features**: ASCII Neovim slant art, startup timing metrics, quick action keys (`f` find, `n` new file, `r` recents, `g` grep, `c` config, `l` lazy, `q` quit).
- **Indentation fix**: Automatically excluded from `indent-blankline` so no vertical lines are rendered on the welcome screen.

### `nvim-lualine/lualine.nvim`
- **Purpose**: Fast statusline with Tokyo Night theme.
- **Features**: Integrates Git diffs, diagnostics, relative file path, recording macros / search mode indicators via Noice, and window progress/position.
- **Extensions**: Enabled for `fugitive`, `quickfix`, `fzf`, `lazy`, `mason`, `nvim-dap-ui`, `oil`.

### `akinsho/bufferline.nvim`
- **Purpose**: Buffer tabline at the top of the screen showing open files.

### `folke/noice.nvim` & `rcarriga/nvim-notify`
- **Purpose**: Modern UI replacement for cmdline, popups, messages, and notifications.
- **Keymaps**: `<leader>nd` dismisses all active notifications.

### `lukas-reineke/indent-blankline.nvim` (`ibl`)
- **Purpose**: Subtle vertical indentation guides.
- **Exclusions**: Cleanly excluded from `dashboard`, `help`, `neo-tree`, `lazy`, `mason`, `notify`, `oil`, `floaterm`.

### `kevinhwang91/nvim-ufo` & `promise-async`
- **Purpose**: High-performance code folding with LSP and Tree-sitter providers.
- **Keymaps**:
  - `zR`: Open all folds.
  - `zM`: Close all folds.
  - `zK`: Peek folded lines under cursor (falls back to LSP hover if not folded).

### `folke/zen-mode.nvim`
- **Purpose**: Distraction-free editing mode.
- **Command**: `:ZenMode`. Temporarily hides line numbers, disables Noice/UFO, and restores everything on close.

### `brenoprata10/nvim-highlight-colors`
- **Purpose**: Real-time color preview for hex, rgb, and hsl color codes in buffers.

### `RRethy/vim-illuminate`
- **Purpose**: Automatically highlights all occurrences of the word under cursor across the current buffer.

---

## 2. File Explorer & Core Editing (`lua/plugins/editor.lua`)

### `stevearc/oil.nvim`
- **Purpose**: File manager that lets you edit your filesystem directly as a Neovim buffer.
- **Keymap**: `-` opens Oil in a floating window.
- **Commands**: Normal buffer editing commands (`dd` to delete file, rename by editing line text, `:w` to commit changes). `q` closes the window.

### `nvim-neo-tree/neo-tree.nvim`
- **Purpose**: Traditional sidebar file tree explorer.
- **Keymap**: `<C-b>` toggles Neo-tree.

### `folke/which-key.nvim`
- **Purpose**: Interactive popup cheat sheet that appears when you start typing a key combination.
- **Registered Groups**:
  - `<leader>f`: `+Find / Telescope`
  - `<leader>g`: `+Git`
  - `<leader>h`: `+Git Hunks`
  - `<leader>c`: `+Code / Competitive`
  - `<leader>d`: `+Debug (DAP)`
  - `<leader>t`: `+Test (Neotest)`
  - `<leader>o`: `+Obsidian`
  - `<leader>u`: `+UI / Undo / Colors`
  - `<leader>l`: `+Format / Lint`
  - `<leader>s`: `+Swap / Search`
  - `<leader>v`: `+LSP Legacy / Config`

### `folke/flash.nvim`
- **Purpose**: Fast bidirectional screen motion and 2-character jump navigation.
- **Keymaps**:
  - `s`: Flash jump (normal/visual/operator).
  - `S`: Flash Tree-sitter selection.
  - `r`: Remote flash (in operator mode).
  - `<c-s>`: Toggle flash search inside standard `/` search.

### `kylechui/nvim-surround`
- **Purpose**: Add, change, and delete surrounding quotes, brackets, and tags.
- **Commands**:
  - `ys{motion}{char}`: Add surrounding (e.g. `ysiw"` to surround word with `"`).
  - `cs{target}{new}`: Change surrounding (e.g. `cs"'` to change `"` to `'`).
  - `ds{target}`: Delete surrounding (e.g. `ds"`).

### `numToStr/Comment.nvim`
- **Purpose**: Smart code commenting.
- **Keymaps**: `gcc` toggles line comment, `gc` toggles block/visual comment.

### `windwp/nvim-autopairs`
- **Purpose**: Automatically closes parentheses, brackets, and quotes as you type.

### `mg979/vim-visual-multi`
- **Purpose**: Multi-cursor editing.
- **Keymaps**: `<M-LeftMouse>` adds a cursor at click (VSCode-style). `<C-n>` selects next occurrence of word.

### `mbbill/undotree`
- **Purpose**: Visual undo history tree.
- **Keymap**: `<leader>uu` opens Telescope Undo; `<leader>uU` / `<leader>U` toggles Undotree.

### `chentoast/marks.nvim` & `tummetott/unimpaired.nvim`
- **Purpose**: Enhanced visual bookmarks in the gutter, and paired bracket navigation (`]q`/`[q` for quickfix, `]l`/`[l` for location list).

---

## 3. Fuzzy Finding & Search (`lua/plugins/telescope.lua`)

### `nvim-telescope/telescope.nvim` (branch `0.1.x`)
- **Dependencies**: `telescope-fzf-native`, `telescope-ui-select`, `telescope-live-grep-args`, `telescope-undo`, `advanced-git-search`, `zoxide.vim`.
- **Keymaps**:
  - `<leader>ff`: Find files (searches hidden files, excludes `.git`).
  - `<leader>fg`: Live grep with ripgrep arguments.
  - `<leader>fc`: Live grep code (excludes test and spec files).
  - `<leader>fb`: Switch active buffer.
  - `<leader>fo`: Open recent files.
  - `<leader>fH`: Help documentation tags.
  - `<leader>fs`: LSP document symbols.
  - `<leader>fw`: Search word under cursor across project.
  - `<leader>gc`: Search git commit history.
  - `<leader>gb`: Search buffer git commit history.
  - `<leader>fk`: Search keymaps.
  - `<leader>fi`: Advanced Git search.
  - `<leader>Z`: Zoxide directory jumper.
  - `<leader>/`: Fuzzy search inside current buffer.
  - `<leader>uC`: Colorscheme selector with live preview.

---

## 4. Syntax Highlighting & Parsing (`lua/plugins/treesitter.lua`)

### `nvim-treesitter/nvim-treesitter`
- **Purpose**: AST-based code parsing for highlighting, indentation, and code navigation.
- **Features**: `auto_install = true` automatically downloads grammar parsers for any opened file format.
- **Ensure Installed**: 48+ languages including C, C++, Rust, Go, Python, Java, Kotlin, JS/TS, HTML, CSS, SCSS, JSON, YAML, TOML, Markdown, Bash, Dockerfile, Terraform, Elixir, Ruby.
- **Textobjects**:
  - Parameters: `ia` (inner), `aa` (outer).
  - Functions: `if` (inner), `af` (outer).
  - Classes: `ic` (inner), `ac` (outer).
  - Parameter swap: `<leader>sp` (swap next), `<leader>sP` (swap previous).
- **Sticky Scope**: `nvim-treesitter-context` keeps the function header visible at the top when scrolling long functions.
- **Auto Tag**: `nvim-ts-autotag` automatically closes and renames paired HTML/XML/JSX tags.

---

## 5. LSP & Autocompletion (`lua/plugins/lsp.lua`, `cmp.lua`)

### `neovim/nvim-lspconfig` & `mason-org/mason.nvim`
- **Purpose**: Modern Language Server Protocol setup without legacy wrappers.
- **Lua Development**: `folke/lazydev.nvim` configures Lua LSP for Neovim config and plugins with full type hints.
- **Preconfigured Servers**:
  - `clangd` (C/C++ with background index, clang-tidy, completion placeholders)
  - `pyright` (Python)
  - `rust_analyzer` (Rust)
  - `gopls` (Go with staticcheck and gofumpt)
  - `ts_ls` (TypeScript & JavaScript)
  - `html`, `cssls`, `tailwindcss`, `astro`, `svelte` (Web development)
  - `lua_ls` (Lua)
  - `jsonls`, `yamlls`, `taplo` (Config formats)
  - `bashls` (Bash / Shell)
  - `marksman` (Markdown)
  - `dockerls` (Docker)
  - `solargraph` (Ruby)
  - `kotlin_language_server` (Kotlin)
  - `terraformls` (Terraform)
  - `elixirls` (Elixir)
- **LSP Keymaps**:
  - `gd`: Go to definition.
  - `gr`: Go to references.
  - `gI`: Go to implementation.
  - `K`: Hover documentation.
  - `<leader>ca`: Code action.
  - `<leader>rn`: Rename symbol.
  - `gl` / `<leader>cd`: Show floating line diagnostic.
  - `[d` / `]d`: Previous / next diagnostic.
  - `<C-h>` (insert mode): Signature help.

### `hrsh7th/nvim-cmp`
- **Purpose**: Autocompletion engine.
- **Sources**: `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp-cmdline`, `cmp_luasnip`.
- **Snippets**: `L3MON4D3/LuaSnip` with `friendly-snippets` and custom C++ snippets from `lua/Snippets/cpp.lua`.
- **Keys**: `<Tab>` / `<S-Tab>` supertab navigation, `<CR>` confirm, `<C-Space>` trigger completion, `<C-f>` / `<C-b>` snippet jumps.
- **Cmdline**: `/` searches buffer history; `:` auto-completes Neovim commands and filesystem paths.

---

## 6. Formatting & Linting (`lua/plugins/formatting.lua`, `linting.lua`)

### `stevearc/conform.nvim`
- **Purpose**: Fast asynchronous code formatting with LSP fallback.
- **Keymap**: `<leader>lf` formats the entire buffer or visual selection.
- **Configured Formatters**:
  - C / C++: `clang-format`
  - Python: `isort`, `black`
  - Rust: `rustfmt`
  - Go: `gofmt`, `goimports`
  - JS / TS / HTML / CSS / JSON / YAML / Markdown: `prettierd`, `prettier`
  - TOML: `taplo`
  - Java: `google-java-format`
  - Kotlin: `ktlint`
  - Ruby: `standardrb`
  - Shell: `shfmt`, `beautysh`

### `mfussenegger/nvim-lint`
- **Purpose**: Asynchronous background linting.
- **Linters**: `shellcheck` (Shell), `ktlint` (Kotlin), `tflint` (Terraform).
- **Trigger**: Automatic on save/leave, manual with `<leader>ll`.

---

## 7. Git Integration (`lua/plugins/git.lua`)

### `lewis6991/gitsigns.nvim`
- **Purpose**: Git gutter signs, hunk staging, and inline blame.
- **Keymaps**:
  - `]c` / `[c`: Jump to next / previous git hunk.
  - `<leader>hs`: Stage hunk (normal & visual mode).
  - `<leader>hr`: Reset hunk.
  - `<leader>hp`: Preview hunk diff in floating popup.
  - `<leader>hb`: Blame line (detailed popup).
  - `<leader>htb`: Toggle live line blame annotations.
  - `<leader>hd`: Diff buffer against index.
  - `<leader>hD`: Diff buffer against previous commit.
  - `ih`: Text object for git hunk.

### `tpope/vim-fugitive` & `tpope/vim-rhubarb`
- **Keymap**: `<leader>gs` opens the Fugitive interactive Git panel.

### `sindrets/diffview.nvim` & `NeogitOrg/neogit`
- **Commands**: `:DiffviewOpen`, `:DiffviewClose`, `:Neogit`.

### `pwntester/octo.nvim`
- **Keymaps**: `<leader>Oo` opens Octo; `<leader>Op` lists GitHub PRs.

---

## 8. Testing & Debugging (`lua/plugins/testing.lua`, `dap.lua`)

### `nvim-neotest/neotest`
- **Adapters**: Go (`neotest-go`), Jest (`neotest-jest`), RSpec (`neotest-rspec`), Minitest, Elixir.
- **Keymaps**:
  - `<leader>tr`: Run nearest test.
  - `<leader>tf`: Run current test file.
  - `<leader>td`: Run test directory.
  - `<leader>tp`: Toggle test output panel.
  - `<leader>tl`: Run last test.
  - `<leader>ts`: Toggle test summary sidebar.

### `mfussenegger/nvim-dap` & `rcarriga/nvim-dap-ui`
- **Supported Adapters**: GDB (C/C++), Delve (Go), Ruby DAP.
- **Keymaps**:
  - `<leader>b`: Toggle breakpoint.
  - `<leader>B`: Set conditional breakpoint.
  - `<leader>dt` / `<leader>dc`: Start or continue debugging.
  - `<leader>dso`: Step over.
  - `<leader>dsi`: Step into.
  - `<leader>dsu`: Step out.
  - `<leader>dst`: Stop debugger.
  - `<leader>do`: Toggle DAP UI.
  - `<leader>dr`: Floating REPL.
  - `<leader>dsc`: Floating Scopes.
  - `<leader>df`: Floating Call Stack.

---

## 9. Competitive Programming (`lua/plugins/competitive.lua`)

### `xeluxee/competitest.nvim`
- **Browser Extension**: Works with [Competitive Companion](https://github.com/jmerle/competitive-companion) (default port `27121`).
- **Template**: Auto-populates `~/.config/nvim/templates/cp.cpp`.
- **Keymaps**:
  - `<leader>cl`: Listen for problems / contests parsed from browser.
  - `<leader>cr`: Save and run solution against all testcases in popup UI.
  - `<leader>cta`: Add manual testcase.
  - `<leader>cte`: Edit testcase.
  - `<leader>ctd`: Delete testcases.
  - `<leader>cs`: Auto-submit code to Codeforces via `cph-submit`.
  - `<leader>lc`: Listen for LeetCode problem via custom TCP listener.
  - `<leader>r`: QuickRun file against `input.txt`.

---

## 10. Notes & Documentation (`lua/plugins/markdown.lua`)

### `obsidian-nvim/obsidian.nvim`
- **Vault Location**: `/home/Anirudh/Obsidian Vault`.
- **Keymaps**:
  - `<leader>on`: Create new note.
  - `<leader>os`: Search notes in vault.
  - `<leader>oq`: Quick switch between notes.
  - `<leader>oo`: Open note in Obsidian desktop application.
  - `<leader>ob`: Show backlinks.
  - `<leader>ol`: Show links.
  - `<leader>oc`: Toggle markdown checkbox.
  - `<leader>ot`: Insert template.

### `MeanderingProgrammer/render-markdown.nvim`
- **Purpose**: Formats markdown headings, callout boxes, checkboxes, tables, and latex formulas inside the Neovim buffer.

### `iamcco/markdown-preview.nvim`
- **Command**: `:MarkdownPreviewToggle` opens a real-time browser preview.

---

## 11. Tools & Navigation (`lua/plugins/tools.lua`)

### `ThePrimeagen/harpoon` (Harpoon 2)
- **Keymaps**:
  - `<leader>a`: Add file to Harpoon list.
  - `<C-e>`: Toggle Harpoon interactive list menu.
  - `<C-t>`: Switch to File 1.
  - `<C-s>`: Switch to File 2.
  - `<C-y>`: Switch to File 3.
  - `<C-g>`: Switch to File 4.

### `nathom/tmux.nvim`
- **Keymaps**: `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` navigate seamlessly across Neovim splits and Tmux panes.

### `voldikss/vim-floaterm`
- **Keymaps**: `<leader>ft` opens floating terminal; `<leader>flt` toggles it.

### `AckslD/nvim-neoclip.lua`
- **Keymap**: `<leader>fy` opens clipboard and macro history in Telescope.

### `3rd/image.nvim` & `vhyrro/luarocks.nvim`
- **Purpose**: Inline image rendering for Kitty terminal via ImageMagick.

---

## 12. AI Assistants (`lua/plugins/ai.lua`)
- **Status**: Disabled by default (`enabled = false`) for Copilot, CopilotChat, Codeium, and GP.
- **Enabling**: Set `enabled = true` in `lua/plugins/ai.lua` if you ever wish to activate any of them in the future.
