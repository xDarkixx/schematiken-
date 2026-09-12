-- Persistent progress/recovery state.
local M = {}

function M.load(path)
  local f = io.open(path, "r")
  if not f then return {index = 1, x = 0, y = 0, z = 0, dir = 0} end
  local text = f:read("*a"); f:close()
  local fn = loadstring(text)
  if not fn then return {index = 1, x = 0, y = 0, z = 0, dir = 0} end
  local ok, data = pcall(fn)
  if ok and type(data) == "table" then return data end
  return {index = 1, x = 0, y = 0, z = 0, dir = 0}
end

function M.save(path, state)
  local f = io.open(path, "w")
  if not f then return false end
  f:write("return { index = ", tostring(state.index or 1), ", x = ", tostring(state.x or 0), ", y = ", tostring(state.y or 0), ", z = ", tostring(state.z or 0), ", dir = ", tostring(state.dir or 0), " }\n")
  f:close()
  return true
end

return M
