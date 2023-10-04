local M = {}

---@param options GivreOptions
function M._load(options)
    local h = require("givre.util").highlight
    local p = require("givre.palette")

    M.defaults = {
        --- Editor
        ['ColorColumn']                = {},
        ['Conceal']                    = {},
        ['CurSearch']                  = { link = 'IncSearch' },
        ['Cursor']                     = {},
        ["CursorColumn"]               = { bg = p.gray1 },
        ["CursorColumnSign"]           = { bg = p.gray1 },
        -- CursorIM = {},
        ["CursorLine"]                 = { bg = p.gray2 },
        ["CursorLineNr"]               = {},
        ["CursorLineSign"]             = {},
        ['DiffAdd']                    = {},
        ['DiffChange']                 = {},
        ['DiffDelete']                 = {},
        ['DiffText']                   = {},
        ['diffAdded']                  = { link = "DiffAdd" },
        ['diffChanged']                = { link = 'DiffChange' },
        ['diffRemoved']                = { link = 'DiffDelete' },
        ['Directory']                  = {},
        ["EndOfBuffer"]                = { fg = p.gray1 },
        ['ErrorMsg']                   = {},
        ['FloatBorder']                = {},
        ['FloatTitle']                 = {},
        ['FoldColumn']                 = {},
        ['Folded']                     = {},
        ['IncSearch']                  = {},
        ["LineNr"]                     = { fg = p.gray5 },
        ['MatchParen']                 = {},
        ['ModeMsg']                    = {},
        ['MoreMsg']                    = {},
        ['NonText']                    = {},
        ["Normal"]                     = { fg = p.gray10, bg = p.gray1 },
        ["NormalFloat"]                = { bg = p.gray4 },
        ['NormalNC']                   = {},
        ['NvimInternalError']          = {},
        ['Pmenu']                      = { link = "NormalFloat" },
        ['PmenuSbar']                  = { bg = p.gray2 },
        ['PmenuSel']                   = { fg = p.gray12, bg = p.gray5 },
        ['PmenuThumb']                 = { bg = p.gray12 },
        ['Question']                   = {},
        ['RedrawDebugClear']           = {},
        ['RedrawDebugComposed']        = {},
        ['RedrawDebugRecompose']       = {},
        ['Search']                     = {},
        ['SpecialKey']                 = {},
        ['SpellBad']                   = {},
        ['SpellCap']                   = {},
        ['SpellLocal']                 = {},
        ['SpellRare']                  = {},
        ["SignColumn"]                 = {},
        ['Substitute']                 = {},
        ["StatusLine"]                 = { bg = p.gray4 },
        ['StatusLineNC']               = {},
        ['StatusLineTerm']             = { link = 'StatusLine' },
        ['StatusLineTermNC']           = { link = 'StatusLineNC' },
        ['TabLine']                    = {},
        ['TabLineFill']                = {},
        ['TabLineSel']                 = {},
        ['Title']                      = { fg = p.gray12, bold = true },
        ['VertSplit']                  = {},
        ['Visual']                     = { fg = p.gray10, bg = p.gray4 },
        -- VisualNOS = {},
        ['WarningMsg']                 = {},
        ["Whitespace"]                 = { fg = p.gray3 },
        ['WildMenu']                   = { link = 'IncSearch' },
        ["WinSeparator"]               = { fg = p.gray4 },
        --- Syntax
        ["Boolean"]                    = { fg = p.number, italic = true },
        ["Character"]                  = { fg = p.gray12 },
        ["Constant"]                   = { fg = p.gray12 },
        ["Comment"]                    = { fg = p.comment, italic = true },
        ["Conditional"]                = { link = "Keyword" },
        ["Delimiter"]                  = { fg = p.delimiter },
        ["Exception"]                  = { link = "Keyword" },
        ["Error"]                      = { fg = p.danger },
        ["Float"]                      = { link = "Number" },
        ["Function"]                   = { fg = p.call },
        ["Identifier"]                 = { link = "Constant" },
        ["Include"]                    = { link = "Keyword" },
        ["Keyword"]                    = { fg = p.keyword, bold = false },
        ["Label"]                      = { link = "Keyword" },
        ["Number"]                     = { fg = p.number },
        ["Operator"]                   = { fg = p.gray12 },
        ["PreProc"]                    = { link = "Keyword" },
        ["Repeat"]                     = { link = "Keyword" },
        ["Statement"]                  = { link = "Keyword" },
        ["String"]                     = { fg = p.string },
        ["Special"]                    = {},
        ["SpecialChar"]                = { fg = p.gray11 },
        ["Type"]                       = { fg = p.type },
        ["Tag"]                        = { fg = p.type },
        ["Todo"]                       = { fg = p.danger, bold = true },
        --- Go
        ["goPackage"]                  = { link = "Include" },
        ["goUnsignedInts"]             = { fg = p.builtin },
        --- Lua
        ["luaStatement"]               = { link = "Keyword" },
        ["luaConstant"]                = { link = "Boolean" },
        ["luaFunc"]                    = { link = "Function" },
        ["luaFunction"]                = { link = "Keyword" },
        ["luaFunctionBlock"]           = { link = "Function" },
        ["luaTable"]                   = { fg = p.shade12 },
        --- Lua TS
        ["@constructor.lua"]           = { link = "@punctuation.bracket" },
        ["@field.lua"]                 = { fg = p.gray9 },
        --- Treesitter
        ["@boolean"]                   = { link = "Boolean" },
        ["@constant"]                  = { link = "Constant" },
        ["@constant.builtin"]          = { link = "Constant" },
        ["@field"]                     = { fg = p.gray10 },
        ["@function.builtin"]          = { link = "Function" },
        ["@method"]                    = { link = "Function" },
        ["@method.call"]               = { link = "Function" },
        ["@namespace"]                 = { fg = p.gray10 },
        ["@operator"]                  = { link = "Operator" },
        ["@parameter"]                 = { link = "@property" },
        ["@property"]                  = { fg = p.gray8 },
        ["@punctuation.bracket"]       = { fg = p.bracket },
        ["@punctuation.delimiter"]     = { link = "Delimiter" },
        ["@tag"]                       = { link = "Tag" },
        ["@tag.attribute"]             = { link = "@parameter" },
        ["@tag.delimiter"]             = { link = "Delimiter" },
        ["@text"]                      = { fg = p.gray12 },
        ["@text.todo"]                 = { fg = p.gray12, bg = p.gray5 },
        ["@text.title.1"]              = { fg = p.type },
        ["@text.danger.comment"]       = { fg = "#DA6561", bg = "#3A2B30" },
        ["@type"]                      = { link = "Type" },
        ["@type.definition"]           = { link = "Type" },
        ["@variable"]                  = { fg = p.variable },
        --- LSP Semantic highlight
        ["@lsp.type.parameter"]        = { link = "@parameter" },
        ["@lsp.type.property"]         = { link = "@field.lua" },
        ["@lsp.type.variable"]         = { link = "@variable" },
        --- Query
        ["@variable.query"]            = { fg = p.type },
        --- Diagnostic
        ["DiagnosticError"]            = { fg = p.danger },
        ["DiagnosticVirtualTextError"] = { fg = p.danger1, bg = p.danger2 },
        ["DiagnosticHint"]             = { fg = p.info },
        ["DiagnosticVirtualTextHint"]  = { fg = p.info },
        ["DiagnosticWarn"]             = { fg = p.warn },
        ["DiagnosticVirtualTextWarn"]  = { fg = p.warn },
        -- GitSigns
        ["GitSignsAdd"]                = { fg = p.success1 },
        ["GitSignsChange"]             = { fg = p.warn1 }
    }

    for group, opts in pairs(options.highlight_groups) do
        local default_opts = M.defaults[group]

        if (opts.inherit == nil or opts.inherit) and default_opts ~= nil then
            opts.inherit = nil
            M.defaults[group] = vim.tbl_extend("force", default_opts, opts)
        else
            opts.inherit = nil -- Don't add this key to the highlight_group.
            M.defaults[group] = opts
        end
    end

    for group, color in pairs(M.defaults) do
        h(group, color)
    end
end

return M
