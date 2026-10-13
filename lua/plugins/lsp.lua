return {
  -- Neovim Lua API development tooling
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Java LSP support
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- Package manager for LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason Tool Installer for linters, formatters, and debug adapters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters & Linters
        "stylua",
        "clang-format",
        "prettier",
        "prettierd",
        "black",
        "isort",
        "goimports",
        "shfmt",
        "shellcheck",
        "beautysh",
        "google-java-format",
        "ktlint",
        "standardrb",
        "htmlbeautifier",
        "buf",
        "yamlfix",
        "taplo",
        "tflint",
        -- Debuggers
        "delve",
      },
    },
  },

  -- LSP Config & Mason Bridge
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Diagnostic display config
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Keymaps on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }

          local function map(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, vim.tbl_deep_extend("force", opts, { desc = "LSP: " .. desc }))
          end

          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gr", vim.lsp.buf.references, "Goto References")
          map("gI", vim.lsp.buf.implementation, "Goto Implementation")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<C-h>", vim.lsp.buf.signature_help, "Signature Help", "i")
          map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
          map("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
          map("<leader>d", vim.diagnostic.open_float, "Show Diagnostic")
          map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")

          -- Keep backward compatibility with exosyphon legacy keys
          map("<leader>vrr", vim.lsp.buf.references, "Goto References")
          map("<leader>vrn", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>vca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
          map("<leader>vd", vim.diagnostic.setloclist, "Diagnostic LocList")
        end,
      })

      -- Default capabilities enhanced with nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_nvim_lsp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Enable folding range capability for nvim-ufo
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lspconfig = require("lspconfig")

      -- Specific server configurations
      local servers = {
        -- C / C++
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },

        -- Rust
        rust_analyzer = {},

        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },

        -- JavaScript / TypeScript
        ts_ls = {},

        -- Web
        html = {},
        cssls = {},
        tailwindcss = {},
        astro = {},
        svelte = {},

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim", "P" },
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },

        -- Formats & Config
        jsonls = {},
        yamlls = {},
        taplo = {},
        bashls = {},
        marksman = {},
        dockerls = {},
        solargraph = {},
        kotlin_language_server = {},
        elixirls = {},
        terraformls = {},
      }

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            -- Only setup servers explicitly declared in our configuration
            if not servers[server_name] then
              return
            end
            local server_opts = servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
            lspconfig[server_name].setup(server_opts)
          end,
        },
      })
    end,
  },
}
