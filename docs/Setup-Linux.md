# Linux Setup & Installation Guide

This guide provides step-by-step instructions for installing all system prerequisites, language toolchains, and optional tools for this Neovim configuration on Linux distributions (Debian/Ubuntu, Arch Linux, and Fedora/RHEL).

---

## 1. System Package Prerequisites

### Debian / Ubuntu / Pop!_OS / Linux Mint
```bash
sudo apt update
sudo apt install -y \
  build-essential git curl wget unzip tar \
  ripgrep fd-find xclip wl-clipboard \
  python3 python3-pip python3-venv \
  nodejs npm imagemagick kitty
```
> [!NOTE]
> On Ubuntu/Debian, `fd` is installed as `fdfind`. Symlink it to `fd` so Telescope and other tools find it immediately:
> ```bash
> mkdir -p ~/.local/bin
> ln -sf "$(command -v fdfind)" ~/.local/bin/fd
> ```
> Ensure `~/.local/bin` is in your `$PATH` (e.g., in `~/.bashrc` or `~/.zshrc`: `export PATH="$HOME/.local/bin:$PATH"`).

### Arch Linux / Manjaro
```bash
sudo pacman -Syu --needed \
  base-devel git curl wget unzip tar \
  ripgrep fd xclip wl-clipboard \
  python python-pip \
  nodejs npm imagemagick kitty
```

### Fedora / RHEL
```bash
sudo dnf install -y \
  @development-tools git curl wget unzip tar \
  ripgrep fd-find xclip wl-clipboard \
  python3 python3-pip \
  nodejs npm ImageMagick kitty
```

---

## 2. Clipboard Integration

To enable system clipboard copy (`<leader>y`, `<leader>Y`) and paste (`<leader>p`) out-of-the-box:
- **X11 display server**: Ensure `xclip` or `xsel` is installed.
- **Wayland display server**: Ensure `wl-clipboard` is installed.

Neovim automatically detects which provider is present.

---

## 3. Font (Nerd Font)

Icons in Neo-tree, Lualine, Bufferline, and Which-Key require a Nerd Font.
Recommended fonts:
- **JetBrains Mono Nerd Font** (Recommended)
- **FiraCode Nerd Font**

Download and install via:
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
fc-cache -fv
```
Then configure your terminal emulator (e.g. Kitty, Alacritty, GNOME Terminal) to use `JetBrainsMono Nerd Font`.

---

## 4. Language Toolchains

Install the compilers and runtimes for the languages you use:

### C / C++
```bash
# Debian / Ubuntu
sudo apt install -y gcc g++ clang clang-tools clang-format gdb

# Arch Linux
sudo pacman -S --needed gcc clang gdb

# Fedora
sudo dnf install -y gcc gcc-c++ clang clang-tools-extra gdb
```
`clangd` is used as the language server with competitive programming flags configured in `lua/plugins/lsp.lua`. `gdb` is configured as the default debugger in `lua/plugins/dap.lua`.

### Python
```bash
# Ubuntu 24.04+ / Debian (PEP 668 managed environments)
sudo apt install -y python3 python3-venv python3-pip
```
Mason installs `pyright` (LSP), `black` (formatter), and `isort` (import sorter).

### Rust
Install Rust and Cargo via rustup:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup component add rustfmt rust-analyzer
```

### Go
```bash
# Debian / Ubuntu
sudo apt install -y golang-go

# Arch Linux
sudo pacman -S --needed go

# Fedora
sudo dnf install -y golang
```
Mason installs `gopls` (LSP), `goimports` (formatter), and `delve` (`dlv` debugger). Note: `gofmt` is included natively in the Go toolchain.

### Java (JDK 17+)
JDTLS requires Java 17 or newer:
```bash
# Debian / Ubuntu
sudo apt install -y openjdk-17-jdk

# Arch Linux
sudo pacman -S --needed jdk17-openjdk

# Fedora
sudo dnf install -y java-17-openjdk-devel
```
The configuration in `ftplugin/java.lua` is pre-configured to use Mason's Linux configuration:
`~/.local/share/nvim/mason/packages/jdtls/config_linux`.

