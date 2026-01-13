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