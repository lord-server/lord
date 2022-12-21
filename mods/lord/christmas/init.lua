local os_date = os.date

--- @type fun(str: string, ...)
local S = minetest.get_translator("christmas")

local mod_path = minetest.get_modpath(minetest.get_current_modname())

local gifts, christmas_date = dofile(mod_path .. "/configure.lua")

--- @return boolean
christmas_date.has_come = function()
	local now = os_date("*t")
	return
		now.month >= christmas_date.month and
		now.day >= christmas_date.day and
		now.hour >= christmas_date.hour and
		now.min >= christmas_date.min
end


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
		"background[0,0;0.1,0.1;christmas_tree_formspec_background.png;true]"..
		"listcolors[#69696988;#80808088;#222222]"
	return formspec
end

local function register_christmas_tree(def)
	minetest.register_node("christmas:tree", {
		description = def.description,
		drawtype = "mesh",
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		use_texture_alpha = "clip",
		mesh = def.mesh,
		tiles = def.tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = nodebox,
		collision_box = nodebox,
		groups = def.groups,
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos, node, active_object_count, active_object_count_wider)
			if christmas_date.has_come() then
				local tree_node = minetest.get_node(pos)
				tree_node.name = "christmas:tree_with_gifts"
				minetest.swap_node(pos, tree_node)
			end
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("main", 10)
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
			minetest.show_formspec(player, "christmas:tree", get_formspec(pos))
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv  = meta:get_inventory()
			return inv:is_empty("main")
		end,
	})

	minetest.register_node("christmas:tree_with_gifts", {
		description = def.description,
		drawtype = "mesh",
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		use_texture_alpha = "clip",
		mesh = def.mesh,
		tiles = def.tiles,
		paramtype = "light",
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
			minetest.show_formspec(player, "christmas:tree", get_formspec(pos))
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv  = meta:get_inventory()
			return inv:is_empty("main")
		end,
	})

	local function gen_gifts(pos)
		local node = minetest.get_node(pos)
		node.name = "christmas:tree_with_gifts"
		minetest.swap_node(pos, node)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local count = #gifts
		if count > 10 then
			count = 10
		end
		for i=1, count do
			inv:set_stack("main", i, gifts[i])
		end
	end

	minetest.register_abm({
		label = "Generations gifts in christmas tree",
		nodenames = {"christmas:tree"},
		interval = 10,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if christmas_date.has_come() then
				gen_gifts(pos)
			end
		end,
	})
end

register_christmas_tree({
	description = S("Christmas Tree"),
	mesh = "christmas_tree.obj",
	tiles = {"christmas_tree.png"},
	inventory_image = "christmas_tree_item.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
})

minetest.register_craftitem("christmas:decorations", {
	description = S("Christmas Decorations"),
	inventory_image = "christmas_decorations.png",
})

minetest.register_craftitem("christmas:tree_no_decorations", {
	description = S("Fir Tree"),
	inventory_image = "christmas_tree_no_decorations.png",
})

local item_deco = "christmas:decorations"

minetest.register_craft({
	output = "christmas:tree",
	recipe = {
		{item_deco, "default:goldblock", item_deco},
		{item_deco, "christmas:tree_no_decorations", item_deco},
		{item_deco, item_deco, item_deco},}
})

local item_glass = "default:glass"

minetest.register_craft({
	output = "christmas:decorations",
	recipe = {
		{item_glass, "dye:red", item_glass},
		{"dye:blue", item_glass, "dye:green"},}
})

minetest.register_craft({
	output = "christmas:tree_no_decorations",
	recipe = {
		{"lottplants:firsapling"},
		{"lord_homedecor:flower_pot_terracotta"},}
})
