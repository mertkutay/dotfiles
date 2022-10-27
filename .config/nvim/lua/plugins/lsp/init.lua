local modules = {
  "setup",
  "null-ls",
  "mason",
}

for _, module in ipairs(modules) do
  require("plugins.lsp." .. module)
end
