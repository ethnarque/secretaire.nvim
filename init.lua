vim.opt.termguicolors = true

local config = require "odinoka.core.config"

-- config.load_globals()
--config.load_lazy()
require("odinoka.core.options").load()

vim.g.mapleader = " "
require("odinoka").setup(function(o)
  --
end)
