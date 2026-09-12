-- Inventory and tool management for OpenComputers robots.
local M = {}

function M.new(robot, component, cfg)
  local self = {robot = robot, component = component, cfg = cfg}
  self.controller = component.isAvailable("inventory_controller") and component.inventory_controller or nil

  function self:stack(slot)
    if not self.controller or not self.controller.getStackInInternalSlot then return nil end
    local ok, stack = pcall(self.controller.getStackInInternalSlot, slot)
    return ok and stack or nil
  end

  function self:label(slot)
    local s = self:stack(slot)
    if not s then return "" end
    return string.lower(tostring(s.label or s.name or ""))
  end

  function self:isTool(slot)
    local label = self:label(slot)
    return label:find("pickaxe", 1, true) ~= nil
      or label:find("hammer", 1, true) ~= nil
      or label:find("excavator", 1, true) ~= nil
      or label:find("mattock", 1, true) ~= nil
      or label:find("pick", 1, true) ~= nil
  end

  function self:selectBestTool()
    local preferred = self.cfg.TOOL_SLOTS or {1,2,3,4,5,6,7,8,9}
    for _, slot in ipairs(preferred) do
      if self:isTool(slot) then
        self.robot.select(slot)
        return true, slot, self:label(slot)
      end
    end
    return false, nil, "no compatible pick/tool found"
  end

  function self:findItem(slot, wanted)
    local s = self:stack(slot)
    if not s then return false end
    local name = string.lower(tostring(s.name or ""))
    local label = string.lower(tostring(s.label or ""))
    wanted = string.lower(wanted)
    return name == wanted or label == wanted or name:find(wanted, 1, true) ~= nil or label:find(wanted, 1, true) ~= nil
  end

  function self:findMaterial(wanted)
    local reserved = self.cfg.RESERVED_SLOTS or {1}
    for slot = 1, 16 do
      local skip = false
      for _, r in ipairs(reserved) do if r == slot then skip = true end end
      if not skip and self:findItem(slot, wanted) then return slot end
    end
    return nil
  end

  function self:unload(dropSide)
    local reserved = self.cfg.RESERVED_SLOTS or {1}
    for slot = 1, 16 do
      local keep = false
      for _, r in ipairs(reserved) do if r == slot then keep = true end end
      if not keep and self.robot.count(slot) > 0 then
        self.robot.select(slot)
        if dropSide == "up" then self.robot.dropUp()
        elseif dropSide == "down" then self.robot.dropDown()
        else self.robot.drop() end
      end
    end
  end

  function self:hasSpace()
    for slot = 1, 16 do
      if self.robot.space(slot) then return true end
    end
    return false
  end

  return self
end

return M
