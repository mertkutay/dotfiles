local modules = {
	"options",
	"keymaps",
	"plugins",
	"impatient",
	"colorscheme",
	"transparent",
	"cmp",
	"lsp",
	"telescope",
	"treesitter",
	"autopairs",
	"comments",
	"gitsigns",
	"tree",
	"bufferline",
	"lualine",
	"toggleterm",
	"project",
	"indentline",
	"alpha",
	"which-key",
	"colorizer",
	"autocommands",
}

for _, module in ipairs(modules) do
	local ok, result = pcall(require, "mert." .. module)
	if not ok then
		vim.notify(result)
	end
end
