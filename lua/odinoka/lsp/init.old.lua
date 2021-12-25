local servers = require "odinoka.lsp.servers"
local common_on_attach = require "odinoka.lsp.on_attach"
local common_capabilities = require "odinoka.lsp.capabilities"

local signs = {
	Error = "",
	Information = "",
	Hint = "",
	Warning = "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lsp_publish_diagnostics_options = {
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false, -- update diagnostics insert mode
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	lsp_publish_diagnostics_options
)

vim.diagnostic.config {
	float = { border = "rounded" },
}

vim.fn.sign_define(
	"DiagnosticSignError",
	{ text = " ", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

local function goto_definition(split_cmd)
	local util = vim.lsp.util
	local log = require "vim.lsp.log"
	local api = vim.api

	-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, "No location found")
			return nil
		end

		if split_cmd then
			vim.cmd(split_cmd)
		end

		if vim.tbl_islist(result) then
			util.jump_to_location(result[1])

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command "copen"
				api.nvim_command "wincmd p"
			end
		else
			util.jump_to_location(result)
		end
	end

	return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition "split"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] =
	vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "single",
	})

vim.diagnostic.open_float = (function(orig)
	return function(opts)
		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
		-- A more robust solution would check the "scope" value in `opts` to
		-- determine where to get diagnostics from, but if you're only using
		-- this for your own purposes you can make it as simple as you like
		local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
		local max_severity = vim.diagnostic.severity.HINT
		for _, d in ipairs(diagnostics) do
			-- Equality is "less than" based on how the severities are encoded
			if d.severity < max_severity then
				max_severity = d.severity
			end
		end
		local border_color = ({
			[vim.diagnostic.severity.HINT] = "NonText",
			[vim.diagnostic.severity.INFO] = "Question",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		})[max_severity]
		opts.border = {
			{ "╭", border_color },
			{ "─", border_color },
			{ "╮", border_color },
			{ "│", border_color },
			{ "╯", border_color },
			{ "─", border_color },
			{ "╰", border_color },
			{ "│", border_color },
		}
		orig(opts)
	end
end)(vim.diagnostic.open_float)

local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
	return
end

local installer_ok, lspinstaller = pcall(require, "nvim-lsp-installer")
if not installer_ok then
	return
end

lspinstaller.setup {}

for server_name, default_setup in pairs(servers) do
	local setup = default_setup

	if not setup.on_attach then
		setup.on_attach = common_on_attach
	end

	if not setup.capabilities then
		setup.capabilities = common_capabilities(server_name)
	end

	lspconfig[server_name].setup(setup)
end
