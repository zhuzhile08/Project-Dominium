local entity = { }
entity.__index = entity

function entity.new(posX, posY, rot, scaleX, scaleY)
	local self = setmetatable({}, entity)

	self.transform = love.math.newTransform(posX, posY, rot, scaleX, scaleY)

	return self
end

function entity:update(dt) end
function entity:physicsUpdate() end

return entity
