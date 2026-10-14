-- Editor Options (single source of truth for global editor behavior)

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Cursor
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Tabs & indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search (ignorecase MUST be enabled for smartcase to take effect)
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- Line wrapping
vim.opt.wrap = false

-- Window splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Undo & swap (Neovim automatically manages stdpath("state") .. "/undo")
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Appearance
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 2

-- Misc
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 200
