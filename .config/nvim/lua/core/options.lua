local options = {
  writebackup = false,
  swapfile = false,
  undofile = true,
  title = true,
  clipboard = "unnamedplus",
  completeopt = { "menuone", "noselect" },
  fileencoding = "utf-8",
  cmdheight = 1,
  showmode = false,
  smartcase = true,
  ignorecase = true,
  mouse = "a",
  smartindent = true,
  splitbelow = true,
  splitright = true,
  updatetime = 300,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  number = true,
  signcolumn = "yes",
  cursorline = true,
  scrolloff = 1,
  sidescrolloff = 5,
  listchars = {
    tab = "→ ",
    eol = "↲",
    nbsp = "␣",
    trail = "•",
    extends = "⟩",
    precedes = "⟨",
  },
  list = true,
  fillchars = { eob = " " },
  guifont = "monospace:h17",
  termguicolors = true,
  pumheight = 10,
  foldlevel = 99,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  textwidth = 90,
  winwidth = 12,
  winminwidth = 12,
  equalalways = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
