local global_options = {
	git_hl = 1,
	root_folder_modifier = ":t",
	respect_buf_cwd = 1,
	show_icons = {
		git = 1,
		folders = 1,
		files = 1,
		folder_arrows = 1,
		tree_width = 30,
	},
	icons = {
		default = "",
		symlink = "",
		git = {
			unstaged = "",
			staged = "S",
			unmerged = "",
			renamed = "➜",
			untracked = "U",
			deleted = "",
			ignored = "◌",
		},
	},
}

for k, v in pairs(global_options) do
	vim.g["nvim_tree_" .. k] = v
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

require("nvim-tree").setup({
	disable_netrw = true,
	update_cwd = true,
	view = {
		mappings = {
			list = {
				{ key = { "l", "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
				{ key = "s", cb = tree_cb("split") },
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	diagnostics = {
		enable = true,
	},
})
