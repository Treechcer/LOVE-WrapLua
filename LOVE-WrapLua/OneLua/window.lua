love.window = {
    width  = 480,
    height = 272,

    realWidth  = 480,
    realHeight = 272,

    scaleX = 1,
    scaleY = 1
}

function love.window.setMode(width, height, flags)
    --flags do nothing, it's more for compatibility thing
    love.window.width = width
    love.window.height = height

    love.window.scaleX = love.window.realWidth  / width
    love.window.scaleY = love.window.realHeight / height
end