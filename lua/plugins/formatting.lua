return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          go = { "goimports" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          svelte = { "prettierd", "prettier", stop_after_first = true },
          astro = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          jsonc = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "yamlfix", "prettier", stop_after_first = true },
          toml = { "taplo" },
          html = { "htmlbeautifier", "prettier", stop_after_first = true },
          erb = { "htmlbeautifier" },
          css = { "prettierd", "prettier", stop_after_first = true },
          scss = { "prettierd", "prettier", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          graphql = { "prettierd", "prettier", stop_after_first = true },
          java = { "google-java-format" },
          kotlin = { "ktlint" },
          ruby = { "standardrb" },
          bash = { "shfmt", "beautysh", stop_after_first = true },
          sh = { "shfmt", "beautysh", stop_after_first = true },
          proto = { "buf" },
          xml = { "xmllint" },
        },
      })

      -- Format keymap (<leader>lf; removed bare <leader>l to eliminate 500ms prefix stall)
      local format_fn = function()
        conform.format({
          lsp_format = "fallback",
          async = false,
          timeout_ms = 1000,
        })
      end

      vim.keymap.set({ "n", "v" }, "<leader>lf", format_fn, { desc = "Format file or range" })
    end,
  },
}
