local function toggle_floaterm(name, wintype, position, size_key, size_val, create_cmd)
  local ok, bufnr = pcall(vim.fn["floaterm#terminal#get_bufnr"], name)
  if ok and bufnr and bufnr ~= -1 then
    pcall(function()
      vim.b[bufnr].floaterm_wintype = wintype
      vim.b[bufnr].floaterm_position = position
      vim.b[bufnr][size_key] = size_val
    end)
    local is_visible = (vim.fn.bufwinnr(bufnr) ~= -1)
    if is_visible then
      vim.cmd("FloatermHide " .. name)
    else
      vim.cmd("FloatermShow " .. name)
    end
  else
    vim.cmd(create_cmd)
  end
end

local toggle_vterm = function()
  toggle_floaterm(
    "vterm",
    "vsplit",
    "right",
    "floaterm_width",
    0.35,
    "FloatermNew --wintype=vsplit --position=right --width=0.35 --name=vterm"
  )
end

local toggle_hterm = function()
  toggle_floaterm(
    "hterm",
    "split",
    "bottom",
    "floaterm_height",
    0.35,
    "FloatermNew --wintype=split --position=bottom --height=0.35 --name=hterm"
  )
end

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

  -- Floating & Split Terminal
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext", "FloatermUpdate", "FloatermHide", "FloatermShow" },
    keys = {
      {
        "<leader>ft",
        "<cmd>FloatermNew --height=0.7 --width=0.8 --wintype=float --name=floaterm1 --position=center --autoclose=2<CR>",
        desc = "Open Floating Terminal",
      },
      { "<leader>flt", "<cmd>FloatermToggle<CR>", desc = "Toggle Floating Terminal" },
      { "<leader>flt", "<cmd>FloatermToggle<CR>", mode = "t", desc = "Toggle Floating Terminal" },
      { "<leader>fn", "<cmd>FloatermNext<CR>", desc = "Next Terminal" },
      { "<leader>fn", "<cmd>FloatermNext<CR>", mode = "t", desc = "Next Terminal" },
      { "<M-n>", "<cmd>FloatermNext<CR>", desc = "Next Terminal" },
      { "<M-n>", "<C-\\><C-n><cmd>FloatermNext<CR>", mode = "t", desc = "Next Terminal" },
      { "<leader>fp", "<cmd>FloatermPrev<CR>", desc = "Prev Terminal" },
      { "<leader>fp", "<cmd>FloatermPrev<CR>", mode = "t", desc = "Prev Terminal" },
      { "<M-p>", "<cmd>FloatermPrev<CR>", desc = "Prev Terminal" },
      { "<M-p>", "<C-\\><C-n><cmd>FloatermPrev<CR>", mode = "t", desc = "Prev Terminal" },
      { "<leader>fv", toggle_vterm, desc = "Toggle Right Vertical Terminal (35%)" },
      { "<leader>fv", toggle_vterm, mode = "t", desc = "Toggle Right Vertical Terminal (35%)" },
      { "<leader>tv", toggle_vterm, desc = "Toggle Right Vertical Terminal (35%)" },
      { "<leader>tv", toggle_vterm, mode = "t", desc = "Toggle Right Vertical Terminal (35%)" },
      { "<leader>fh", toggle_hterm, desc = "Toggle Bottom Horizontal Terminal (VSCode style)" },
      { "<leader>fh", toggle_hterm, mode = "t", desc = "Toggle Bottom Horizontal Terminal (VSCode style)" },
      { "<leader>th", toggle_hterm, desc = "Toggle Bottom Horizontal Terminal (VSCode style)" },
      { "<leader>th", toggle_hterm, mode = "t", desc = "Toggle Bottom Horizontal Terminal (VSCode style)" },
    },
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
