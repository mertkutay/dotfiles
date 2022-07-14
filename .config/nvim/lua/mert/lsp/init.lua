require("mert.lsp.setup")
require("mert.lsp.null-ls")

require("nvim-lsp-installer").setup({
	ensure_installed = { "pyright", "jsonls", "tsserver", "yamlls", "sumneko_lua", "jdtls" },
})

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local lsp_signature = require("lsp_signature")
lsp_signature.setup()

local function nmap(bufnr, keys, action)
	vim.api.nvim_buf_set_keymap(bufnr, "n", keys, action, { noremap = true, silent = true })
end

local function setup_lsp_keymaps(bufnr)
	nmap(bufnr, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	nmap(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	nmap(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	nmap(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	nmap(bufnr, "gr", "<cmd>Telescope lsp_references<CR>")
	nmap(bufnr, "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
	nmap(bufnr, "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
	nmap(bufnr, "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
end

local function setup_document_highlighting(client)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
    augroup LspDocumentHighlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      autocmd CursorHold * silent! lua require('lsp-status').update_current_function()
    augroup END
    ]])
	end
end

local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

local opts = {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		setup_lsp_keymaps(bufnr)
		setup_document_highlighting(client)
		lsp_status.on_attach(client)
		lsp_signature.on_attach()
	end,
	capabilities = capabilities,
}

for _, server in ipairs({ "jsonls", "pyright", "sumneko_lua" }) do
	lspconfig[server].setup(vim.tbl_deep_extend("force", require("mert.lsp.servers." .. server), opts))
end

for _, server in ipairs({ "tsserver", "yamlls", "jdtls", "volar" }) do
	lspconfig[server].setup(opts)
end
