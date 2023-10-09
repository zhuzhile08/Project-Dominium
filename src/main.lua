function love.load()
    love.graphics.setBackgroundColor(1, 0.2, 0) -- Set background color to orange
end

function love.draw()
    love.graphics.setColor(1, 0.2, 0)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("fill", 0, 0, 20, 20)
end

