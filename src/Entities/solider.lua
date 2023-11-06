local entity = require "Entities.entity"

local solider = { }
solider.__index = solider

function solider.new(posX, posY, rot, scaleX, scaleY, quad, speed, followDst)
	local self = entity.new(posX, posY, rot, scaleX, scaleY)

	self.quad = quad
	self.speed = speed
	self.followDst = followDst
	self.target = entity.new(0, 0, 0, 0, 0)

	function self:target(target)
		self.target = target
	end

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
		local nextPosition = self.target.translation
		local dx = math.floor(self.translation.x - nextPosition.x)
		local dy = math.floor(self.translation.y - nextPosition.y)
		local distanceSquared = dx * dx + dy * dy

		if (distanceSquared > followDst) then
			if dx > 0 then 
				dx = -1
				self.scale.x = -1
			elseif dx < 0 then
				dx = 1
				self.scale.x = 1
			else 
				dx = 0
			end

			if dy > 0 then 
				dy = -1
			elseif dy < 0 then
				dy = 1
			else 
				dy = 0
			end
	
			if dx ~= 0 and dy ~= 0 then
				dx = dx * 0.70711
				dy = dy * 0.70711
			end
	
			self.translation.x = self.translation.x + dx * dt * self.speed
			self.translation.y = self.translation.y + dy * dt * self.speed
		end
	end

	return self
end

return solider
