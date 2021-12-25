local reloader

local ok, plenay_reload = pcall(require, "plenay.reload")

if not ok then
	reloader = require
else
	reloader = plenay_reload.reload_module
end

P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return reloader(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end
