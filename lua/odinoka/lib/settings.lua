local Settings = {}

function Settings.disable_builtins(builtins)
	for _, plugin in pairs(builtins) do
		vim.g["loaded_" .. plugin] = 1
	end
end

function Settings.set(settings)
	for k, v in pairs(settings) do
		vim.opt[k] = v
	end
end

return Settings
