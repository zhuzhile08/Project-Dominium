require "init"
require "Tilemap.tilemap"

function love.draw()
    drawTilemap(Tilemap, 1.5)
end

function love.update(dt)
    KeyboardInputSystem:update(dt)
end
