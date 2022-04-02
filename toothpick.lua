local toothpickLength = 63

local toothpickMeta = {}
toothpickMeta.__index = toothpickMeta

function toothpickMeta:intersects(x, y)
  return (self.startX==x and self.startY==y) or (self.endX==x and self.endY==y)
end

local function createpick(self, side, picks)
  local x = side=="start" and self.startX or self.endX
  local y = side=="start" and self.startY or self.endY
  for _, tp in ipairs(picks) do
    if tp ~= self and tp:intersects(x, y) then
      return
    end
  end
  return newToothpick(x,y,not self.horizontal)
end

function toothpickMeta:createpicks(picks)
  return createpick(self, "start", picks), createpick(self, "end", picks)
end

function toothpickMeta:draw()
  love.graphics.setColor(self.new and {0.1, 0.4, 0.1, 1} or {0, 0, 0, 1})
  love.graphics.setLineWidth(2)
  love.graphics.line(self.startX, self.startY, self.endX, self.endY)
end

function newToothpick(x, y, horizontal)
  local pick = setmetatable({
    horizontal = horizontal,
    new = true
  }, toothpickMeta)

  if horizontal then
    pick.startX = x - toothpickLength / 2
    pick.endX = x + toothpickLength / 2
    pick.startY = y
    pick.endY = y
  else
    pick.startX = x
    pick.endX = x
    pick.startY = y - toothpickLength / 2
    pick.endY = y + toothpickLength / 2
  end

  return pick
end