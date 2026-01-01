function love.keyboard.isDown(key)
    local status, result = pcall(function() return buttons.held[key] end)
    if status then
        return result or false
    else
        return false
    end
end

function love.keyboard.showTextInput(table)
    if table then
        local header = {"",""}
        if table["header"] then header[1] = table["header"] end
        if table["subheader"] then header[2] = table["subheader"] end
        local text = osk.init(header[1],header[2])
        if text and text ~= "" then love.textinput(text) end
    end
end

function love.keyboard.setTextInput(table)
    love.keyboard.showTextInput(table)
end
