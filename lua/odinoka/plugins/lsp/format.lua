local M = {}

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local has_null_ls_source = #require("null-ls.sources").get_available(
    ft,
    "NULL_LS_FORMATING"
  ) > 0

  vim.lsp.buf.format {
    bufnr = buf,
    filter = function(client)
      return client.name == "null-ls"
      -- if has_null_ls_source then
      --   return client.name == "null-ls"
      -- end
      -- return client.name ~= "null-ls"
    end,
  }

  -- vim.lsp.buf.format(vim.tbl_deep_extend("force", {
  --   bufnr = buf,
  --   filter = function(client)
  --     if has_null_ls_source then
  --       return client.name == "null-ls"
  --     end
  --     return client.name ~= "null-ls"
  --   end,
  -- }, {}))
end

function M.on_attach(client, buf)
  local augroup = vim.api.nvim_create_augroup("LspFormat" .. buf, {})

  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = buf }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = buf,
      callback = function()
        M.format()
      end,
    })
  end
end

return M
