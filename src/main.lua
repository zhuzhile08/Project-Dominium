require "conf"
require "init"

function love.draw()
    Camera:beginDraw()
    drawTilemap(Tilemap)
    Player:draw()
    Solider:draw()
    Solider1:draw()
    Solider2:draw()
    Camera:endDraw()
end

function love.update(dt)
    Player:update(dt)
    Solider:update(dt)
    Solider1:update(dt)
    Solider2:update(dt)
    Camera:update(dt)
end
