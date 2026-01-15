pad.InitPads(1)
lv1lua.key = {
    up=0,down=0,left=0,right=0,
    cross=0,circle=0,square=0,triangle=0,
    l=0,r=0,select=0,start=0
}

function love.keyboard.isDown(key)
    return pad[key](0) > 0
end

function love.keyboard.showTextInput(table)
    --textinput
end

function love.keyboard.setTextInput(table)
    love.keyboard.showTextInput(table)
end
