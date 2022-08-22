local S = minetest.get_translator("lord_replacer")

local DEFAULT_SELECTED_NODE = "default:dirt"
local REPLACER_BLACKLIST = {
	"lottores:tilkal",
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
			local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)
			local selected_node = minetest.get_node_or_nil(pointed_pos)
			if selected_node == nil then
				minetest.chat_send_player(player_name,
					S("Error: you have selected unloaded node, please wait a moment."))
				return nil
			end

			set_replacer_selection(itemstack, selected_node)
			minetest.chat_send_player(player_name,
				string.format(S("Node replacer set to: %s"), selected_node.name))
			print("Игрок выбрал:", selected_node.name, selected_node.param1, selected_node.param2)

		else
			local pointed_pos = minetest.get_pointed_thing_position(pointed_thing, true)
			if minetest.is_protected(pointed_pos, player_name) then
				minetest.chat_send_player(player_name, S("Error: this node is protected."))
				return nil
			end

			local selected_node = get_replacer_selection(itemstack)
			if table_has_value(REPLACER_BLACKLIST, selected_node.name) then
				minetest.chat_send_player(player_name, S("Error: this node is in blacklist."))
				return nil
			end

			minetest.set_node(pointed_pos, selected_node)
		end

		return itemstack
	end,
	on_drop = function(itemstack, dropper, pos)
		-- don't drop!
		return itemstack
	end,
	on_use = function(itemstack, placer, pointed_thing)
		local player_name = placer:get_player_name()
		local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)

		if minetest.is_protected(pointed_pos, player_name) then
			minetest.chat_send_player(player_name, S("Error: this node is protected."))
			return nil
		end

		local selected_node = get_replacer_selection(itemstack)
		if table_has_value(REPLACER_BLACKLIST, selected_node.name) then
			minetest.chat_send_player(player_name, S("Error: this node is in blacklist."))
			return nil
		end

		minetest.set_node(pointed_pos, selected_node)
		return nil
	end,
})
