dofile(minetest.get_modpath("debugtools").."/src/photometer.lua")

local environment = minetest.settings:get("environment")
if not environment or environment == "production" then
	return
end

dofile(minetest.get_modpath("debugtools").."/src/commands.lua")
dofile(minetest.get_modpath("debugtools").."/src/embrasure.lua")
dofile(minetest.get_modpath("debugtools").."/src/lists.lua")
