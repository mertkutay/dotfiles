local lsp_util = require("lspconfig/util")

local utils = require("mert.utils")

return {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
			},
		},
	},
	before_init = function(_, config)
		local p
		if vim.env.VIRTUAL_ENV then
			p = lsp_util.path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
		else
			p = utils.find_cmd("python3", ".venv/bin", config.root_dir)
		end
		config.settings.python.pythonPath = p
	end,
}
