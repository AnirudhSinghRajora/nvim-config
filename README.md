# Neovim Configuration

A clean, modular, high-performance Neovim configuration built for general-purpose software development, competitive programming, and note-taking.

---

## 📁 Architecture Overview

```
~/.config/nvim/
├── init.lua                  # Bootstrap lazy.nvim, leader keys, and module loader
├── lua/
│   ├── core/
│   │   ├── globals.lua       # Global helper utilities (e.g. P() inspect printer)
│   │   ├── options.lua       # Single source of truth for all editor options
│   │   ├── treesitter_compat.lua # Neovim 0.12+ Tree-sitter compatibility shim
│   │   └── keymaps.lua       # Editor-native keymaps, window navigation, visual edits
│   │
│   ├── plugins/              # 100% modular plugin specifications (one domain per file)
│   │   ├── ai.lua            # AI assistants (all disabled by default per preference)
│   │   ├── cmp.lua           # nvim-cmp completion engine, cmdline, and snippets
│   │   ├── colorscheme.lua   # Tokyonight (transparent), Catppuccin, Gruvbox
│   │   ├── competitive.lua   # CompetiTest, QuickRun, LeetCode receiver, Codeforces submit
│   │   ├── dap.lua           # Debug Adapter Protocol (DAP), DAP UI, GDB/C++, Go, Ruby
│   │   ├── editor.lua        # Oil, Neo-tree, Which-Key, Flash, Surround, Autopairs, etc.
│   │   ├── formatting.lua    # Conform.nvim formatters for all languages
│   │   ├── git.lua           # Gitsigns, Fugitive, Neogit, Diffview, Octo
│   │   ├── linting.lua       # nvim-lint linters
│   │   ├── lsp.lua           # Mason, Mason-LSPConfig, Mason-Tool-Installer, nvim-lspconfig
│   │   ├── markdown.lua      # Obsidian.nvim, render-markdown, markdown-preview, pencil
│   │   ├── telescope.lua     # Fuzzy finder with live grep, undo, fzf native, and extensions
│   │   ├── testing.lua       # Neotest with Jest, Go, RSpec, Minitest, Elixir adapters
│   │   ├── tools.lua         # Harpoon, Tmux navigation, Floaterm, Neoclip, Image.nvim
│   │   ├── treesitter.lua    # Syntax highlighting for all languages with auto_install=true
│   │   └── ui.lua            # Dashboard, Lualine, Bufferline, Noice, UFO folding, Indent
│   │
│   └── Snippets/
│       └── cpp.lua           # Custom competitive programming snippets
│
├── ftplugin/                 # Filetype-specific configurations
│   ├── go.lua                # Go indentation and formatting options
│   ├── java.lua              # JDTLS configuration (cross-platform)
│   └── lua.lua               # Lua 2-space indentation matching .stylua.toml
└── templates/
    └── cp.cpp                # Competitive programming starter template
```

---

## 🛠️ Adding & Modifying Plugins

Adding a new plugin is as simple as creating or modifying a file in `lua/plugins/`:
1. Find the appropriate domain file (e.g., `editor.lua` or create a new `myplugin.lua`).
2. Add your plugin spec returning a table:
   ```lua
   return {
     {
       "author/repository",
       event = "VeryLazy",
       opts = {},
     },
   }
   ```
3. Lazy will automatically detect the new file on next launch.

---

## ⌨️ Keybindings Cheat Sheet

### Leader Key
Leader is set to `<Space>`.

### Navigation & Files
- `-` : Open parent directory in Oil (float)
- `<C-b>` : Toggle Neo-tree file tree
- `<leader>ff` : Find files (Telescope)
- `<leader>fg` : Live grep (Telescope)
- `<leader>fc` : Live grep code (excluding test/spec files)
- `<leader>fb` : Switch open buffers
- `<leader>fo` : Recent / old files
- `<leader>fs` : LSP document symbols
- `<leader>Z` : Zoxide directory jumper
- `<leader>uu` : Visual undo tree (Telescope undo)
- `<leader>uU` : Toggle Undotree window
- `<leader>fy` : Yank history (Neoclip)

