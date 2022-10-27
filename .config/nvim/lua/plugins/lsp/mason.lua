require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "jsonls",
    "tsserver",
    "yamlls",
    "sumneko_lua",
    "jdtls",
    "volar",
  },
})
