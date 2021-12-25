return function(_)
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	local ok, cmp = pcall(require, "cmp_nvim_lsp")
	if not ok then
		print "Problem with cmp and lsp"
		return capabilities
	end
	capabilities = cmp.default_capabilities(capabilities)

	return capabilities
end
