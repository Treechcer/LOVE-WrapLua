function love.helpers.fullGraphicsCleanUp()
    love.graphics.graphicsCache = {
        imgs = {},
        uses = {}
    }
end

function love.helpers.graphicsCleanUp()
    local t = lv1lua.cleanUp / 5

    for key, value in pairs(love.graphics.graphicsCache.uses) do
        if value < t then
            love.graphics.graphicsCache.uses[key] = nil
            love.graphics.graphicsCache.imgs[key] = nil
        else
            love.graphics.graphicsCache.uses[key] = 0
        end
    end
end