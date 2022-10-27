local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
  { name = "DiagnosticSignHint", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  signs = {
    active = signs,
  },
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

local lsp_status = require("lsp-status")
local lsp_signature = require("lsp_signature")

lsp_status.register_progress()
lsp_signature.setup()

local function setup_document_highlighting(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local augroup = vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      group = augroup,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

local opts = {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    setup_document_highlighting(client, bufnr)
    lsp_status.on_attach(client)
    lsp_signature.on_attach()
  end,
  capabilities = capabilities,
}

for _, server in ipairs({ "jsonls", "pyright", "sumneko_lua" }) do
  lspconfig[server].setup(
    vim.tbl_deep_extend("force", require("plugins.lsp.servers." .. server), opts)
  )
end

for _, server in ipairs({ "tsserver", "yamlls", "jdtls", "volar" }) do
  lspconfig[server].setup(opts)
end
