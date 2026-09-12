-- Stargate SG-1 SGC construction robot
-- Minecraft 1.7.10 / OpenComputers
-- Standalone: no MATRIX-OS dependency.

local component = require("component")
local computer = require("computer")
local robot = component.robot
if not robot then error("OpenComputers robot component required") end

local BASE = "/home/sgc/robot/"
local function loadConfig(path)
  local ok, err = pcall(dofile, path)
  if not ok then error("Cannot load config: " .. tostring(err)) end
  return {
    PLAN = PLAN or "/home/sgc/SGC-SG1-Cheyenne-Mountain.plan",
    PROGRESS = PROGRESS or "/home/sgc/build-progress.cfg",
    START_X = START_X or 0, START_Y = START_Y or 0, START_Z = START_Z or 0,
    PROTECTED_RADIUS = PROTECTED_RADIUS or 5,
    ALLOW_START_ZONE = ALLOW_START_ZONE or false,
    RESERVED_SLOTS = RESERVED_SLOTS or {1}, TOOL_SLOTS = TOOL_SLOTS or {1,2,3,4,5,6,7,8,9},
    MOVE_RETRIES = MOVE_RETRIES or 3, PLACE_RETRIES = PLACE_RETRIES or 3,
    SAVE_EVERY = SAVE_EVERY or 10, UNLOAD_WHEN_FULL = UNLOAD_WHEN_FULL ~= false
  }
end

local cfg = loadConfig(BASE .. "config.cfg")
local nav = dofile(BASE .. "navigation.lua").new(robot, computer, cfg)
local inv = dofile(BASE .. "inventory.lua").new(robot, component, cfg)
local schematic = dofile(BASE .. "schematic.lua")
local recovery = dofile(BASE .. "recovery.lua")
local function say(s) io.write("[SGC] " .. tostring(s) .. "\n") end

local function placeAt(b)
  if not b.slot then return true end
  if b.face ~= nil and not nav:face(b.face) then return false end
  robot.select(b.slot)
  for _ = 1, cfg.PLACE_RETRIES do
    if robot.place() then return true end
    if robot.detect() then robot.swing() end
  end
  return false
end

local function save(index)
  local x,y,z,d = nav:position()
  recovery.save(cfg.PROGRESS, {index=index, x=x, y=y, z=z, dir=d})
end

local plan, err = schematic.load(cfg.PLAN)
if not plan then say(err); say("Install a validated SGC .plan first."); return end
local state = recovery.load(cfg.PROGRESS)

say("SGC builder online - standalone mode")
say(string.format("Plan %dx%dx%d, %d blocks", plan.width, plan.height, plan.length, #plan.blocks))
say("Resume block: " .. tostring(state.index))
say("Protected charging radius: " .. tostring(cfg.PROTECTED_RADIUS))
local okTool, toolSlot, toolName = inv:selectBestTool()
if okTool then say("Tool: slot " .. toolSlot .. " (" .. toolName .. ")") end

for i = state.index, #plan.blocks do
  local b = plan.blocks[i]
  if not b.protected then
    -- The compiler supplies a stand position. Falling back to x/y/z is rejected
    -- rather than placing unpredictably into the wrong block.
    if b.sx == nil or b.sy == nil or b.sz == nil then
      save(i); say("STOP: block " .. i .. " has no safe stand position"); return
    end
    local ok, reason = nav:goTo(b.sx, b.sy, b.sz)
    if not ok then save(i); say("STOP at block " .. i .. ": " .. tostring(reason)); return end
    if not placeAt(b) then save(i); say("STOP: placement failed at block " .. i); return end
  end

  if cfg.UNLOAD_WHEN_FULL and not inv:hasSpace() then
    save(i + 1); say("Inventory full - unload at the configured chest before continuing"); return
  end
  if i % cfg.SAVE_EVERY == 0 then
    save(i + 1); say("Progress: " .. math.floor(i * 100 / #plan.blocks) .. "%")
  end
end

save(#plan.blocks + 1)
say("BUILD COMPLETE")
