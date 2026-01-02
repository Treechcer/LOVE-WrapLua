love.window = love.window or {}

love.window.width  = love.window.width  or 480
love.window.height = love.window.height or 272

love.window.realWidth  = love.window.realWidth  or 480
love.window.realHeight = love.window.realHeight or 272

love.window.scaleX = love.window.scaleX or 1
love.window.scaleY = love.window.scaleY or 1


function love.window.setMode(width, height, flags)
    --flags do nothing, it's more for compatibility thing
    --the scaling is incorrect, idk why, I might fix it oneday

    width  = width  or love.window.width
    height = height or love.window.height

    love.window.width = width
    love.window.height = height

    love.window.scaleX = love.window.realWidth  / width
    love.window.scaleY = love.window.realHeight / height
end