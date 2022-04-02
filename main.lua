io.stdout:setvbuf("no")

width, height = love.graphics.getDimensions()
love.graphics.setDefaultFilter("nearest")

require("toothpick")

local picks = {}
local scale = 1

function love.load()
  love.graphics.setBackgroundColor(1, 1, 1, 1)
  table.insert(picks, newToothpick(0, 0, true))
end

function love.update(dt)
  local newScale = (width / 2) / math.abs(picks[#picks].startX)
  scale = scale + (newScale - scale) * dt * 5
end

function love.mousepressed(x, y, button)
  if button ~= 1 then return end

  for i = #picks, 1, -1 do
    if not picks[i].new then return end
    
    local a, b = picks[i]:createpicks(picks)
    table.insert(picks, a)
    table.insert(picks, b)
    picks[i].new = false
  end
end

function love.draw()
  love.graphics.translate(width / 2, height / 2)
  love.graphics.scale(scale * 0.95)
  for i = #picks, 1, -1 do
    picks[i]:draw()
  end
end