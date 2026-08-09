function love.load()
    cursor = love.mouse.newCursor("assets/sprites/cursor.png", 0, 0)
    love.mouse.setCursor(cursor)

    font = love.graphics.newFont("fonts/ComicNeueSansID.ttf", 20)
    love.graphics.setFont(font)

    money = 0
    m_add = 1
    m_sec = 0
end

function love.mousepressed(x, y, button)
    if button == 1 then
        money = money + m_add
    end
end

function love.update(dt)
    function love.keypressed(key)
        if key == "escape" then
            love.event.quit()
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("$" .. money, 5, 0)
    love.graphics.print("$ per sec: " .. m_sec, 5, 10)
end