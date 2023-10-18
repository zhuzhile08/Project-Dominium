require "conf"
require "init"

function love.draw()
    Camera:beginDraw()
    drawTilemap(Tilemap, 1.5)
    Camera:endDraw()
end

function love.update(dt)
    Camera:update(dt)
    KeyboardInputSystem:update(dt)
end
