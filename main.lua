function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    local cursor = love.mouse.newCursor("assets/sprites/cursor.png", 0, 0)
    love.mouse.setCursor(cursor)

    local font = love.graphics.newFont("fonts/ComicNeueSansID.ttf", 20)
    love.graphics.setFont(font)

    clicksound = love.audio.newSource("assets/sfx/clicksound.wav", "static")

    money = 0
    m_add = 1
    m_sec = 1
end

function love.mousepressed(x, y, button)
    if button == 1 then
        money = money + m_add
        clicksound:play()
    end
end

local t = 0
local count = 0

function love.update(dt)
    if t < 2 then
        t = t + dt
    else
        t = 0
        count = count + 1
    end

    if count == 1 then
        money = money + m_sec
        count = 0
    end
end

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