local length = 63

function newToothpick(x,y,horizontal)
local self={}

if horizontal then
	self.startx = x-length/2
	self.endx = x+length/2
	self.starty = y
	self.endy = y
else
	self.startx = x
	self.endx = x
	self.starty = y-length/2
	self.endy = y+length/2
end

self.horizontal = horizontal
self.new = true

function self.intersects(x,y)
	return (self.startx==x and self.starty==y) or (self.endx==x and self.endy==y)
end

local function createpick(side,picks)
	local x = side=='start' and self.startx or self.endx
	local y = side=='start' and self.starty or self.endy
	for _,tp in ipairs(picks) do
		if tp~=self and tp.intersects(x,y) then
			return
		end
	end
	return newToothpick(x,y,not self.horizontal)
end

function self.createpicks(picks)
	return createpick('start',picks), createpick('end',picks)
end

function self.draw()
	lg.setColor(self.new and {.1,.4,.1,1} or {0,0,0,1})
	lg.setLineWidth(2)
	lg.line(self.startx,self.starty,self.endx,self.endy)
end

return self
end