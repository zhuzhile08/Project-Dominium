require "conf"
require "init"

function love.draw()
    drawTilemap(Tilemap, 1.5)
end

function love.update(dt)
    Camera:update(dt)
    KeyboardInputSystem:update(dt)
end
