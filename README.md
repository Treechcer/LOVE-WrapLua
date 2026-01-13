# LOVE-WrapLua

A small and simple LOVE2D wrapper for OneLua, lpp-vita, and Lua Player PS3

You can use this to make LOVE2D stuff for a PSP, PS Vita, and/or PS3! As an example, this is used on [DDLC-LOVE](https://github.com/LukeZGD/DDLC-LOVE/)

This is made just for fun and will only have the basic stuff.

- See `Implemented.md` for the list of implemented stuff
- `script.lua` is the main file for LOVE-WrapLua (required)
- `index.lua` is for lpp-vita to run `script.lua` (required for lpp-vita only)
- `app.lua` is for Lua Player PS3 to run `script.lua` (required for Lua Player PS3 only)
- `lv1luaconf` in `conf.lua` is to set up some settings for key configuration `keyconf`, resolution scale `resscale`, and image scale `imgscale`. This is optional; See `script.lua` for the default values

## Fork README.md

I'm trying to make the original library work better and work for most of hte stuff. For now I'm focusing on PSP because I don't have access to PS3 and PS Vita for now (+ the original documentation doesn't really show how to make PS3 and PS Vita versions sadly which I'll have to figure out and document), also the PSP version seems kinda lacking from all the other versions (I haven't look into them for now).

### Running on PSP

> ⚠️ most love2D functions for now doesn't work (or weren't implemented*).

For this you have to:

- Own PSP (any version will do).
- PSP being able to play homebrew apps (being modded with CFW).
- SD to PSP card, with any SD that can fit your game and all needed files (I recommend you more 32 GB or more).
- USB mini B, SD card reader or [FTP server app](https://github.com/PSP-Archive/PSP-FTPD) on your modded PSP or any other way to put your files / game onto your PSP.
- some kind of love2D code that can be executed and works without errors.
- having copy of this repo on your disc.
- patience...

Recommendation:

- having [eboot.pdp unpacket](https://github.com/PSP-Archive/pbp-unpacker) to unpack the included pdp so you can have your own image, name etc. on your PSP home screen (XMB).
- this will be expanded...

### Set up

First, you have to set up your game folder. You have to have this structure:
```
game\
LOVE-WrapLua\
savedata\
EBOOT.PBP
oneFont.pgf
script.lua
```

game folder => your game.

>NOTE: main.lua and conf.lua ARE necessary, your game HAS to have them.

minimalistic conf.lua (this is the minimum):

```lua
function love.conf(t)
    t.identity = "your-game-name"
end
```

and your main.lua should have love.load(), love.update(dt) and love.graphics() and any other game logic.

> NOTE: you can use more files, any kind of files you work with your game can be there this library can work with images from default, any other file type you have to write and work with.

Folder for LOVE-WrapLua should be the folder in this repository called the same (or your changed version of course or any other forks that exist).

savedata\ should be initially empty folder (if you write files it saves it there).

When you have modded PSP on your SD card you should see this folder folders like `PSP\GAME\...`, where you'll put your game folder. Which will be `PSP\GAME\your-game`. When you add your game it should be on your XMB and it should work.
