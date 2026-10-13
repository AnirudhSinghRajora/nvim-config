return {
  -- Which-key helper
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {
      preset = "modern",
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      spec = {
        { "<leader>f", group = "Find / Telescope" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunks" },
        { "<leader>c", group = "Code / Competitive" },
        { "<leader>d", group = "Debug (DAP)" },
        { "<leader>t", group = "Test (Neotest)" },
        { "<leader>o", group = "Obsidian" },
        { "<leader>u", group = "UI / Undo / Colors" },
        { "<leader>l", group = "Format / Lint" },
        { "<leader>s", group = "Swap / Search" },
        { "<leader>v", group = "LSP Legacy / Config" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if wk.add then
        wk.add(opts.spec or {})
      elseif wk.register then
        wk.register({
          f = { name = "Find / Telescope" },
          g = { name = "Git" },
          h = { name = "Git Hunks" },
          c = { name = "Code / Competitive" },
          d = { name = "Debug (DAP)" },
          t = { name = "Test (Neotest)" },
          o = { name = "Obsidian" },
          u = { name = "UI / Undo / Colors" },
          l = { name = "Format / Lint" },
          s = { name = "Swap / Search" },
          v = { name = "LSP Legacy / Config" },
        }, { prefix = "<leader>" })
      end
    end,
  },

  -- Oil (file manager like a buffer)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
          end,
        },
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
        },
        win_options = {
          wrap = true,
          winblend = 0,
        },
        keymaps = {
          ["<C-c>"] = false,
          ["q"] = "actions.close",
        },
      })
    end,
  },

  -- Neo-tree file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
        },
      })
    end,
  },

  -- Flash navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      jump = {
        autojump = true,
      },
      modes = {
        char = {
          jump_labels = true,
          multi_line = false,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Surrounding selections
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Easy commenting
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Multi-cursor
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_mouse_mappings = 0
      vim.g.VM_maps = {
        ["Add Cursor At Pos"] = "<M-LeftMouse>",
      }
      vim.keymap.set("n", "<M-LeftMouse>", "<LeftMouse><Plug>(VM-Add-Cursor-At-Pos)", { desc = "VM: Add Cursor At Click" })
    end,
  },

  -- Marks management
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("marks").setup({
        default_mappings = true,
      })
    end,
  },

  -- Undo history visualizer
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>Telescope undo<CR>", desc = "Telescope Undo" },
      { "<leader>uU", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
      { "<leader>U", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
    },
  },

  -- Bracket mappings pair navigation
  {
    "tummetott/unimpaired.nvim",
    event = "VeryLazy",
    config = function()
      require("unimpaired").setup()
    end,
  },

  -- Dot-repeat for complex plugins
  { "tpope/vim-repeat", event = "VeryLazy" },
}
