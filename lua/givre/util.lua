local M = {}

---@param group string
---@param color table<string, GivreColor>
function M.highlight(group, color)
    local fg = color.fg or 'none'
    local bg = color.bg or 'none'
    local sp = color.sp or ''

    color = vim.tbl_extend('force', color, { fg = fg, bg = bg, sp = sp })
    vim.api.nvim_set_hl(0, group, color)
end

return M
