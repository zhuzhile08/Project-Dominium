local entity = require "Entities.entity"
local vec2 = require "vector2"
local key = require "input"

local camera = { }
camera.__index = camera

function camera.new(posX, posY, rot, scaleX, scaleY, speed, boundingBox) 
	speed = speed or 200
	boundingBox = boundingBox or vec2.new(math.huge, math.huge) -- upper-left edge of the bounding box is always 0, 0
	speed = speed or 10

	local self = entity.new(posX, posY, rot, scaleX, scaleY)

	self.boundingBox = boundingBox
	self.speed = speed

	self.up = key.new("w", function(dt)
		self.transform:translate(0, speed * dt)
	end)

	self.down = key.new("s", function(dt)
		self.transform:translate(0, -speed * dt)
	end)

	self.left = key.new("a", function(dt)
		self.transform:translate(speed * dt, 0)
	end)

	self.right = key.new("d", function(dt)
		self.transform:translate(-speed * dt, 0)
	end)

	function self:update(dt) 
		KeyboardInputSystem:add(self.up)
		KeyboardInputSystem:add(self.down)
		KeyboardInputSystem:add(self.left)
		KeyboardInputSystem:add(self.right)
	end

	function self:beginDraw()
		love.graphics.push()
		love.graphics.applyTransform(self.transform)
	end

	function self:endDraw()
		love.graphics.pop()
	end

	return self
end

return camera
