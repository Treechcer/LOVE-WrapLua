--timer stuff for update dt
lv1lua.timer = timer.new()
local gtimer = timer.new()
lv1lua.timer:start()
gtimer:start()
dt = 0

function love.timer.getTime()
    return gtimer:time() / 1000
end

function love.timer.getDelta()
    return dt
end

local os = love.system.getOS()

if os == "PSP" then
    function love.timer.getFPS()
        return screen.fps()
    end
elseif os == "PS3" or os == "Vita" then
    function love.timer.getFPS()
        --haven't gotten really to PS3 or Vita, so it returns this random number
        --next console I'll port is PS3 btw
        return 123456
    end
end