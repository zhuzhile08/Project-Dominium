require "conf"
require "init"

function love.draw()
    Camera:beginDraw()
    drawTilemap(Tilemap)
    Player:draw()
    Camera:endDraw()
end

function love.update(dt)
    Player:update(dt)
    Camera:update(dt)
end
