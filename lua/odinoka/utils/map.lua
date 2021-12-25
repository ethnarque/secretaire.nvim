return function(mode, keys, cmd, opt)
	local options = { noremap = true, silent = true }
	if opt then
		options = vim.tbl_extend("force", options, opt)
	end

	-- all valid modes allowed for mappings
	-- :h map-modes
	local valid_modes = {
		[""] = true,
		["n"] = true,
		["v"] = true,
		["s"] = true,
		["x"] = true,
		["o"] = true,
		["!"] = true,
		["i"] = true,
		["l"] = true,
		["c"] = true,
		["t"] = true,
	}

	-- helper function for M.map
	-- can gives multiple modes and keys
	local function map_wrapper(mod, lhs, rhs, opts)
		if type(lhs) == "table" then
			for _, key in ipairs(lhs) do
				map_wrapper(mod, key, rhs, opts)
			end
		else
			if type(mod) == "table" then
				for _, m in ipairs(mod) do
					map_wrapper(m, lhs, rhs, opts)
				end
			else
				if valid_modes[mod] and lhs and rhs then
					vim.api.nvim_set_keymap(mod, lhs, rhs, opts)
				else
					mod, lhs, rhs = mod or "", lhs or "", rhs or ""
					print(
						"Cannot set mapping [ mode = '"
						.. mod
						.. "' | key = '"
						.. lhs
						.. "' | cmd = '"
						.. rhs
						.. "' ]"
					)
				end
			end
		end
	end

	map_wrapper(mode, keys, cmd, options)
end
