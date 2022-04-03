require("mert.lsp.setup")
require("mert.lsp.null-ls")

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local lsp_signature = require("lsp_signature")
lsp_signature.setup()

local function setup_lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

local function setup_document_highlighting(client)
	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
    augroup LspDocumentHighlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]])
	end
end

require("nvim-lsp-installer").on_server_ready(function(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
	capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

	local opts = {
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			setup_lsp_keymaps(bufnr)
			setup_document_highlighting(client)
			lsp_status.on_attach(client)
			lsp_signature.on_attach()
		end,
		capabilities = capabilities,
	}

	local ok, server_opts = pcall(require, "mert.lsp.servers." .. server.name)
	if ok then
		opts = vim.tbl_deep_extend("force", server_opts, opts)
	end

	server:setup(opts)
end)
