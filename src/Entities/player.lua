local entity = require "Entities.entity"
local vec2 = require "vector2"

local player = { }
player.__index = player

function player.new(posX, posY, rot, scaleX, scaleY, quad, speed)
    local self = entity.new(posX, posY, rot, scaleX, scaleY)

	self.speed = speed
	self.quad = quad

	function self:draw()
		love.graphics.draw(
			SpriteSheetTexture, 
			quad,
			self.translation.x,
			self.translation.y,
			0,
			self.scale.x,
			self.scale.y,
			8,
			8
		)
	end

    function self:update(dt)
		dx = 0
		dy = 0

		if love.keyboard.isDown("w") then
			dy = -1
		end
		if love.keyboard.isDown("s") then
			dy = 1
		end

        if love.keyboard.isDown("d") then
			dx = 1
			self.scale.x = 1
		end
		if love.keyboard.isDown("a") then
			dx = -1
			self.scale.x = -1
		end

		if dx ~= 0 and dy ~= 0 then
			dx = dx * 0.70711
			dy = dy * 0.70711
		end

		self.translation.x = self.translation.x + dx * dt * self.speed
		self.translation.y = self.translation.y + dy * dt * self.speed
    end

    return self
end

return player
