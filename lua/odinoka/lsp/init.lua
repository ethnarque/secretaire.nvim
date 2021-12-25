local M = {}

function M.setup()
  local lsp_status_ok, lsp = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  require("null-ls").setup()

  lsp.sumneko_lua.setup {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          special = { reload = "require" },
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "odinoka" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            -- vim.api.nvim_get_runtime_file("", true),
            vim.fn.expand "$VIMRUNTIME",
            -- require("neodev.config").types(),
            "${3rd}/busted/library",
            "${3rd}/luassert/library",
          },
          maxPreload = 5000,
          preloadFileSize = 10000,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M