### Harpoon
- `<leader>a` : Mark file in Harpoon
- `<C-e>` : Toggle Harpoon quick menu
- `<C-t>` : Navigate to Harpoon file 1
- `<C-s>` : Navigate to Harpoon file 2
- `<C-y>` : Navigate to Harpoon file 3
- `<C-g>` : Navigate to Harpoon file 4

### Quickfix & Location Lists
- `]q` / `[q` : Next / previous quickfix item (centered)
- `]l` / `[l` : Next / previous location list item (centered)

### Editing & Visual Mode
- `jj` : Quick escape from Insert mode
- `==` : Select all buffer text
- `<A-Down>` / `<A-Up>` : Move current line down / up
- `<A-S-Down>` / `<A-S-Up>` : Duplicate current line down / up
- `J` / `K` (visual mode) : Move selected block down / up
- `<` / `>` (visual mode) : Indent / unindent staying in visual mode
- `<leader>sr` : Search & replace word under cursor across buffer
- `<leader>lf` : Format buffer or visual selection (Conform)
- `<leader>ll` : Trigger linter (nvim-lint)

### LSP (Language Server Protocol)
- `gd` : Go to definition
- `gr` : Go to references
- `gI` : Go to implementation
- `K` : Hover documentation
- `<leader>ca` : Code action
- `<leader>rn` : Rename symbol
- `gl` / `<leader>cd` : Show floating line diagnostic
- `[d` / `]d` : Previous / next diagnostic
- `<C-h>` (insert mode) : Signature help

### Git
- `<leader>gs` : Fugitive Git status panel
- `]c` / `[c` : Jump to next / previous Git hunk
- `<leader>hs` : Stage hunk
- `<leader>hr` : Reset hunk
- `<leader>hp` : Preview hunk
- `<leader>hb` : Blame line
- `<leader>htb` : Toggle live git blame
- `<leader>hd` : Diff this file
- `<leader>Oo` : Octo (GitHub issues / PRs)

### Competitive Programming
- `<leader>cl` : Listen for problems via Competitive Companion browser extension
- `<leader>cr` : Save & run all testcases with CompetiTest
- `<leader>cta` : Add testcase manually
- `<leader>cte` : Edit testcase
- `<leader>ctd` : Delete testcases
- `<leader>cs` : Auto-submit to Codeforces via cph-submit extension
- `<leader>lc` : Listen for LeetCode problem
- `<leader>r` : QuickRun current file with `input.txt`
- `<leader>ci` : Open `input.txt` split

### Obsidian Notes
- Vault Path: `/home/Anirudh/Obsidian Vault`
- `<leader>on` : Create new note
- `<leader>os` : Search notes
- `<leader>oq` : Quick switch note
- `<leader>oo` : Open current note in Obsidian desktop app
- `<leader>ob` : Show backlinks
- `<leader>ol` : Show links
- `<leader>oc` : Toggle markdown checkbox
- `<leader>ot` : Insert template

### Tmux & Window Splits
- `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` : Seamless window & tmux split navigation
- `<leader>ft` : Floating terminal (Floaterm)
- `<leader>flt` : Toggle floating terminal
- `<leader>fh` / `<leader>th` : Toggle bottom horizontal terminal
- `<leader>fH` : Find help tags (Telescope)

---

## 📚 Documentation

- [Linux Setup & Installation Guide](file:///home/Anirudh/.config/nvim/docs/Setup-Linux.md) — System package prerequisites, toolchains, fonts, and platform-specific configurations.
- [Vim & Plugins Cheatsheet](file:///home/Anirudh/.config/nvim/docs/Vim-Cheatsheet.md) — Comprehensive guide to all keymaps, motions, LSP actions, and debug workflows.
- [Plugin Architecture Reference](file:///home/Anirudh/.config/nvim/docs/Plugins.md) — Detailed specifications, roles, and load conditions for every installed plugin.
