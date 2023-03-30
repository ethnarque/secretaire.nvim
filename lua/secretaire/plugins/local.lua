return {
    {
        dir = "~/Code/pmlogist/verveine.nvim",
        priority = 1000,
        config = function()
            require("verveine").setup()
        end,
    },
}
