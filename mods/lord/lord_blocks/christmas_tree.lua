-- Christmas tree
local S = minetest.get_translator("lord_blocks")

local gifts = string.split(minetest.settings:get("lord_christmas_gifts"))

local nodebox = {
	type = "fixed",
	fixed = {
		{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
	},
}

local function get_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]"..
		"list[nodemeta:" .. spos .. ";main;1.5,1.3;5,2;]"..
		"list[current_player;main;0,4.85;8,1;]"..
		"list[current_player;main;0,6.08;8,3;8]"..
		"listring[nodemeta:" .. spos .. ";main]"..
		"listring[current_player;main]"..
		"background[0,0;0.1,0.1;lord_blocks_christmas_tree_background.png;true]"..
		"listcolors[#69696988;#80808088;#222222]"
	return formspec
end

local function register_christmas_tree(def)
	minetest.register_node("lord_blocks:christmas_tree", {
		description = def.description,
		drawtype = "mesh",
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		use_texture_alpha = "clip",
		mesh = def.mesh,
		tiles = def.tiles,
		paramtype = "light",
		--light_source = 1,
		paramtype2 = "facedir",
		selection_box = nodebox,
		collision_box = nodebox,
		groups = def.groups,
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos, node, active_object_count, active_object_count_wider)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("main", 10)
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
			minetest.show_formspec(player, "lord_blocks:christmas_tree", get_formspec(pos))
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv  = meta:get_inventory()
			return inv:is_empty("main")
		end,
	})

	minetest.register_node("lord_blocks:christmas_tree_with_gifts", {
		description = def.description,
		drawtype = "mesh",
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		use_texture_alpha = "clip",
		mesh = def.mesh,
		tiles = def.tiles,
		paramtype = "light",
		--light_source = 1,
		paramtype2 = "facedir",
		selection_box = nodebox,
		collision_box = nodebox,
		groups = def.groups,
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos, node, active_object_count, active_object_count_wider)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("main", 10)
			local count = #gifts
			if count > 10 then
				count = 10
			end
			for i=1, count do
				inv:set_stack("main", i, gifts[i])
			end
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
			minetest.show_formspec(player, "lord_blocks:christmas_tree", get_formspec(pos))
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv  = meta:get_inventory()
			return inv:is_empty("main")
		end,
	})
end

register_christmas_tree({
	description = S("Christmas Tree"),
	mesh = "christmas_tree.obj",
	tiles = {"lord_blocks_christmas_tree.png"},
	inventory_image = "lord_blocks_christmas_tree_item.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
})

minetest.register_craftitem("lord_blocks:christmas_decorations", {
	description = S("Christmas Decorations"),
	inventory_image = "lord_blocks_christmas_decorations.png",
})

minetest.register_craftitem("lord_blocks:christmas_tree_no_decorations", {
	description = S("Fir Tree"),
	inventory_image = "lord_blocks_christmas_tree_no_decorations_item.png",
})

minetest.register_craft({
	output = "lord_blocks:christmas_tree",
	recipe = {
		{"lord_blocks:christmas_decorations",
			"lord_blocks:christmas_decorations",
			"lord_blocks:christmas_decorations"},
		{"lord_blocks:christmas_decorations",
			"lord_blocks:christmas_tree_no_decorations",
			"lord_blocks:christmas_decorations"},
		{"lord_blocks:christmas_decorations",
			"lord_blocks:christmas_decorations",
			"lord_blocks:christmas_decorations"},}
})
