--- @type quest_node.reward_chest.node.Form
local Form = require("reward_chest.node.Form")


local S = minetest.get_mod_translator()

--- HELPERS: -----------------------------------------------------------------------------------------------------------

--- @param meta NodeMetaRef
--- @param player_name string
local function chest_add_visitor(meta, player_name)
	local visitors = minetest.deserialize(meta:get_string("visitors")) or {}
	table.insert(visitors, player_name)
	meta:set_string("visitors", minetest.serialize(visitors))
end

--- @param meta NodeMetaRef
--- @param player_name string
local function chest_has_visitor(meta, player_name)
	local visitors = minetest.deserialize(meta:get_string("visitors")) or {}
	return table.indexof(visitors, player_name) > 0
end

--- @param meta NodeMetaRef
--- @param player_name string
local function congratulate(meta, player_name)
	local congratulations = meta:get_string("congratulations")
	if congratulations == nil or congratulations == "" then
		congratulations = S("Congratulations! You've completed the quest!")
	end

	minetest.chat_send_player(player_name, congratulations)
end

local function is_halloween_season()
	local now = os.date('*t')
	local month, day = now.month, now.day

	return (month == 10 and day >= 24) or (month == 11 and day <= 14)
end

--- NODE DEFINITION: ---------------------------------------------------------------------------------------------------

local definition = {
	description       = S("Reward Chest"),
	tiles             = is_halloween_season()
		and {
			'halloween_reward_chest_top.png',
			'halloween_reward_chest_top.png',
			'halloween_reward_chest_side.png',
			'halloween_reward_chest_side.png',
			'halloween_reward_chest_side.png',
			'halloween_reward_chest_front.png',
		}
		or {
			"default_chest_top.png",
			"default_chest_top.png",
			"default_chest_side.png",
			"default_chest_side.png",
			"default_chest_side.png",
			"default_chest_front.png"
		},
	sounds            = default.node_sound_wood_defaults(),
	sound_open        = "default_chest_open",
	--sound_close = "default_chest_close",
	groups            = {
		choppy                    = 2,
		oddly_breakable_by_hand   = 2,
		not_in_creative_inventory = 1,
	},
	is_ground_content = false,
	paramtype         = "light",
	paramtype2        = "facedir",

	--- @param pos Position
	on_construct      = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Reward Chest"))
		meta:set_string("congratulations", "")
		meta:set_string("visitors", minetest.serialize({}))
		meta:mark_as_private("visitors")
		local inventory = meta:get_inventory()
		inventory:set_size("reward", 8)
	end,
	--- @param itemstack     ItemStack
	--- @param placer        Player
	--- @param pointed_thing pointed_thing
	on_place          = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer, "server") then
			itemstack:clear()
			return itemstack
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	--- @param pos Position
	--- @param player Player
	can_dig           = function(pos, player)
		return player and minetest.check_player_privs(player, "server")
	end,
	--- @param pos Position
	--- @param clicker Player
	on_rightclick     = function(pos, node, clicker)
		if minetest.check_player_privs(clicker, "server") then
			Form:new(clicker, pos):open()
		else
			local meta        = minetest.get_meta(pos)
			local player_name = clicker:get_player_name()
			if chest_has_visitor(meta, player_name) then
				minetest.chat_send_player(player_name, S("The chest is empty! You've already been here!"))
				return
			end

			local inventory = meta:get_inventory()
			local rewards   = inventory:get_list("reward")
			drop_items_to_world(pos, clicker:get_pos(), clicker:get_look_horizontal(), rewards)

			chest_add_visitor(meta, player_name)

			congratulate(meta, player_name)
		end
	end,
}


return {
	definition = definition,
}
