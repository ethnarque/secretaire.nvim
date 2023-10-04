---@alias GivreVariant "dark" | "light"
---@alias GivreColor { fg: string, bg: string, sp: string, bold: boolean, italic: boolean, undercurl: boolean, underline: boolean, underdouble: boolean, underdotted: boolean, underdashed: boolean, strikethrough: boolean }

local M = {}

---@class GivreOptions
M.options = {
    ---@type "auto" | GivreVariant
    variant = "auto",

    highlight_groups = {},

}

---@param options GivreColor|nil
function M.extend(options)
    M.options = vim.tbl_deep_extend("force", M.options, options or {})
end

return M
