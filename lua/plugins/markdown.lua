return {
  -- Obsidian integration
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    cmd = {
      "ObsidianBacklinks",
      "ObsidianFollowLink",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianLinks",
      "ObsidianNew",
      "ObsidianOpen",
      "ObsidianQuickSwitch",
      "ObsidianRename",
      "ObsidianSearch",
      "ObsidianTemplate",
      "ObsidianToday",
      "ObsidianTomorrow",
      "ObsidianYesterday",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "ObsidianVault",
            path = "/home/Anirudh/Obsidian Vault",
          },
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        new_notes_location = "notes_subdir",
        note_id_func = function(title)
          return title
        end,
        note_frontmatter_func = function(note)
          local out = { id = note.id, aliases = note.aliases, tags = note.tags }
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
        mappings = {},
        templates = {
          subdir = "Templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
          tags = "",
          substitutions = {
            yesterday = function()
              return os.date("%Y-%m-%d", os.time() - 86400)
            end,
            tomorrow = function()
              return os.date("%Y-%m-%d", os.time() + 86400)
            end,
          },
        },
        ui = {
          enable = false, -- using render-markdown.nvim instead
        },
      })
    end,
  },

  -- Markdown rendered in buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  },

  -- Markdown browser preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Prose writing helper
  { "preservim/vim-pencil", ft = { "markdown", "text" } },
}
