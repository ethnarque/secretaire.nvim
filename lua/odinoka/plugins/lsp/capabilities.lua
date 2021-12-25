local M = {}

function M.common_capabilities()
  local status_cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
  if not status_cmp_ok then
    print "nvim-cmp plugin is not available, LSP started with limited capabilities..."
    return
  end

  local capabilities =
    cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }


	return capabilities
end

return M
