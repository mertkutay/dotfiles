require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
		colors = {
			"#ffd700",
			"#da70d6",
			"#87cefa",
		},
		termcolors = {
			"Yellow",
			"Magenta",
			"Blue",
		},
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
