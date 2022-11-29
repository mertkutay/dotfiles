local modules = {
  "alpha",
  "autopairs",
  "bufferline",
  "cmp",
  "colorscheme",
  "comments",
  "gitsigns",
  "indentline",
  "lsp",
  "lualine",
  "multi-cursor",
  "notify",
  "project",
  "telescope",
  "toggleterm",
  "tree",
  "treesitter",
  "which-key",
}

local setupPacker = function(bootstrap)
  local packer = require("packer")

  packer.init({
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
      prompt_border = "rounded",
    },
  })

  packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")

    use("ellisonleao/gruvbox.nvim")

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
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use("ray-x/lsp_signature.nvim")
    use("b0o/schemastore.nvim")

    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("ahmedkhalf/project.nvim")
    use("goolord/alpha-nvim")
    use("folke/which-key.nvim")
    use("rcarriga/nvim-notify")

    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
    })
    use("p00f/nvim-ts-rainbow")

    use("mg979/vim-visual-multi")
    use("tpope/vim-surround")
    use("windwp/nvim-autopairs")
    use("lukas-reineke/indent-blankline.nvim")
    use("lewis6991/gitsigns.nvim")
    use("f-person/git-blame.nvim")
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    })

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

    if bootstrap then
      require("packer").sync()
    end

    for _, module in ipairs(modules) do
      require("plugins." .. module)
    end
  end)
end

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("packadd packer.nvim")
  setupPacker(true)
else
  setupPacker(false)
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*/lua/plugins/init.lua",
  callback = function()
    vim.cmd("source <afile> | PackerSync")
  end,
})
