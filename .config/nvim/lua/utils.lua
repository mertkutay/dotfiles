local M = {}

M.prequire = function(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(result)
  end
  return ok, result
end

M.find_cmd = function(cmd, prefixes, start_from, stop_at)
  local path = require("lspconfig/util").path

  if type(prefixes) == "string" then
    prefixes = { prefixes }
  end

  local found
  for _, prefix in ipairs(prefixes) do
    local full_cmd = prefix and path.join(prefix, cmd) or cmd
    local possibility

    -- if start_from is a dir, test it first since transverse will start from its parent
    if start_from and path.is_dir(start_from) then
      possibility = path.join(start_from, full_cmd)
      if vim.fn.executable(possibility) > 0 then
        found = possibility
        break
      end
    end

    path.traverse_parents(start_from, function(dir)
      possibility = path.join(dir, full_cmd)
      if vim.fn.executable(possibility) > 0 then
        found = possibility
        return true
      end
      -- use cwd as a stopping point to avoid scanning the entire file system
      if stop_at and dir == stop_at then
        return true
      end
    end)

    if found ~= nil then
      break
    end
  end

  return found or cmd
end

return M
