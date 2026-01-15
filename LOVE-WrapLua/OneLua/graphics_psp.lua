-- old graphics.lua for psp compat
local defaultfont
local scale = 0.375
local fontscale = 0.6

love.graphics.graphicsCache = {
    imgs = {},
    uses = {}
}

local function sxF(x)
    return x * love.window.scaleX
end

local function syF(y)
    return y * love.window.scaleY
end

--default print font
defaultfont = {font=font.load("oneFont.pgf"),size=15}
font.setdefault(defaultfont.font)

--set up stuff
lv1lua.current = {font=defaultfont,color=color.new(255,255,255,255)}

function love.graphics.newImage(filename)
    local img = image.load(lv1lua.dataloc.."game/"..filename)

    if lv1luaconf.imgscale == true then
        image.scale(img,scale*100)
    end
    local imgWrapper =
    {
        imgData = img,
        flipX = false,
        flipY = false,
        getWidth = function(self) return image.getrealw(self.imgData) end,
        getHeight = function(self) return image.getrealh(self.imgData) end,
        getDimensions = function(self) return image.getrealw(self.imgData), image.getrealh(self.imgData) end,
        filename = filename
    }
    --Necessary to execute the same behavior from love2d desktop
    function imgWrapper:__handleNegativeScale(x, y, sx, sy)
        if(sx > 0 and self.flipX) then
            image.fliph(self.imgData)
            self.flipX = not self.flipX
        elseif(sx < 0 and self.flipX == false) then
            image.fliph(self.imgData)
            self.flipX = not self.flipX
        end
        if(sy > 0 and self.flipY) then
            image.flipv(self.imgData)
            self.flipY = not self.flipY
        elseif(sy < 0 and self.flipY == false) then
            image.flipv(self.imgData)
            self.flipY = not self.flipY
        end
        if(sx < 0) then
            x = x + (self:getWidth() * sx)
        end
        if(sy < 0) then
            y = y + self:getHeight() * sy
        end
        return x,y
    end

    return imgWrapper
end

function love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy)
    local temporaryImg = drawable

    if not temporaryImg then
        return
    end

    x = sxF(x or 0)
    y = syF(y or 0)

    --if sy ~= nil or sx ~= nil or r ~= nil or ox ~= nil or ox ~= nil then
    --    temporaryImg = image.copy()
    --end

    sx = sx or 1
    sy = sy or sx
    r = r or 0
    ox = ox or 0
    oy = oy or 0

    local key = drawable.filename .. "|" .. sx .. "|" .. sy .. "|" .. r .. "|" .. ox .. "|" .. oy

    if not love.graphics.graphicsCache.imgs[key] then
        local img = image.copy(drawable.imgData)

        local finalScaleX = sx * love.window.scaleX
        local finalScaleY = sy * love.window.scaleY
        local finalW = drawable:getWidth() * finalScaleX
        local finalH = drawable:getHeight() * finalScaleY

        image.resize(img, finalW, finalH)

        image.center(img, ox, oy)

        if r ~= 0 then
            image.rotate(img,(r/math.pi)*180) --radians to degrees
        end

        love.graphics.graphicsCache.imgs[key] = img
    end

    --scale 1280x720 to 480x270(psp)
    --if lv1luaconf.imgscale == true or lv1luaconf.resscale == true then
    --    x = x * scale; y = y * scale
    --end
    
    --if sx then
    --    sy = sy or sx
    --    image.resize(drawable, image.getrealw(drawable) * sx, image.getrealh(drawable) * sy)
    --end
    
    image.blit(love.graphics.graphicsCache.imgs[key],x,y,color.a(lv1lua.current.color))
    love.graphics.graphicsCache.uses[key] = love.graphics.graphicsCache.uses[key] + 1
end

function love.graphics.newFont(setfont, setsize)
    if tonumber(setfont) then
        setsize = setfont
    elseif not setsize then
        setsize = 12
    end
    
    if tonumber(setfont) or lv1lua.isPSP then
        setfont = defaultfont.font
    elseif setfont then
        setfont = font.load(lv1lua.dataloc.."game/"..setfont)
    end
        
    local table = {
        font = setfont;
        size = setsize;
    }

    function table:getHeight()
        local scale = (self.size / 18.5) * love.window.scaleY
        return 18.5 * scale
    end

    function table:getWidth(text)
        text = tostring(text or "")
        local scale = (self.size / 18.5) * love.window.scaleY

        local charWidth = 9
        return (#text * charWidth) * scale
    end

    return table
end

function love.graphics.setFont(setfont,setsize)
    if not lv1lua.isPSP and setfont then
        lv1lua.current.font = setfont
    else
        lv1lua.current.font = defaultfont
    end
    
    if setsize then
        lv1lua.current.font.size = setsize
    end
end

function love.graphics.print(text,x,y)
    x = sxF(x or 0)
    y = syF(y or 0)

    local fontsize = (lv1lua.current.font.size / 18.5) * love.window.scaleY
    
    --scale 1280x720 to 480x270(psp)
    --if lv1luaconf.imgscale == true or lv1luaconf.resscale == true then
    --    x = x * scale; y = y * scale
    --    fontsize = fontsize*fontscale
    --end
    
    if text then
        screen.print(lv1lua.current.font.font,x,y,text,fontsize,lv1lua.current.color)
    end
end

function love.graphics.setColor(r,g,b,a)
    if not a then a = 255 end
    if type(r) == "table" then
        g = r[2]
        b = r[3]
        r = r[1]
        a = a or r[4]
    end
    lv1lua.current.color = color.new(r * 255, g * 255, b * 255, a * 255)
end

function love.graphics.setBackgroundColor(r,g,b)
    if type(r) == "table" then
        g = r[2]
        b = r[3]
        r = r[1]
    end

    screen.clear(color.new(r * 255, g * 255, b * 255))
end

function love.graphics.rectangle(mode, x, y, w, h)
    x = sxF(x)
    y = syF(y)
    w = sxF(w)
    h = syF(h)

    --scale 1280x720 to 480x270(psp)
    --if lv1luaconf.imgscale == true or lv1luaconf.resscale == true then
    --    x = x * scale; y = y * scale; w = w * scale; h = h * scale
    --end

    if mode == "fill" then
        draw.fillrect(x, y, w, h, lv1lua.current.color)
    elseif mode == "line" then
        draw.rect(x, y, w, h, lv1lua.current.color)
    end
end

function love.graphics.line(x1,y1,x2,y2)
    draw.line(x1,y1,x2,y2,lv1lua.current.color)
end

function love.graphics.circle(x,y,radius)
    draw.circle(x,y,radius,lv1lua.current.color,30)
end
    

function love.graphics.setDefaultFilter(min, mag, anisotropy) -- this only work for billinear on / off, idk if you can do more
    screen.bilinear(min)
end

function ___displaySystemInfo()
    local currRam = math.floor((os.ram() / 1000000) * 100) / 100
    local totalRam = math.floor((os.totalram() / 1000000) * 100) / 100
    currRam = totalRam - currRam
    screen.print(10, 10, "FPS: " .. screen.fps(), 12 / 18.5, color.new(0, 255, 0, 255))
    screen.print(10, 30, "RAM: " .. currRam .. "/" .. totalRam .. "MB", 12 / 18.5, color.new(0, 255, 0, 255))
    screen.print(10, 50, "CPU: " .. os.cpu() .. "/444Mhz", 12 / 18.5, color.new(0, 255, 0, 255))
end

function love.graphics.getWidth()
    return love.window.width
end

function love.graphics.getHeight()
    return love.window.height
end