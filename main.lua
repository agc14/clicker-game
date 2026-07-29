function love.load()
    function love.keypressed(key)
        if key == "escape" then
            love.event.quit()
        end
    end

    money = 0
    m_add = 1
end

function love.update(dt)
    function love.keypressed(key)
        if key == "space" then
            money = money + m_add
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 0)
    love.graphics.setColor(1, 0.3, 0)
    love.graphics.print("Money: " .. money, 0, 0)
    love.graphics.print("Press space to get money", 0, 10)
end