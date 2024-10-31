local table_has_value
	= table.has_value

local S = minetest.get_mod_translator()

local DEFAULT_SELECTED_NODE = "default:dirt"
local REPLACER_PLACE_BLACKLIST = {
	"lottores:tilkal",
	"lottblocks:palantir",
}
local REPLACER_IRREPLACEABLE = {
	"lottores:tilkal",
	"stairs:slab_tilkal",
	"stairs:stair_tilkal",
	"stairs:stair_inner_tilkal",
	"stairs:stair_outer_tilkal",
	"lottblocks:palantir",
}


--- Sets replacer's selection using its metadata.
---@param itemstack ItemStack
---@param selected_node NodeTable @`minetest.get_node` format
---@return ItemStack
local function set_replacer_selection(itemstack, selected_node)
	local itemstack_meta = itemstack:get_meta()
	itemstack_meta:set_string("selected_node", selected_node.name)
	itemstack_meta:set_int("selected_param1", selected_node.param1)
	itemstack_meta:set_int("selected_param2", selected_node.param2)
	return itemstack
end

--- Gets node to replacer.
---@param itemstack ItemStack
---@param pointed_thing pointed_thing
---@param player_name string
---@return ItemStack
local function replacer_get_node(itemstack, pointed_thing, player_name)
	local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)
	local selected_node = minetest.get_node_or_nil(pointed_pos)
	if selected_node == nil then
		minetest.chat_send_player(player_name,
			S("Error: you have selected an unloaded node, please wait for server."))
		return nil
	end

	if table_has_value(REPLACER_PLACE_BLACKLIST, selected_node.name) then
		minetest.chat_send_player(player_name, S("Error: this node is in blacklist."))
		return nil
	end

	set_replacer_selection(itemstack, selected_node)
	minetest.chat_send_player(player_name,
		string.format(S("Node replacer set to: %s"), selected_node.name))

	return itemstack
end

--- Gets replacer's selection from its metadata.
---@param itemstack ItemStack
---@return NodeTable @`minetest.get_node` format
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

--- Sets node from replacer.
---@param itemstack ItemStack
---@param pointed_thing pointed_thing
---@param player Player
---@param place_above boolean @is `above` param in `minetest.get_pointed_thing_position`
---@return boolean @result of putting the node
local function replacer_set_node(itemstack, pointed_thing, player, place_above)
	if pointed_thing.type ~= "node" then
		return false
	end

	local pointed_pos = minetest.get_pointed_thing_position(pointed_thing, place_above)
	if pointed_pos == nil then
		return false
	end

	local player_name = player:get_player_name()
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

	if table_has_value(REPLACER_IRREPLACEABLE, minetest.get_node(pointed_pos).name) then
		minetest.chat_send_player(player_name, S("Error: this node is irreplaceable."))
		return false
	end

	if not minetest.check_player_privs(player, "server") and not minetest.is_creative_enabled(player_name) then
		local player_inv = player:get_inventory()

		if not player_inv:contains_item("main", selected_node.name) then
			minetest.chat_send_player(player_name, S("Error: not enough materials."))
			return false
		end
		player_inv:remove_item("main", selected_node.name)

		local node_being_replaced = minetest.get_node_or_nil(pointed_pos)
		if node_being_replaced ~= nil and node_being_replaced.name ~= "air" then
			minetest.give_or_drop(player, ItemStack(node_being_replaced.name))
		end
	end

	minetest.set_node(pointed_pos, selected_node)

	return true
end


-- Нодозаменитель
-- Удобный инструмент для быстрого строительства, сохраняющий в своеобразный буфер не только название ноды, но и её
-- param1 и param2. Расходует материалы и выдаёт заменяемую ноду при отсутствии привилегии server или creative.
-- При клике правой кнопкой мыши ставит ноду из буфера (по умолчанию default:dirt).
-- При клике правой кнопкой с зажатой клавишой Shift или Aux1 (use) сохраняет выделенную ноду в буфер.
-- При клике левой кнопкой мыши заменяет выделенную ноду на ноду из буфера.
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
			replacer_set_node(itemstack, pointed_thing, placer, true)
		end

		return itemstack
	end,
	on_drop = function(itemstack, dropper, pos)
		-- don't drop!
		return itemstack
	end,
	on_use = function(itemstack, placer, pointed_thing)
		replacer_set_node(itemstack, pointed_thing, placer, false)
		return nil
	end,
})
