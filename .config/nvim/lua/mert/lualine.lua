local spaces = function()
	return "S: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

vim.cmd([[
  augroup _update_function
    autocmd!
    autocmd CursorHold * silent! lua require('lsp-status').update_current_function()
  augroup END
]])

local currentFunction = function()
	local filename = vim.fn.expand("%:t:r")

	if
		vim.b.lsp_current_function == nil
		or vim.b.lsp_current_function == ""
		or vim.b.lsp_current_function == filename
	then
		return ""
	end

	return "ƒ:" .. vim.b.lsp_current_function
end

require("lualine").setup({
	options = {
		disabled_filetypes = { "alpha", "NvimTree" },
	},
	sections = {
		lualine_c = { currentFunction },
		lualine_x = { spaces, "encoding", "fileformat", "filetype" },
	},
})
