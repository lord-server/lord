-- sfinv/init.lua

sfinv = {
	enabled = true
}


dofile(minetest.get_modpath("sfinv") .. "/form.lua")
dofile(minetest.get_modpath("sfinv") .. "/nav.lua")
dofile(minetest.get_modpath("sfinv") .. "/pages.lua")
dofile(minetest.get_modpath("sfinv") .. "/context.lua")
dofile(minetest.get_modpath("sfinv") .. "/api.lua")

-- Load support for MT game translation.
local S = minetest.get_translator("sfinv")
