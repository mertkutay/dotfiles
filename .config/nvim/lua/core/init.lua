local modules = {
  "autocommands",
  "options",
  "keymaps",
}

for _, module in ipairs(modules) do
  require("core." .. module)
end
