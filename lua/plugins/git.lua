return {
  -- Git integration and signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Next Git Hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Prev Git Hunk" })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Git: Stage Hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Git: Reset Hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Git: Stage Selected Hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Git: Reset Selected Hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Git: Stage Buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git: Undo Stage Hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Git: Reset Buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Git: Preview Hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Git: Blame Line" })
          map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "Git: Toggle Line Blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Git: Diff This" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Git: Diff Against ~" })
          map("n", "<leader>htd", gs.toggle_deleted, { desc = "Git: Toggle Deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: Select Hunk" })
        end,
      })
    end,
  },

  -- Fugitive
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>", desc = "Open Fugitive Panel" },
    },
  },

  -- GitHub fugitive extension
  { "tpope/vim-rhubarb", dependencies = { "tpope/vim-fugitive" } },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Neogit
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },

  -- GitHub PR & Issue integration
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        enable_builtin = true,
        use_local_fs = true,
      })
      vim.cmd([[hi OctoEditable guibg=none]])
      pcall(function() vim.treesitter.language.register("markdown", "octo") end)
    end,
    keys = {
      { "<leader>O", "<cmd>Octo<cr>", desc = "Octo" },
      { "<leader>Op", "<cmd>Octo pr list<cr>", desc = "Octo PR List" },
    },
  },
}
