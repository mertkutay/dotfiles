local spaces = function()
  return "S: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local navic = require("nvim-navic")

require("lualine").setup({
  options = {
    theme = "auto",
    disabled_filetypes = { "alpha", "NvimTree" },
  },
  sections = {
    lualine_c = {
      { navic.get_location, cond = navic.is_available },
    },
    lualine_x = { spaces, "encoding", "fileformat", "filetype" },
  },
})
