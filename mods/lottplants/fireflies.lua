local SL = lord.require_intllib()

minetest.register_node("lottplants:fireflies", {
	description = SL("Fireflies"),
	drawtype = "glasslike",
	tiles = {
		{
			name = "lottplants_fireflies.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	alpha = 100,
	paramtype = "light",
	light_source = 8,
	walkable = false,
  groups = {catchable = 1},
	pointable = true,
	diggable = true,
	climbable = false,
	buildable_to = true,
	drop = "",
})

minetest.register_abm({
	nodenames = {"air"},
	neighbors = {
		"lottplants_elanor",
		"lottplants:niphredil",
	},
	interval = 15,
	chance = 600,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.74 or minetest.get_timeofday() < 0.22 then
			--local water_nodes = minetest.find_nodes_in_area(minp, maxp, "group:water")
			--if #water_nodes > 0 then
			if minetest.find_node_near(pos, 3, "lottplants:fireflies") == nil then
				minetest.set_node(pos, {name = "lottplants:fireflies"})
			end
		end
	end,
})

minetest.register_tool("lottplants:bug_net", {
	description = SL("Bug Net"),
	inventory_image = "fireflies_bugnet.png",
	on_use = function(itemstack, player, pointed_thing)
		if not pointed_thing or pointed_thing.type ~= "node" or
				minetest.is_protected(pointed_thing.under, player:get_player_name()) then
			return
		end
		local node_name = minetest.get_node(pointed_thing.under).name
		local inv = player:get_inventory()
		if minetest.get_item_group(node_name, "catchable") == 1 then
			minetest.set_node(pointed_thing.under, {name = "air"})
			local stack = ItemStack(node_name.." 1")
			local leftover = inv:add_item("main", stack)
			if leftover:get_count() > 0 then
				minetest.add_item(pointed_thing.under, node_name.." 1")
			end
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:add_wear(256)
			return itemstack
		end
	end
})

minetest.register_craft( {
	output = "lottplants:bug_net",
	recipe = {
		{"farming:string", "farming:string"},
		{"farming:string", "farming:string"},
		{"group:stick", ""}
	}
})

minetest.register_craft( {
	output = "lottplants:bug_net",
	recipe = {
		{"farming:string", "farming:string"},
		{"farming:string", "farming:string"},
		{"", "group:stick"}
	}
})
