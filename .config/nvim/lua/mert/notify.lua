local notify = require("notify")
notify.setup({
	background_colour = "#000000",
	timeout = 2000,
	minimum_width = 40,
})

vim.notify = notify

require("telescope").load_extension("notify")
