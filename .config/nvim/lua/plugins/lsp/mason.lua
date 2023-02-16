require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "jsonls",
    "tsserver",
    "yamlls",
    "lua_ls",
    "jdtls",
    "volar",
    "taplo",
  },
})
