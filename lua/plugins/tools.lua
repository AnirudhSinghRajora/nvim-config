return {
  -- Harpoon file navigation (supports both Harpoon 1 and Harpoon 2 gracefully)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    config = function(_, opts)
      local ok, harpoon = pcall(require, "harpoon")
      if not ok then
        return
      end

      -- Call setup safely with a clean table (use dot notation to never pollute Harpoon 1 config)
      pcall(function()
        harpoon.setup(opts or {})
      end)

      -- Auto-detect Harpoon 2 vs Harpoon 1 API
      if type(harpoon.list) == "function" then
        -- Harpoon 2 API
        vim.keymap.set("n", "<leader>a", function()
          harpoon:list():add()
        end, { desc = "Harpoon: Add File" })
        vim.keymap.set("n", "<C-e>", function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon: Quick Menu" })

        vim.keymap.set("n", "<C-t>", function()
          harpoon:list():select(1)
        end, { desc = "Harpoon File 1" })
        vim.keymap.set("n", "<C-s>", function()
          harpoon:list():select(2)
        end, { desc = "Harpoon File 2" })
        vim.keymap.set("n", "<C-y>", function()
          harpoon:list():select(3)
        end, { desc = "Harpoon File 3" })
        vim.keymap.set("n", "<C-g>", function()
          harpoon:list():select(4)
        end, { desc = "Harpoon File 4" })
      else
        -- Harpoon 1 API fallback
        local mark_ok, mark = pcall(require, "harpoon.mark")
        local ui_ok, ui = pcall(require, "harpoon.ui")
        if mark_ok and ui_ok then
          vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Add File" })
          vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Quick Menu" })

          vim.keymap.set("n", "<C-t>", function()
            ui.nav_file(1)
          end, { desc = "Harpoon File 1" })
          vim.keymap.set("n", "<C-s>", function()
            ui.nav_file(2)
          end, { desc = "Harpoon File 2" })
          vim.keymap.set("n", "<C-y>", function()
            ui.nav_file(3)
          end, { desc = "Harpoon File 3" })
          vim.keymap.set("n", "<C-g>", function()
            ui.nav_file(4)
          end, { desc = "Harpoon File 4" })
        end
      end
    end,
  },

  -- Seamless tmux navigation
  {
    "nathom/tmux.nvim",
    config = function()
      local map = vim.keymap.set
      map("n", "<C-h>", function() require("tmux").move_left() end, { desc = "Navigate left window" })
      map("n", "<C-j>", function() require("tmux").move_down() end, { desc = "Navigate down window" })
      map("n", "<C-k>", function() require("tmux").move_up() end, { desc = "Navigate up window" })
      map("n", "<C-l>", function() require("tmux").move_right() end, { desc = "Navigate right window" })
    end,
  },

  -- Floating terminal
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
    config = function()
      vim.keymap.set(
        "n",
        "<leader>ft",
        "<cmd>:FloatermNew --height=0.7 --width=0.8 --wintype=float --name=floaterm1 --position=center --autoclose=2<CR>",
        { desc = "Open FloatTerm" }
      )
      vim.keymap.set("n", "<leader>flt", "<cmd>:FloatermToggle<CR>", { desc = "Toggle FloatTerm" })
      vim.keymap.set("t", "<leader>flt", "<cmd>:FloatermToggle<CR>", { desc = "Toggle FloatTerm" })
    end,
  },

  -- Clipboard & macro manager via Telescope (moved to <leader>fy to avoid conflict with Obsidian <leader>o)
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("neoclip").setup({
        history = 1000,
        enable_persistent_history = false,
        length_limit = 1048576,
        preview = true,
        default_register = '"',
        default_register_macros = "q",
        enable_macro_history = true,
      })
      vim.keymap.set("n", "<leader>fy", "<cmd>Telescope neoclip<CR>", { desc = "Find Yank History (Neoclip)" })
    end,
  },

  -- Luarocks & Image rendering
  {
    "vhyrro/luarocks.nvim",
    priority = 1001,
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "vhyrro/luarocks.nvim" },
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" },
            resolve_image_path = function(document_path, image_path, fallback)
              return fallback(document_path, image_path)
            end,
          },
          html = { enabled = false },
          css = { enabled = false },
        },
        max_height_window_percentage = 50,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
      })
    end,
  },

  -- Project configuration & Rails
  { "tpope/vim-projectionist" },
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
}
