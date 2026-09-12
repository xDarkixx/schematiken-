-- SGC schematic/plan loader for OpenComputers Lua 5.2
-- Supports the repository's portable .plan Lua format and simple text exports.
-- Binary NBT/.schematic conversion is intentionally kept outside the robot so
-- the robot does not depend on a non-standard gzip/NBT library.

local filesystem = require("filesystem")

local M = {}

local function validNumber(v)
  return type(v) == "number" and v == v
end

function M.load(path)
  if not filesystem.exists(path) then
    return nil, "file not found: " .. path
  end

  local ok, data = pcall(dofile, path)
  if not ok then return nil, "cannot read plan: " .. tostring(data) end
  if type(data) ~= "table" then return nil, "plan must return a table" end

  for _, key in ipairs({"width", "height", "length"}) do
    if not validNumber(data[key]) or data[key] < 1 then
      return nil, "invalid dimension: " .. key
    end
  end
  if type(data.blocks) ~= "table" then return nil, "missing blocks table" end

  local out = {
    width = data.width,
    height = data.height,
    length = data.length,
    blocks = {}
  }

  for i, b in ipairs(data.blocks) do
    if type(b) ~= "table" then return nil, "invalid block entry " .. i end
    if not validNumber(b.x) or not validNumber(b.y) or not validNumber(b.z) then
      return nil, "missing coordinates at block " .. i
    end
    if not b.protected and not validNumber(b.slot) then
      return nil, "missing inventory slot at block " .. i
    end
    out.blocks[#out.blocks + 1] = b
  end
  return out
end

function M.iterate(plan, startIndex)
  local i = startIndex or 1
  return function()
    local b = plan.blocks[i]
    if b then i = i + 1; return i - 1, b end
  end
end

return M
