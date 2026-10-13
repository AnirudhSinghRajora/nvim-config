return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  opts = {
    -- See configuration section for options
  },
  keys = {
    { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
    { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
    { "<leader>ccv", ":CopilotChatVisual ", mode = "x", desc = "CopilotChat - Open in vertical split" },
    { "<leader>ccx", ":CopilotChatInline<cr>", mode = "x", desc = "CopilotChat - Inline chat" },
  },
}
