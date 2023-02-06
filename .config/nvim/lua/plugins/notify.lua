local notify = require("notify")
notify.setup({
  background_colour = "#000000",
  timeout = 2000,
  minimum_width = 40,
})

vim.notify = notify

local ok, telescope = pcall(require, "telescope")
if ok then
  telescope.load_extension("notify")
end
