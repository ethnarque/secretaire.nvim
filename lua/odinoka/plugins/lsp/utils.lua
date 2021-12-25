local M = {}

function M.common_capabilities()
  local status_cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
  if status_cmp_ok then
    return cmp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  return capabilities
end

---@param  on_attach fun(client, bufnr)
function M.common_on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buf = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buf)
    end,
  })
  --
end

return M
