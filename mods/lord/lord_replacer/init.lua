local S = minetest.get_translator("lord_replacer")

local DEFAULT_SELECTED_NODE = "default:dirt"
local REPLACER_BLACKLIST = {
	"lottores:tilkal",
	"stairs:slab_tilkal",
	"stairs:stair_tilkal",
	"stairs:stair_inner_tilkal",
	"stairs:stair_outer_tilkal",
	"lottblocks:palantir",
}


local function table_has_value(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

local function set_replacer_selection(itemstack, selected_node)
	local itemstack_meta = itemstack:get_meta()
	itemstack_meta:set_string("selected_node", selected_node.name)
	itemstack_meta:set_int("selected_param1", selected_node.param1)
	itemstack_meta:set_int("selected_param2", selected_node.param2)
	return itemstack
end

local function replacer_get_node(itemstack, pointed_thing, player_name)
	local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)
	local selected_node = minetest.get_node_or_nil(pointed_pos)
	if selected_node == nil then
		minetest.chat_send_player(player_name,
			S("Error: you have selected an unloaded node, please wait for server."))
		return nil
	end

	set_replacer_selection(itemstack, selected_node)
	minetest.chat_send_player(player_name,
		string.format(S("Node replacer set to: %s"), selected_node.name))

	return itemstack
end

local function get_replacer_selection(itemstack)
	local itemstack_meta = itemstack:get_meta()
	local selected_node = {
		name = itemstack_meta:get_string("selected_node"),
		param1 = itemstack_meta:get_int("selected_param1"),
		param2 = itemstack_meta:get_int("selected_param2"),
	}
	if selected_node.name == "" then
		selected_node.name = DEFAULT_SELECTED_NODE
		selected_node.param1 = 0
		selected_node.param2 = 0
	end
	return selected_node
end

local function replacer_set_node(itemstack, pointed_thing, player_name, place_above)
	local pointed_pos = minetest.get_pointed_thing_position(pointed_thing, place_above)
	if pointed_pos == nil then
		return false
	end

	local pointed_inventory = minetest.get_inventory({ type = "node", pos = pointed_pos, })
	if pointed_inventory then
		for listname, _ in pairs(pointed_inventory:get_lists()) do
			if not pointed_inventory:is_empty(listname) then
				minetest.chat_send_player(player_name, S("Error: non-empty node inventory found. Unload it first."))
				return false
			end
		end
	end

	if minetest.is_protected(pointed_pos, player_name) then
		minetest.chat_send_player(player_name, S("Error: this node is protected."))
		return false
	end

	local selected_node = get_replacer_selection(itemstack)
	if table_has_value(REPLACER_BLACKLIST, selected_node.name) then
		minetest.chat_send_player(player_name, S("Error: this node is in blacklist."))
		return false
	end

	minetest.set_node(pointed_pos, selected_node)
	return true
end


minetest.register_tool("lord_replacer:replacer", {
	description = S("Node Replacer"),
	groups = {},
	inventory_image = "lord_replacer_replacer.png",
	wield_image = "",
	on_place = function(itemstack, placer, pointed_thing)
		if placer == nil or pointed_thing == nil or pointed_thing.type ~= "node" then
			return nil
		end

		local player_name = placer:get_player_name()

		local keys = placer:get_player_control()
		if keys.aux1 or keys.sneak then
			itemstack = replacer_get_node(itemstack, pointed_thing, player_name)
		else
			replacer_set_node(itemstack, pointed_thing, player_name, true)
		end

		return itemstack
	end,
	on_drop = function(itemstack, dropper, pos)
		-- don't drop!
		return itemstack
	end,
	on_use = function(itemstack, placer, pointed_thing)
		replacer_set_node(itemstack, pointed_thing, placer:get_player_name(), false)
		return nil
	end,
})
