mountgen = {}

local default_config = {
	ANGLE=60,
	HEAD_ANGLE = 120,
	TOP_H = 0.3,
	Y0 = 0,
	USE_DIAMOND_SQUARE = true,
	SNOW_LINE = 50,
	SNOW_LINE_RAND = 4,
	GRASS_PERCENT = 10,
	FLOWERS_LINE = 35,
	FLOWERS_PERCENT = 10,
	TREE_LINE = 20,
	TREE_PROMILLE = 4,

	rk_big = 2,
	rk_small = 6,
	rk_thr = 4,
}


minetest.register_tool("mountgen:mount_tool", {
	description = "Горный посох",
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, user, pointed_thing)
		local user_name = user:get_player_name()
		local can_access = minetest.get_player_privs(user_name).admin_pick
		if not can_access then
			return
		end
		local top = user:get_pos()
		local config = default_config
		minetest.log("use mount stick at "..top.x.." "..top.y.." "..top.z)
 
		if config.USE_DIAMOND_SQUARE then
			fun = mountgen.diamond_square
		else
			fun = mountgen.cone
		end

		mountgen.mountgen(top, fun, config)
		return itemstack
	end,
	on_place = function(itemstack, placer, pointed_thing)
		
	end,
	group = {},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

dofile(minetest.get_modpath("mountgen").."/map.lua")
dofile(minetest.get_modpath("mountgen").."/height_map.lua")
dofile(minetest.get_modpath("mountgen").."/cone.lua")
dofile(minetest.get_modpath("mountgen").."/diamond_square.lua")
dofile(minetest.get_modpath("mountgen").."/mountgen.lua")

