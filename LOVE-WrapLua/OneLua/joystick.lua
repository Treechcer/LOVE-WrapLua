love.joystick = {
    joys = 0
}
love.joystick.joysticks = {}

local platform = ""

if lv1lua.isPSP then
    platform = "PSP"
    table.insert(love.joystick.joysticks, nameJoyStick("PSP Controller"))
    love.joystick.joys = 1
elseif lv1lua.mode == "PS3" then
    platform = "PS3"
else
    platform = "Vita"
end

function love.joystick.getJoystickCount()
    return love.joystick.joys
end

function love.joystick.getJoysticks()
    return love.joystick.joysticks
end

function nameJoyStick(name)
    joy = {
        name = name,

    }

    function joy:getName()
        return self.name
    end

    function joy:getGamepadAxis(where)
        if platform == "PSP" then
            x = buttons.analoglx
            y = buttons.analogly

            if where == "leftx" then
                  local a = x / 127
                return a < -1 and -1 or a
            elseif where == "lefty" then
                local a = y / 127
                return a < -1 and -1 or a
            else
                return 0
            end

        end
    end

    return joy
end