### Ruby & Rails
```bash
# Debian / Ubuntu
sudo apt install -y ruby-full

# Arch Linux
sudo pacman -S --needed ruby

# Fedora
sudo dnf install -y ruby ruby-devel
```
Mason provides `solargraph` (LSP) and `standardrb` (formatter/linter). `vim-rails` and `vim-projectionist` are configured in `lua/plugins/tools.lua`.

---

## 5. First-Time Neovim Bootstrap

1. **Launch Neovim**:
   ```bash
   nvim
   ```
   On first launch, `lazy.nvim` automatically clones itself and starts downloading all configured plugins.

2. **Wait for Mason Tool Installer**:
   `mason-tool-installer` will automatically trigger in the background and download all configured language servers, formatters, linters, and debug adapters:
   - **LSPs**: `clangd`, `pyright`, `rust_analyzer`, `gopls`, `ts_ls`, `html`, `cssls`, `tailwindcss`, `astro`, `svelte`, `lua_ls`, `jsonls`, `yamlls`, `taplo`, `bashls`, `marksman`, `dockerls`, `solargraph`, `kotlin_language_server`, `elixirls`, `terraformls`.
   - **Formatters & Linters**: `stylua`, `clang-format`, `prettier`, `prettierd`, `black`, `isort`, `goimports`, `shfmt`, `shellcheck`, `beautysh`, `google-java-format`, `ktlint`, `standardrb`, `htmlbeautifier`, `buf`, `yamlfix`, `taplo`, `tflint`.
   - **Debuggers**: `delve`.

   You can monitor the status at any time by running:
   ```vim
   :Mason
   ```

3. **Verify Health**:
   Run the built-in health check to confirm all providers and dependencies are recognized:
   ```vim
   :checkhealth
   ```

---

## 6. Specific Plugin Integrations

### Obsidian Notes
- The vault directory is configured at:
  `/home/Anirudh/Obsidian Vault`
- Install the official Obsidian desktop app (via AppImage, Flatpak, or deb package) from [obsidian.md](https://obsidian.md) to enable opening notes directly with `<leader>oo`.

### Competitive Programming
- **CompetiTest (`lua/plugins/competitive.lua`)**:
  - Automatically compiles C++ files using:
    `g++ -std=c++17 -O2 -Wall -Wextra -DLOCAL ...`
  - Binaries are stored in `compitest/bins/` and test case files in `compitest/tc/`.
- **Browser Companion Extensions**:
  - Install **Competitive Companion** in your browser (Firefox / Chrome).
  - In its settings, set the listening port to `27121`.
  - In Neovim, press `<leader>cl` to start listening for contest/problem parsing.
- **Codeforces Auto-Submit**:
  - Install **cph-submit** browser extension.
  - In Neovim, press `<leader>cs` on a problem file containing `// URL: https://codeforces.com/...`.
- **LeetCode Integration**:
  - Press `<leader>lc` to start the custom TCP listener on port 27121 for LeetCode problem parsing.

### Image Rendering (`image.nvim`)
- Configured in `lua/plugins/tools.lua` using the Kitty backend.
- Requires:
  1. Kitty terminal emulator (`sudo apt install kitty`).
  2. System ImageMagick (`sudo apt install imagemagick`).
  3. `luarocks.nvim` automatically builds the `magick` Lua module.
- Running Neovim inside Kitty enables inline image rendering for markdown files.

### Markdown Preview (`markdown-preview.nvim`)
- Automatically opens rendered markdown in your default web browser.
- Uses Yarn/Node to build its server package automatically during lazy installation.
- Commands: `:MarkdownPreview`, `:MarkdownPreviewStop`, `:MarkdownPreviewToggle`.
