require "conf"
require "init"

function love.draw()
    Camera:beginDraw()
    drawTilemap(Tilemap)
    Camera:endDraw()
end

function love.update(dt)
    Player:update(dt)
    Camera:update(dt)
    KeyboardInputSystem:update(dt)
end
