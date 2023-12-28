require("ibl").setup({
  indent = { char = "▏" },
  scope = {
    show_start = false,
    show_end = false,
  },
  exclude = {
    filetypes = {
      "help",
      "packer",
      "NvimTree",
      "alpha",
    },
  },
})
