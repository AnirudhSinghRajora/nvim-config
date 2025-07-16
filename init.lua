local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

require('exosyphon.globals')
require('exosyphon.remaps')
require('exosyphon.options')
vim.cmd("colorscheme tokyonight")
vim.cmd('hi IlluminatedWordText guibg=none gui=underline')
vim.cmd('hi IlluminatedWordRead guibg=none gui=underline')
vim.cmd('hi IlluminatedWordWrite guibg=none gui=underline')
require('nvim-highlight-colors').setup({
  enable_named_colors = false,
})
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/Snippets/" })
vim.opt.number = true           -- Enable absolute line numbers
vim.opt.relativenumber = true  -- Disable relative numbering
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" -- Set cursor shape
-- In your init.lua (or equivalent)



