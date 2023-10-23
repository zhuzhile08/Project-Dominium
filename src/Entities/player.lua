local entity = require "Entities.entity"
local vec2 = require "vector2"
local key = require "input"

local player = { }
player.__index = player

function player.new(posX, posY, rot, scaleX, scaleY)
    local self = entity.new(posX, posY, rot, scaleX, scaleY)

    

    function self:draw()

    end

    function self:update(dt)

    end

    return self
end
