
--- @type fun(str: string, ...)
local S = minetest.get_translator("christmas")


--- @param pos Position
--- @return string
local function get_formspec(pos)
	local pos_str = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]"..
		"list[nodemeta:" .. pos_str .. ";main;1.5,1.3;5,2;]"..
		"list[current_player;main;0,4.85;8,1;]"..
		"list[current_player;main;0,6.08;8,3;8]"..
		"listring[nodemeta:" .. pos_str .. ";main]"..
		"listring[current_player;main]"..
		"background[0,0;0.1,0.1;christmas_tree_formspec_background.png;true]"..
		"listcolors[#69696988;#80808088;#222222]"

	return formspec
end

--- @param pos Position
--- @param gifts table<number, table>
local function gen_gifts(pos, gifts)
	local node = minetest.get_node(pos)
	node.name = "christmas:tree_with_gifts"
	minetest.swap_node(pos, node)

	local meta  = minetest.get_meta(pos)
	local inv   = meta:get_inventory()
	local count = #gifts > 10 and 10 or #gifts

	for i = 1, count do
		inv:set_stack("main", i, gifts[i])
	end
end

--- @param christmas_date Christmas
local function register_tree_nodes(christmas_date)
	local nodebox = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
		},
	}
	local inventory_image = "christmas_tree_item.png"

	local common_definition = {
		description       = S("Christmas Tree"),
		drawtype          = "mesh",
		inventory_image   = inventory_image,
		wield_image       = inventory_image,
		use_texture_alpha = "clip",
		mesh              = "christmas_tree.obj",
		tiles             = {"christmas_tree.png"},
		paramtype         = "light",
		paramtype2        = "facedir",
		selection_box     = nodebox,
		collision_box     = nodebox,
		groups            = {choppy = 2, oddly_breakable_by_hand = 2, wooden = 1},
		sounds            = default.node_sound_wood_defaults(),
		--- @param pos Position
		--- @param clicker Player
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
			minetest.show_formspec(player, "christmas:tree", get_formspec(pos))
		end,
		--- @param pos Position
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv  = meta:get_inventory()
			return inv:is_empty("main")
		end,
	}

	local tree_def         = table.copy(common_definition)
	local tree_w_gifts_def = table.copy(common_definition)

	--- @param pos Position
	tree_def.on_construct = function(pos, node, active_object_count, active_object_count_wider)
		if christmas_date.has_come() then
			local tree_node = minetest.get_node(pos)
			tree_node.name  = "christmas:tree_with_gifts"
			minetest.swap_node(pos, tree_node)
		end
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("main", 10)
	end
	--- @param pos Position
	tree_w_gifts_def.on_construct = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("main", 10)
	end

	minetest.register_node("christmas:tree", tree_def)
	minetest.register_node("christmas:tree_with_gifts", tree_w_gifts_def)
end

--- @param christmas_date Christmas
--- @param gifts table<number, table>
local function register_tree_nodes_replacement_abm(christmas_date, gifts)
	minetest.register_abm({
		label = "Generations gifts in christmas tree",
		nodenames = {"christmas:tree"},
		interval = 10,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if christmas_date.has_come() then
				gen_gifts(pos, gifts)
			end
		end,
	})
end



return {
	register                 = register_tree_nodes,
	register_replacement_abm = register_tree_nodes_replacement_abm,
}
