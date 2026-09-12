-- Standalone OpenComputers robot navigation for SGC construction.
local M = {}

function M.new(robot, computer, cfg)
  local self = {robot = robot, computer = computer, cfg = cfg, x = 0, y = 0, z = 0, dir = 0}

  local function protected(x, y, z)
    local r = cfg.PROTECTED_RADIUS or 5
    local dx, dy, dz = x - (cfg.START_X or 0), y - (cfg.START_Y or 0), z - (cfg.START_Z or 0)
    return math.abs(dx) <= r and math.abs(dy) <= r and math.abs(dz) <= r
  end

  function self:setStart()
    self.x, self.y, self.z = cfg.START_X or 0, cfg.START_Y or 0, cfg.START_Z or 0
  end

  function self:forward()
    local ok = self.robot.forward()
    if not ok then return false end
    if self.dir == 0 then self.x = self.x + 1
    elseif self.dir == 1 then self.z = self.z + 1
    elseif self.dir == 2 then self.x = self.x - 1
    else self.z = self.z - 1 end
    return true
  end

  function self:up()
    if self.robot.up() then self.y = self.y + 1; return true end
    return false
  end

  function self:down()
    if self.robot.down() then self.y = self.y - 1; return true end
    return false
  end

  function self:turnLeft()
    if self.robot.turnLeft() then self.dir = (self.dir + 3) % 4; return true end
    return false
  end

  function self:turnRight()
    if self.robot.turnRight() then self.dir = (self.dir + 1) % 4; return true end
    return false
  end

  function self:face(target)
    local delta = (target - self.dir) % 4
    if delta == 1 then return self:turnRight()
    elseif delta == 2 then return self:turnRight() and self:turnRight()
    elseif delta == 3 then return self:turnLeft()
    end
    return true
  end

  function self:goAxis(delta, axis)
    local step = delta >= 0 and 1 or -1
    for _ = 1, math.abs(delta) do
      local ok
      if axis == "y" then
        ok = step > 0 and self:up() or self:down()
      else
        local target = axis == "x" and (step > 0 and 0 or 2) or (step > 0 and 1 or 3)
        if not self:face(target) then return false end
        ok = self:forward()
      end
      if not ok then return false end
    end
    return true
  end

  function self:goTo(x, y, z)
    -- Never enter the charging/start safety zone except when explicitly disabled.
    if not cfg.ALLOW_START_ZONE and protected(x, y, z) then
      return false, "target is inside protected charging zone"
    end
    if not self:goAxis(x - self.x, "x") then return false, "x movement failed" end
    if not self:goAxis(y - self.y, "y") then return false, "y movement failed" end
    if not self:goAxis(z - self.z, "z") then return false, "z movement failed" end
    return true
  end

  function self:position()
    return self.x, self.y, self.z, self.dir
  end

  self:setStart()
  return self
end

return M
