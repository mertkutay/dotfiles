vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

local utils = require("utils")

utils.prequire("core")
utils.prequire("plugins")
