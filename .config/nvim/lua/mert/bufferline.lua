local highlight = {
	guifg = { attribute = "fg", highlight = "TabLine" },
	guibg = { attribute = "bg", highlight = "TabLine" },
}

require("bufferline").setup({
	options = {
		numbers = "none",
		close_command = "Bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = "Bdelete! %d",
		right_mouse_command = nil,
		separator_style = "thin",
	},
	highlights = {
		background = highlight,
		separator = highlight,
		indicator_selected = highlight,
		close_button = highlight,
	},
})
