local SL = minetest.get_translator("lord_homedecor")

minetest.register_node("lord_homedecor:coffeetable_back", {
	description = SL("Coffee Table"),
	drawtype = "nodebox",
	tiles = {
		"lrfurn_coffeetable_back.png",
		"lrfurn_coffeetable_back.png",
		"lrfurn_coffeetable_back.png",
		"lrfurn_coffeetable_back.png",
		"lrfurn_coffeetable_back.png",
		"lrfurn_coffeetable_back.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					--legs
					{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.3125},
					{0.3125, -0.5, -0.375, 0.375, -0.0625, -0.3125},

					--tabletop
					{-0.4375, -0.0625, -0.4375, 0.4375, 0, 0.5},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.4375, -0.5, -0.4375, 0.4375, 0.0, 1.4375},
				}
	},

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if minetest.is_protected(pos, placer:get_player_name()) then return true end
		local node = minetest.get_node(pos)
		local param2 = node.param2

		local fdir = minetest.dir_to_facedir(placer:get_look_dir(), false)

		if lrfurn.check_forward(pos, fdir, false, placer) then

			node.name = "lord_homedecor:coffeetable_front"
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			minetest.set_node(pos, node)
		else
			minetest.chat_send_player(placer:get_player_name(), SL("No room to place the coffee table!"))
			minetest.set_node(pos, {name = "air"})
			return true
		end

	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if minetest.is_protected(pos, digger:get_player_name()) then return true end

		local param2 = oldnode.param2
		if param2 == 0 then
			pos.z = pos.z+1
		elseif param2 == 1 then
			pos.x = pos.x+1
		elseif param2 == 2 then
			pos.z = pos.z-1
		elseif param2 == 3 then
			pos.x = pos.x-1
		end

		if minetest.is_protected(pos, digger:get_player_name()) then return true end

		if (minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "lord_homedecor:coffeetable_front")
		  and (minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2) then
				minetest.remove_node(pos)
		end
	end,
})

minetest.register_node("lord_homedecor:coffeetable_front", {
	drawtype = "nodebox",
	tiles = {
		"lrfurn_coffeetable_front.png",
		"lrfurn_coffeetable_front.png",
		"lrfurn_coffeetable_front.png",
		"lrfurn_coffeetable_front.png",
		"lrfurn_coffeetable_front.png",
		"lrfurn_coffeetable_front.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					--legs
					{-0.375, -0.5, 0.3125, -0.3125, -0.0625, 0.375},
					{0.3125, -0.5, 0.3125, 0.375, -0.0625, 0.375},

					--tabletop
					{-0.4375, -0.0625, -0.5, 0.4375, 0, 0.4375},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{0, 0, 0, 0, 0, 0},
				}
	},
})

minetest.register_alias("lord_homedecor:coffeetable", "lord_homedecor:coffeetable_back")

minetest.register_craft({
	output = "lord_homedecor:coffeetable",
	recipe = {
		{"", "", "", },
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood", },
		{"group:stick", "", "group:stick", }
	}
})

minetest.register_craft({
	output = "lord_homedecor:coffeetable",
	recipe = {
		{"", "", "", },
		{"stairs:slab_lebethronwood", "stairs:slab_lebethronwood", "stairs:slab_lebethronwood", },
		{"group:stick", "", "group:stick", }
	}
})

if minetest.settings:get("log_mods") then
	minetest.log("action", "coffeetable loaded")
end
