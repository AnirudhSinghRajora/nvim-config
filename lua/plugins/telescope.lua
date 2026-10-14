return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VimEnter",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "debugloop/telescope-undo.nvim",
      "aaronhallaert/advanced-git-search.nvim",
      "nanotee/zoxide.vim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      local telescopeConfig = require("telescope.config")

      -- Keymaps (<leader>fH for Help Tags so <leader>fh stays dedicated to Floaterm)
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set(
        "n",
        "<leader>fg",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        { desc = "Live Grep" }
      )
      vim.keymap.set(
        "n",
        "<leader>fc",
        '<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!*{spec,test}*" })<CR>',
        { desc = "Live Grep Code" }
      )
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fH", builtin.help_tags, { desc = "Find Help Tags" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
      vim.keymap.set("n", "<leader>fi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search Git Commits" })
      vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, { desc = "Search Git Commits for Buffer" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })

      local colorscheme_picker = function()
        builtin.colorscheme({ enable_preview = true })
      end
      vim.keymap.set("n", "<leader>uc", colorscheme_picker, { desc = "Colorscheme Preview" })
      vim.keymap.set("n", "<leader>uC", colorscheme_picker, { desc = "Colorscheme Preview" })

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
          layout_config = { width = 0.7 },
        }))
      end, { desc = "Fuzzily search current buffer" })

      -- Grep arguments with hidden files support (excluding .git)
      local unpack_fn = table.unpack or unpack
      local vimgrep_arguments = { unpack_fn(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      -- Find command detection: prefer fd/fdfind, fallback to rg
      local find_command = nil
      if vim.fn.executable("fd") == 1 then
        find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
      elseif vim.fn.executable("fdfind") == 1 then
        find_command = { "fdfind", "--type", "f", "--hidden", "--exclude", ".git" }
      elseif vim.fn.executable("rg") == 1 then
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
      end

      local select_one_or_multi = function(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          actions.close(prompt_bufnr)
          for _, j in pairs(multi) do
            local path = j.path or j.filename
            if path ~= nil then
              vim.cmd("edit " .. vim.fn.fnameescape(path))
            end
          end
        else
          actions.select_default(prompt_bufnr)
        end
      end

      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
          path_display = { "truncate" },
          mappings = {
            n = {
              ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            i = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
              ["<CR>"] = select_one_or_multi,
              ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-S-d>"] = actions.delete_buffer,
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
        extensions = {
          undo = {
            use_delta = true,
            side_by_side = false,
            entry_format = "state #$ID, $STAT, $TIME",
            mappings = {
              i = {
                ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<cr>"] = require("telescope-undo.actions").restore,
              },
            },
          },
        },
      })

      -- Load extensions safely
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
      pcall(telescope.load_extension, "undo")
      pcall(telescope.load_extension, "advanced_git_search")
      pcall(telescope.load_extension, "live_grep_args")
      pcall(telescope.load_extension, "noice")
      pcall(telescope.load_extension, "neoclip")

      vim.g.zoxide_use_select = true
    end,
  },
}
