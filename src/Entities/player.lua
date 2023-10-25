local entity = require "Entities.entity"
local vec2 = require "vector2"
local key = require "input"

local player = { }
player.__index = player

function player.new(posX, posY, rot, scaleX, scaleY, speed)
    local self = entity.new(posX, posY, rot, scaleX, scaleY)

	self.speed = speed

    self.up = key.new("w", function(dt)
		self.translation.y = self.translation.y + self.speed * dt
	end)

	self.down = key.new("s", function(dt)
		self.translation.y = self.translation.y - self.speed * dt
	end)

	self.left = key.new("a", function(dt)
		self.translation.x = self.translation.x + self.speed * dt
	end)

	self.right = key.new("d", function(dt)
		self.translation.x = self.translation.x - self.speed * dt
	end)

    function self:update(dt)
        KeyboardInputSystem:add(self.up)
        KeyboardInputSystem:add(self.down)
        KeyboardInputSystem:add(self.left)
        KeyboardInputSystem:add(self.right)
    end

    return self
end

return player
