local entity = require "Entities.entity"
local vec2 = require "vector2"
local key = require "input"

local camera = { }
camera.__index = camera

function camera.new(posX, posY, rot, scaleX, scaleY, speed, boundingBox) 
	speed = speed or 8
	boundingBox = boundingBox or vec2.new(math.huge, math.huge) -- upper-left edge of the bounding box is always 0, 0
	vel = vel or 10

	local self = entity.new(posX, posY, rot, scaleX, scaleY)

	self.boundingBox = boundingBox
	self.vel = vel

	self.up = key.new("up", function(dt)
		self.transform:translate(0, -speed * dt)
	end)

	self.down = key.new("down", function(dt)
		self.transform:translate(0, speed * dt)
	end)

	self.left = key.new("left", function(dt)
		self.transform:translate(-speed * dt, 0)
	end)

	self.right = key.new("right", function(dt)
		self.transform:translate(0, speed * dt, 0)
	end)

	function self:update(dt) 
		KeyboardInputSystem:add(up)
		KeyboardInputSystem:add(down)
		KeyboardInputSystem:add(left)
		KeyboardInputSystem:add(right)

		love.graphics.pop()
		love.graphics.applyTransform(self.transform)
		love.graphics.push()
	end

	love.graphics.applyTransform(self.transform) -- hack to get update to work
	love.graphics.push()

	return self
end

return camera
