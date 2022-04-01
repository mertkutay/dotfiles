require("project_nvim").setup({
	detection_methods = { "lsp", "pattern" },
	show_hidden = true,
})

require("telescope").load_extension("projects")
