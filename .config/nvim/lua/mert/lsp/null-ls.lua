local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		formatting.black,
		formatting.isort,
		diagnostics.flake8,

		formatting.prettier,
		diagnostics.eslint,

		formatting.stylua,

		formatting.clang_format,

		formatting.google_java_format,
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd([[
      augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
      ]])
		end
	end,
})
