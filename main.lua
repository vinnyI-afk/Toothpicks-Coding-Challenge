io.stdout:setvbuf('no')

lg = love.graphics
lg.setDefaultFilter('nearest')
require 'toothpick'

local picks = {}
local scale = 1

function love.load()
	lg.setBackgroundColor(1,1,1,1)
	table.insert(picks, newToothpick(0,0,true))
end

function love.update(dt)
	local newscale = (lg.getWidth()/2)/math.abs(picks[#picks].startx)
	scale = scale+(newscale-scale)*dt*5
end

function love.mousepressed(x,y,b)
	if b==1 then
		for i=#picks,1,-1 do
			if not picks[i].new then return end
			local a,b = picks[i].createpicks(picks)
			table.insert(picks, a)
			table.insert(picks, b)
			picks[i].new=false
		end
	end
end

function love.draw()
	lg.translate(lg.getWidth()/2,lg.getHeight()/2)
	lg.scale(scale*.95)
	for i=#picks,1,-1 do
		picks[i].draw()
	end
end