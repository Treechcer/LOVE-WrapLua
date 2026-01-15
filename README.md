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

- having [pdp unpacket](https://github.com/PSP-Archive/pbp-unpacker) to unpack the included pdp so you can have your own image, name etc. on your PSP home screen (XMB).
- having [PARAM SFO EDITOR](https://www.gamebrew.org/wiki/SFO_Editor_PSP) to change the name and icons for your PSP game.
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
    t.cleanUp = 2500
end
```

and your main.lua should have love.load(), love.update(dt) and love.graphics() and any other game logic. Identity is just the name of your gamem and cleanUp is time (in frames) that you'll automatically call graphical clean up on cache, it defaults to 2500 frames, you can change it to any frame count you want (I recommend having on some count at least but negative numbers should stop it from happening at all if you want that - you can technically call it yourself with `love.helpers.graphicsCleanUp()` or `love.helpers.fullGraphicsCleanUp()` if you want to manage the cache yourself).

> NOTE: you can use more files, any kind of files you work with your game can be there this library can work with images from default, any other file type you have to write and work with.

Folder for LOVE-WrapLua should be the folder in this repository called the same (or your changed version of course or any other forks that exist).

savedata\ should be initially empty folder (if you write files it saves it there).

When you have modded PSP on your SD card you should see this folder folders like `PSP\GAME\...`, where you'll put your game folder. Which will be `PSP\GAME\your-game`. When you add your game it should be on your XMB and it should work.

#### love.helpers.graphicsCleanUp() vs love.helpers.fullGraphicsCleanUp()

`love.helpers.graphicsCleanUp()` has algorithm that tries to delete unused things, if it's used it'll not delete it. This is used when the automatic cache cleaning is active.

`love.helpers.fullGraphicsCleanUp()` deletes ALL images, doesn't matter how much they're used, it'll just delete them.

### custom eboot.pbp

If you don't want to have the DDLC eboot.pbp you have to creat your own or customize the DDLC one. I think it's easier to customize the eboot.pbp. You'll have to have app called `pbp-unpacker` which is in recommended list and `ebott.pbp` you want to customize. Go to your pbp-unpacker and click on button `open` and select the the fole for the eboot.pbp you want to unpack and then customize, then click on `extract` and select where you want to sve it. Now you have this finished you have to update the `param.sfo` file, in app like `param sfo editor` in recommended apps again. You can use some of the templates in the app or the one from DDLC which you extracted. Your param sfo HAS to have at least this parameters:

- BOOTABLE - 1
- CATEGORy - MG
- DISC_ID - unique ID for your game wich includes region ULE (EU), UCUS (USA) etc. and 5 other digits. So something like ULE12345 etc.
- DISC_VERSION - 1.00
- MEMSIZE - 1
- PARENTAL_LEVEL - 1
- PSP_SYSTEM_VER - 1.00
- REGION - 32768
- TITLE - your-game

> NOTE: I don't know what most things do, so you'll have to read on it if you want to know, if this will have any issues, I'll fix it later but this worked for me.

After this you can save your param.sfo anywhere you'll find it again.

Now you should open `pbp-unpacker` to make your own .pbp and be able to play your game and have correct things on your XMB (name, icons etc.). Click on `New` and add your .sfo file you've just made to `param.sfo`. Take the `DATA.PSP` from the DDLC project, I don't know how to make my own and it worked with that file so it's fine. Now you can add your icon to `ICON0.png` which has resolution of 144x80 and for background image you are adding it into `PIC1.png` which has resolution of 480x272. I don't know what other files but when I'll know I'll edit this part but even without any more files it can run and works as it should. Now you can click `save` and have your custom eboot.pbp.
