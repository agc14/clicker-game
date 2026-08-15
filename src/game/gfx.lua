local gfx = {}

---renders image with tiling
---@param img love.Image
function gfx.tileImg(img)
    for x = 1, math.ceil(love.graphics.getWidth() / img:getWidth()) do
        for y = 1, math.ceil(love.graphics.getHeight() / img:getHeight()) do
            love.graphics.draw(img, img:getWidth() * (x - 1), img:getHeight() * (y - 1))
        end
    end
end

return gfx
