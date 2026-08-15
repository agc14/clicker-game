local effect = {}
local tools = require "lib.tools"
local table = table

---creates new text object via table.insert() in table
---@param tab table
---@param str string
---@param font love.Font
---@param x integer
---@param y integer
---@param col string | number | table
---@param tlimit integer
---@param fadespd integer
---@param vx integer | nil
---@param vy integer | nil
---@param accelspd integer | nil
function effect.newtxt(tab, str, font, x, y, col, tlimit, fadespd, vx, vy, accelspd)
    table.insert(tab, {
        str = str,
        font = (font) and font or love.graphics.newFont(12),
        x = x,
        y = y,
        col = (type(col) == "string" or type(col) == "number") and tools.hexrgb(col) or col,
        t = 0,
        a = 1,
        tlimit = tlimit,
        fadespd = fadespd,
        vx = (vx) and vx or 0,
        vy = (vy) and vy or 0,
        accelspd = (accelspd) and accelspd or 0,
    })
end

function effect.updtxt(tab, dt)
    for i = #tab, 1, -1 do
        local txt = tab[i]
        txt.x, txt.y = txt.x + dt * txt.vx, txt.y + dt * txt.vy
        txt.vx, txt.vy = (txt.vx ~= 0) and txt.vx + dt * txt.accelspd or txt.vx, (txt.vy ~= 0) and txt.vy + dt * txt.accelspd or txt.vy

        if txt.t < txt.tlimit then
            txt.t = txt.t + dt
        else
            if txt.a > 0 then
                txt.a = txt.a - dt * txt.fadespd
            else
                table.remove(tab, i)
            end
        end
    end
end

function effect.drwtxt(tab)
    for i = #tab, 1, -1 do
        local txt = tab[i]

        ---@type love.Font
        local font = txt.font

        -- love.graphics.setColor(1, 1, 1)
        -- love.graphics.rectangle("fill", txt.x, txt.y + font:getHeight(), font:getWidth(txt.x .. ", " .. txt.y), font:getHeight())
        -- love.graphics.setColor(0, 0, 0)
        -- love.graphics.print(txt.x .. ", " .. txt.y, txt.font, txt.x, txt.y + font:getHeight())

        love.graphics.setColor(txt.col[1], txt.col[2], txt.col[3], txt.a)
        love.graphics.print(txt.str, font, txt.x, txt.y)
    end
end

return effect
