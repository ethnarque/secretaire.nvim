local M = {}

function M.on_attach(client, buf)
  local self = M.new(client, buf)

  self:map("<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
  self:map("<leader>cl", "LspInfo", { desc = "Lsp Info" })

  local status_treesitter_ok = pcall(require, "telescope")
  if status_treesitter_ok then
    self:map("gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
    self:map("gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
    self:map("gr", "Telescope lsp_references", { desc = "References" })
    self:map("gI", "Telescope lsp_implementations", { desc = "Goto Implementation" })
    self:map("gt", "Telescope lsp_type_definitions", { desc = "Goto Type Definition" })
    self:map("K", vim.lsp.buf.hover, { desc = "Hover" })
    self:map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })
    self:map("<c-k>", vim.lsp.buf.signature_help, { mode = "i", desc = "Signature Help", has = "signatureHelp" })
    self:map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })

    local format = require("odinoka.plugins.lsp.format").format
    self:map("<leader>cf", format, { desc = "Format Document", has = "documentFormatting" })
    self:map("<leader>cf", format, { desc = "Format Range", mode = "v", has = "documentRangeFormatting" })
    self:map("<leader>cr", M.rename, { expr = true, desc = "Rename", has = "rename" })
  end
end

function M.new(client, buf)
  return setmetatable({ client = client, buffer = buf }, { __index = M })
end

function M:has(cap)
  return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lts, rhs, opts)
  opts = opts or {}

  vim.keymap.set(
    opts.mode or "n",
    lts,
    type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,

    { silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
  )
end
function M.rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand "<cword>"
  else
    vim.lsp.buf.rename()
  end
end

return M
