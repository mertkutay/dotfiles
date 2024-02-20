local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  },

  -- UI
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "srcery-colors/srcery-vim",
    config = function()
      vim.cmd([[
        set t_Co=256
        colorscheme srcery
      ]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "SmiteshP/nvim-navic" },
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "moll/vim-bbye" },
    config = function()
      require("plugins.bufferline")
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.tree")
    end,
  },
  "kyazdani42/nvim-web-devicons",
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indentline")
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.notify")
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.noice")
    end,
  },
  { "folke/trouble.nvim", config = true },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = true,
  },
  { "petertriho/nvim-scrollbar", config = true },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      require("plugins.git-blame")
    end,
  },
  { "NvChad/nvim-colorizer.lua", config = true },
  "p00f/nvim-ts-rainbow",
  "RRethy/vim-illuminate",

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp.setup")
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.lsp.mason")
    end,
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("plugins.lsp.null-ls")
    end,
  },
  { "ray-x/lsp_signature.nvim", config = true },
  "SmiteshP/nvim-navic",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "b0o/schemastore.nvim",
  { "smjonas/inc-rename.nvim", config = true },

  -- Utilities
  "moll/vim-bbye",
  {
    "mg979/vim-visual-multi",
    config = function()
      require("plugins.multi-cursor")
    end,
  },
  "tpope/vim-surround",
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs")
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("plugins.comments")
    end,
  },
  "JoosepAlviste/nvim-ts-context-commentstring",

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.telescope")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project")
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.alpha")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.toggleterm")
    end,
  },

  -- Auto complete
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      require("plugins.cmp")
    end,
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "saadparwaiz1/cmp_luasnip",

  -- Navigation
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  -- File types
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  "chrisbra/csv.vim",
  "amadeus/vim-mjml",
  "jamessan/vim-gnupg",
})
