return {
  {
    "pmlogist/uusimaa.nvim",
    lazy = false,
    priority = 10000,
    config = function()
      require("uusimaa").setup()
    end,
  },
}
