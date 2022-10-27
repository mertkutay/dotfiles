local wk = require("which-key")

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
    },
  },
})

wk.register(
  {
    g = { name = "Git" },
    h = { name = "Help" },
    l = { name = "LSP" },
    p = { name = "Packer" },
    t = { name = "Terminal" },
  },
  { prefix = "<leader>" }
)
