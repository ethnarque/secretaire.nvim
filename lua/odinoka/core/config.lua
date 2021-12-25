local M = {}

function M.load_globals()
  _G.odinoka = {
    builtins = {},
    keys = {},
    ui = {
      icons = {
        diagnostics = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        },
        git = {
          added = " ",
          modified = " ",
          removed = " ",
        },
        kinds = {
          Class = " ",
          Color = " ",
        },
      },
    },
  }
end

function M.load_lazy()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup(
    ---@diagnostic disable-next-line
    { { import = "odinoka.plugins" } },
    { change_detection = {
      enabled = true,
      notify = false,
    } }
  )
end

function M.merge_configs(o)
  o = o or {}
  return vim.tbl_deep_extend("force", odinoka, o)
end

return M
