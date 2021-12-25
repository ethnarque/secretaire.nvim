local M = {}

local config = require "odinoka.core.config"

function M.setup(callback)
  config.load_globals()
  if callback ~= nil then
    config.merge_configs(callback(odinoka))
  end
  config.load_lazy()
end

return M
