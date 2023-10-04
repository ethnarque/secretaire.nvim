local options = require("givre.config").options

local variants = {
    dark = {
        -- -- call     = "#96ADB6",
        -- call     = "#7A92B2",
        -- comment  = "#7D7B76",
        -- const    = "#494B52",
        -- -- keyword  = "#FFFFFF",
        -- keyword  = "#388888",
        -- property = "#82879C",
        -- number   = "#C3B691",
        -- -- string   = "#9F87AA",
        -- -- string   = "#86AA96",
        -- string   = "#BFAA8E",
        -- -- type     = "#7A92B2",
        -- type     = "#C3B691",
        --
        -- success1 = "#7DA98E",
        -- success2 = "#2B3A31",
        -- hint     = "#9EC0DE",
        -- info     = "#9EC0DE",
        -- warn     = "#B58862",
        -- danger1  = "#DA6561",
        -- danger2  = "#3A2B30",

        call      = "#BB8E8B",
        comment   = "#686868",
        const     = "#BB8E8B",
        keyword   = "#A4A4A4",
        property  = "#AAAAAA",
        number    = "#D1D0CA",
        string    = "#949187",
        type      = "#BBA98B",
        delimiter = "#8D8D8D",
        bracket   = "#AAAAAA",
        variable  = "#707070",


        success1 = "#7DA98E",
        success2 = "#2B3A31",
        hint     = "#9EC0DE",
        info     = "#9EC0DE",
        warn     = "#B58862",
        danger1  = "#DA6561",
        danger2  = "#3A2B30",

        -- syntax
        -- gray1    = "#181816", -- High contrast bakground
        gray1    = "#141313", -- High contrast bakground
        gray2    = "#222221", -- Low contrast bakground
        gray3    = '#282826', -- List chars and indent lines
        gray4    = '#373734', -- Floating, Pmenu background
        gray5    = '#42413E', -- Borders, window separators
        gray6    = '#7D7B76', -- Comments
        gray7    = "#99978E", -- Variables and parameters
        gray8    = "#ADABA2", -- Delimiters
        gray9    = "#C4C2B9", -- Function and method calls
        gray10   = "#D1D0CA", -- Properties, namespaces
        gray11   = "#DEDDD7", -- Low contrast text, fields
        gray12   = "#E3E3DF", -- High contrast text, keywords,
    },

    light = {
        call     = "#577FA8",
        comment  = "",
        const    = "",
        keyword  = "",
        property = "",
        number   = "",
        string   = "",
        type     = "",

        success  = "",
        info     = "",
        warn1    = "",
        warn2    = "",
        danger1  = "",
        danger2  = "",

        gray1    = '#FCFCFD', -- High contrast bakground
        gray2    = '#F0F0F5', -- Low contrast bakground
        gray3    = '#E0E0E6', -- List chars and indent lines
        gray4    = '#D0D0D8', -- Floating, Pmenu background
        gray5    = '#BEC0CB', -- Borders, window separators and unused variables
        gray6    = '#B3B3C1', -- Comments
        gray7    = '#9D9FAF', -- Variables
        gray8    = '#7B7F93', -- Delimiters
        gray9    = '#5D5F69', -- Function and method calls
        gray10   = '#494B52', -- Properties, namespaces
        gray11   = '#323438', -- Low contrast text, fields
        gray12   = '#1C2024', -- High contrast text, keywords,
    },
}

if options.variant ~= nil and options.variant ~= "auto" then
    return variants[options.variant]
end

if vim.o.background == "light" then
    return variants.light
end
return variants.dark
