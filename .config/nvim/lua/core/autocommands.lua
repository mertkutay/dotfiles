local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function()
    vim.api.nvim_set_keymap("n", "q", ":close<CR>", { noremap = true, silent = true })
  end,
})

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd([[
      if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
    ]])
  end,
})

autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[
      if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif 
    ]])
  end,
})

autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.cmd([[
      echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
    ]])
  end,
})

autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
