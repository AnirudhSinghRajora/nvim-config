return {
  "github/copilot.vim",
  config = function()
    -- Completely disable inline ghost text for all filetypes
    vim.g.copilot_filetypes = {
      ["*"] = false,
    }
    
    -- Ensure the default tab mapping is also disabled to prevent conflicts
    vim.g.copilot_no_tab_map = true
  end,
}
