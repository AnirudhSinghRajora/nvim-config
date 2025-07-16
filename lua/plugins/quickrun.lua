-- ~/path/to/your/plugins/folder/quickrun.lua

return {
  "thinca/vim-quickrun",
  config = function()
    -- Optional: Quickrun configuration
    -- Example: Set a keymap to quickly run code with a specific input file
    vim.api.nvim_set_keymap('n', '<Leader>r', ':QuickRun -input input.txt<CR>', { noremap = true, silent = true })
  end
}

