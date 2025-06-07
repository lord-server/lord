local Form         = require('holding_points.Form')
local HoldingPoint = require('holding_points.HoldingPoint')

local S = minetest.get_mod_translator()


--- @type NodeDefinition
local definition = {
	description       = S('Holding Point'),

	tiles             = { 'holding_points_node.png' },
	use_texture_alpha = 'blend',

	--- @param pos Position
	on_construct      = function(pos)
		HoldingPoint:new(pos):init_node()
	end,

	--- @param pos Position
	on_destruct = function(pos)
		HoldingPoint:new(pos).processor
			:stop()
			:remove()
	end,

	--- @param placer        Player
	--- @param itemstack     ItemStack
	--- @param pointed_thing pointed_thing
	on_place          = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer, 'server') then
			minetest.chat_send_player(placer:get_player_name(), S('It\'s for admins only! How did you get this thing?!'))

			return itemstack, nil
		end

		return minetest.item_place(itemstack, placer, pointed_thing)
	end,

	--- @param pos    Position
	--- @param placer Player
	after_place_node  = function(pos, placer)
		if not minetest.check_player_privs(placer, 'server') then
			minetest.chat_send_player(placer:get_player_name(), S('It\'s for admins only! How did you get this thing?!'))

			return nil
		end

		Form:new(placer, pos):open()
	end,

	--- @param pos           Position
	--- @param player        Player
	--- @param pointed_thing pointed_thing
	--- @param node          NodeTable
	on_punch          = function(pos, node, player, pointed_thing)
		if not player or not minetest.is_player(player) then
			return
		end

		HoldingPoint:new(pos):punch(player)
	end,

	--- @param pos           Position
	--- @param node          NodeTable
	--- @param clicker       Player
	--- @param itemstack     ItemStack
	--- @param pointed_thing pointed_thing
	on_rightclick     = function(pos, node, clicker, itemstack, pointed_thing)
		if not clicker or not minetest.is_player(clicker) then
			return
		end
		if not minetest.check_player_privs(clicker, 'server') then
			return
		end

		Form:new(clicker, pos):open()
	end
}


return {
	definition = definition
}
