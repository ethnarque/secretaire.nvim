local capabilities = require "odinoka.plugins.lsp.capabilities"

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    opts = {
      servers = {
        rnix = {},
        jsonls = {},
        sumneko_lua = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
    config = function(plugin, opts)
      if plugin.servers then
        require("lazyvim.util").deprecate("lspconfig.servers", "lspconfig.opts.servers")
      end
      if plugin.setup_server then
        require("lazyvim.util").deprecate("lspconfig.setup_server", "lspconfig.opts.setup[SERVER]")
      end

      -- Attaching formatting and keymaps settings for each buffers
      require("odinoka.plugins.lsp.utils").common_on_attach(function(client, buf)
        require("odinoka.plugins.lsp.format").on_attach(client, buf)
        require("odinoka.plugins.lsp.keymaps").on_attach(client, buf)
      end)

      -- local servers = vim.tbl_deep_extend("force", opts.servers, odinoka.builtins.lsp.servers)
      local servers = opts.servers

      local mason_lsp = require "mason-lspconfig"

      mason_lsp.setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      }

      mason_lsp.setup_handlers {
        function(server)
          local server_opts = servers[server] or {}

          server_opts.capabilities = capabilities.common_capabilities()

          require("neodev").setup()
          require("lspconfig")[server].setup(server_opts)
        end,
      }
    end,
  },

  --   -- Formatters / Linters / Code Actions
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require "null-ls"

      local sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.alejandra,
      }

      return { sources = sources }
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = { automatic_installation = true },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = { "alejandra", "stylua", "prettierd" },
    },
    config = function(_, opts)
      require("mason-null-ls").setup(opts)
    end,
  },
}
