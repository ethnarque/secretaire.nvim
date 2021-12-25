local M = {}

function M.inject_globals()
  M.inject_utilities()
  vim.g.mapleader = " "
  ---@class odinoka.global
  _G.odinoka = {
	defaults = {treesitter = {}},
	builtins = {treesitter = {}},
	}
end

function M.inject_utilities()
  _G.pprint = function(...)
    print(vim.inspect(...))
  end

  _G.deep_merge_opts = function(new_opts, opts)
    if new_opts == {} then
      return opts
    end

    return vim.tbl_deep_extend("force", opts, new_opts)
  end
end

function M.load()
  M.inject_globals()
end

return M
