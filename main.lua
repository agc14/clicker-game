-- game core files
local fonts    = require "src.fonts"
local audio    = require "src.audio"
local textures = require "src.textures"
local gfx      = require "src.game.gfx"
local save     = require "src.game.save"
local handler  = require "src.game.handler"
local tools    = require "lib.tools"
local effect   = require "src.game.effect"

-- libs
anim8          = require "lib.anim8"

-- stats
local money    = require "src.stats.money"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- actually nevermind
    local cursor = love.mouse.newCursor("assets/sprites/system/cursor.png", 0, 0)
    love.mouse.setCursor(cursor)

    local sv = save.readjson("file1")
    ---@diagnostic disable
    -- used to check if values in save file are not empty
    -- might separate this soon
    if next(sv) ~= nil then
        money = sv
    end
    ---@diagnostic enable

    love.graphics.setFont(fonts.main)
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.quit()
    save.writejson("file1", money)
end

function love.resize(w, h)
    -- there must be a better way than this right
    handler.circRDef = love.graphics.getHeight() / 2.5
    handler.circR = handler.circRDef
end

function love.mousepressed(x, y, button)
    if button == 1 then
        money.amount = money.amount + money.add
        audio.clicksound:play()
        handler.circR = love.graphics.getHeight() / 2.7
        effect.newtxt(handler.textefct, "+" .. money.add .. "$", fonts.main, love.math.random(x - 50, x + 50),
            love.math.random(y - 50, y + 50), "#4F9135", 0, 2, 0, -200, 400)
    end
end

function love.update(dt)
    effect.updtxt(handler.textefct, dt)

    if handler.circR < handler.circRDef then
        handler.circR = handler.circR + dt * 200
    end

    if money.use_autoclicker then
        if money.sec < money.interval then
            money.sec = money.sec + dt
        else
            -- reset money.sec to 1
            money.sec = 1
            money.amount = money.amount + money.auto_add
            -- audio.clicksound:play()
            -- "cacophony"
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "f11" then
        love.window.setFullscreen((not love.window.getFullscreen()) and true or false)
    end
end

function love.draw()
    local center_h, center_v = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
    love.graphics.setColor(1, 1, 1)
    gfx.tileImg(textures.checkebgr1)

    love.graphics.setColor(1, 1, 1, 0.6)
    love.graphics.circle("fill", center_h, center_v, handler.circR)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("$" .. money.amount, fonts.large, 0, center_v - fonts.large:getHeight() / 2,
        love.graphics.getWidth(), "center")

    -- \n is to make a new line
    love.graphics.printf((not money.use_autoclicker) and "-- AUTOCLICKER DISABLED --" or
        "$/sec: " .. money.auto_add .. "\ninterval: " .. money.interval - 1 .. "s"
        , 0, center_v + 40 - fonts.main:getHeight() / 2, love.graphics.getWidth(), "center")

    effect.drwtxt(handler.textefct)

    -- this was hacky
    love.graphics.setColor(tools.hexrgb("23A1A1"))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth() * ((money.sec - 1) / (money.interval - 1)), 20)
end
