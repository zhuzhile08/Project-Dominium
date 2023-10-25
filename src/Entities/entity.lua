local vec2 = require "vector2"

local entity = { }
entity.__index = entity

function entity.new(posX, posY, rot, scaleX, scaleY)
	local self = setmetatable({}, entity)

	self.translation = vec2.new(posX, posY)
	self.rotation = rot
	self.scale = vec2.new(scaleX, scaleY)

	return self
end

return entity
