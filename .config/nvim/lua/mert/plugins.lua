local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")

	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	use("folke/tokyonight.nvim")

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip")

	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim")
	use("ray-x/lsp_signature.nvim")
	use("b0o/schemastore.nvim")

	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("ahmedkhalf/project.nvim")
	use("goolord/alpha-nvim")
	use("folke/which-key.nvim")
	use("rcarriga/nvim-notify")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")

	use("mg979/vim-visual-multi")
	use("tpope/vim-surround")
	use("windwp/nvim-autopairs")
	use("lukas-reineke/indent-blankline.nvim")
	use("lewis6991/gitsigns.nvim")
	use("f-person/git-blame.nvim")
	use("norcalli/nvim-colorizer.lua")

	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("kyazdani42/nvim-tree.lua")
	use("kyazdani42/nvim-web-devicons")

	use("nvim-lualine/lualine.nvim")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("nvim-lua/lsp-status.nvim")

	use("akinsho/toggleterm.nvim")

	use("jamessan/vim-gnupg")
	use("amadeus/vim-mjml")
	use("chrisbra/csv.vim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
