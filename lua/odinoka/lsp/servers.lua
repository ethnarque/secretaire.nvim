-- local fn = vim.fn
-- local lsp_path = fn.stdpath "data" .. "/lsp_servers"
local common_on_attach = require "odinoka.lsp.on_attach"

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return {}
end

local util = lspconfig.util

return {
	ansiblels = {},
	bashls = {
		filetypes = { "bash", "sh", "zsh" },
	},
	cssls = {
		on_attach = function(client, bufnr)
			client.server_capabilities.goto_definition = false
			common_on_attach(client, bufnr)
		end,
		handlers = {
			["textDocument/publishDiagnostics"] = false,
		},
	},
	dockerls = {
		filetypes = { "dockerfile" },
		root_dir = util.root_pattern("Dockerfile", "docker-compose.yml"),
	},
	gopls = {
		filetypes = { "go" },
	},
	html = {},
	jsonls = {
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
		end,
		settings = {
			json = {
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig.json", "tsconfig.*.json" },
						url = "http://json.schemastore.org/tsconfig",
					},
				},
			},
		},
	},
	pyright = {},
	rnix = {
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
		end,
	},
	sumneko_lua = {
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
		end,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					globals = { "awesome", "client", "mp", "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
					},
					maxPreload = 10000,
				},
			},
		},
	},
	stylelint_lsp = {
		filetypes = {
			"css",
			"less",
			"scss",
			"sugarss",
			"vue",
			"wxss",
		},
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
		end,
	},
	svelte = {},
	sqls = {
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			local sqlsOk, sqls = pcall(require, "sqls")
			if not sqlsOk then
				return
			end
			sqls.on_attach(client, bufnr)
		end,
		settings = {
			sqls = {
				connections = {
					{
						driver = "postgresql",
						dataSourceName = "host=127.0.0.1 port=5432 user=palusphera dbname=palusphera sslmode=disable",
					},
				},
			},
		},
	},
	tsserver = {
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
		end,
	},
	yamlls = {
		schemas = {
			["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
			["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
			["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
		},
	},
}
