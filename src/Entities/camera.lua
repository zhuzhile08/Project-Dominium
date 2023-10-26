require "utility"

local entity = require "Entities.entity"
local vec2 = require "vector2"

local camera = { }
camera.__index = camera

function camera.new(posX, posY, rot, scaleX, scaleY, boundingBox) 
	boundingBox = boundingBox or vec2.new(-TilemapWidth * 16, -TilemapHeight * 16)

	local self = entity.new(posX, posY, rot, scaleX, scaleY)

	self.target = entity.new(0, 0, 0, 0, 0)
	self.boundingBox = boundingBox

	function self:update(dt) 
		self.translation.x = clamp(
			-self.target.translation.x * GraphicsGlobalScale + love.graphics.getWidth() / 2, 
			self.boundingBox.x * self.scale.x + love.graphics.getWidth(), 
			0
		)
		self.translation.y = clamp(
			-self.target.translation.y * GraphicsGlobalScale + love.graphics.getHeight() / 2,
			self.boundingBox.y * self.scale.y + love.graphics.getHeight(),
			0
		)
	end

	function self:target(target)
		self.target = target
	end

	function self:screenShake(translateIntensity, rotationIntensity, scaleIntensity)

	end

	function self:beginDraw()
		love.graphics.push()
		love.graphics.translate(self.translation.x, self.translation.y)
		love.graphics.rotate(self.rotation)
		love.graphics.scale(self.scale.x, self.scale.y)
	end

	function self:endDraw()
		love.graphics.pop()
	end

	return self
end

return camera
