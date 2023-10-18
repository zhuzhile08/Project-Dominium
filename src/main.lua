require "conf"
require "init"

function love.draw()
    drawTilemap(Tilemap, 1.5)
end

function love.update(dt)
    -- love.graphics.applyTransform()
    KeyboardInputSystem:update(dt)
end
