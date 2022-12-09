-- Christmas tree
S = minetest.get_translator("lord_blocks")

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

minetest.register_node("lord_blocks:christmas_tree", {
	description = S("Christmas Tree"),
	drawtype = "mesh",
	use_texture_alpha = "clip",
	mesh = "christmas_tree.obj",
	tiles = {"lord_blocks_christmas_tree.png"},
	paramtype = "light",
	light_source = 1,
	paramtype2 = "facedir",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	is_ground_content = false,
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
