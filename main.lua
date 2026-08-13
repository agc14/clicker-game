-- game core files
local fonts = require "src.fonts"
local audio = require "src.audio"
local textures = require "src.textures"

-- i'd suggest on using tables instead of variables since it might make the program messy
-- should i separate this to a different file?
local money = {
    amount = 0,
    -- same as m_add
    add = 1,
    -- enable/disable autoclicker here
    use_autoclicker = true,
    auto_add = 1,
    -- leave unchanged, same as m_sec
    sec = 1,
    -- how much seconds for money increment
    interval = 2
}

--TODO: Implement saving using .json?

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.mouse.setCursor(textures.cursor)
    love.graphics.setFont(fonts.main)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        money.amount = money.amount + money.add
        audio.clicksound:play()
        --TODO: Implement text "popup" effect while clicking
        -- something like "+1$"
    end
end

function love.update(dt)
    if money.use_autoclicker then
        if money.sec < money.interval then
            money.sec = money.sec + dt
        else
            -- reset money.sec to 1
            money.sec = 1
            money.amount = money.amount + money.add
            -- audio.clicksound:play()
            -- "cacophony"
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("$" .. money.amount, 5, 0)

    if not money.use_autoclicker then
        love.graphics.printf("-- AUTOCLICKER DISABLED --", 0, 0, love.graphics.getWidth(), "center")
    else
        -- \n is to make a new line
        love.graphics.print("\n$ per sec: " .. money.add .. "\ninterval: " .. money.interval - 1 .. "s", 5, 0)
    end
end
