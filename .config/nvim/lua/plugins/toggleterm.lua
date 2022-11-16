require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]],
  shading_factor = 2,
  direction = "float",
  float_opts = {
    border = "curved",
    winblend = 2,
  },
})

local opts = { noremap = true }
local buf_keymap = vim.api.nvim_buf_set_keymap

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    buf_keymap(0, "t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  end,
})

local Terminal = require("toggleterm.terminal").Terminal

local clis = {}

function _TOGGLE_CLI(cmd)
  if not clis[cmd] then
    clis[cmd] = Terminal:new({
      cmd = cmd,
      dir = "git_dir",
      hidden = true,
      on_open = function(term)
        vim.cmd("startinsert!")
        buf_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
      end,
    })
  end
  clis[cmd]:toggle()
end
