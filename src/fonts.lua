local fonts = {
    main = love.graphics.newFont("fonts/ComicNeueSansID.ttf", 20)
}

fonts.main:setLineHeight(0.75)

-- use with require() in a variable
return fonts