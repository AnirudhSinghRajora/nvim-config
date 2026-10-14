return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          -- Core / Editors
          "lua", "vim", "vimdoc", "query", "regex", "diff",
          -- Git
          "git_config", "git_rebase", "gitcommit", "gitignore",
          -- Low-level & Systems
          "c", "cpp", "rust", "go", "gomod", "gosum", "gowork",
          -- JVM
          "java", "kotlin",
          -- Scripting
          "python", "ruby", "bash",
          -- Web & Frontend
          "javascript", "typescript", "tsx", "html", "css", "scss", "astro", "svelte",
          -- Data & Config formats
          "json", "json5", "jsonc", "yaml", "toml", "xml", "graphql", "proto", "sql",
          -- DevOps & Tools
          "dockerfile", "terraform", "hcl", "make", "cmake", "jq",
          -- Documentation
          "markdown", "markdown_inline",
          -- BEAM
          "elixir", "erlang", "heex", "eex",
        },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-CR>",
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sp"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>sP"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },

  -- Context header while scrolling long functions
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 5,
      on_attach = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        local excluded = { "markdown", "text", "help", "dashboard", "gitcommit" }
        return not vim.tbl_contains(excluded, ft)
      end,
    },
  },

  -- Auto-closing and auto-renaming of HTML/JSX/XML tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
}
