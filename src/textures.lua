local textures = {
    -- mouse asset moved to love.load()
    checkebgr1 = love.graphics.newImage("assets/sprites/bg/checkebgr1.png"),
    checkebgr2 = love.graphics.newImage("assets/sprites/bg/checkebgr2.png"),
    checkebgr3 = love.graphics.newImage("assets/sprites/bg/checkebgr3.png"),
    checkebgr4 = love.graphics.newImage("assets/sprites/bg/checkebgr4.png"),
    coin = love.graphics.newImage("assets/sprites/particles/coin.png"),
    darkdollar = love.graphics.newImage("assets/sprites/particles/darkdollar.png"),
}

-- set all textures to nearest neighbor in textures table
for _, v in pairs(textures) do
    v:setFilter("nearest", "nearest")
end

return textures