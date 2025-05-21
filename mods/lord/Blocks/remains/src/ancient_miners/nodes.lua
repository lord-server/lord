local S = minetest.get_mod_translator()

local drop = require('ancient_miners.drop.config')
local loot_functions = require('loot_functions')


-- title используется как node.description и meta.infotext
local title_ancient_miner = S('Remains')
local title_ancient_miner_mapgen = S('Remains of ancient miner')
local title_remains_skull_bones = S('Remains. Skull and bones')
local title_remains_skull_pick = S('Remains. Skull and pick')

-- лейвый, правый клик выбрасывает лут
--- Generates handlers for `on_punch` & `on_rightclick`
--- @param swap_to_node string              technical node name (`"mod:name"`) to replace with when looting.
--- @param title        string              text that will be displayed when point to new(replaced) node.
--- @param drop_items   remains.drop.config list of items to drop to world as loot.
--- @return fun(pos:Position, node:NodeTable, clicker:Player, itemstack:ItemStack|nil):ItemStack|nil
local function get_mouse_click_handler(swap_to_node, title, drop_items)
	return function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		loot_functions.drop_items_to_world(pos, clicker:get_pos(), drop_items)
		minetest.swap_node(pos, { name = swap_to_node, param2 = node.param2 })
		meta:set_string('infotext', title)
		minetest.sound_play( 'drop_loot_of_remains', { gain = 3, pos = pos, max_hear_distance = 10 }, true )

		return itemstack
	end
end

-- общие определения регистрируемых нод

--- @type NodeDefinition
local common_definition = {
	node_box = { type = 'fixed', fixed = {
		-0.5, -0.5, -0.5, 0.5, -0.1, 0.5,
	}},
	selection_box = { type = 'fixed', fixed = {
		-0.5, -0.5, -0.5, 0.5, -0.1, 0.5,
	}},
	visual_scale = 0.95,
	groups       = { oddly_breakable_by_hand = 3, falling_node = 1 },
	drawtype     = 'mesh',
	paramtype    = 'light',
	paramtype2   = 'facedir',
}

--- нода череп и скелет с лутом для mapgen
--- @type NodeDefinition
local ancient_miner_mapgen_1 = {
	description = title_ancient_miner_mapgen,
	mesh         = 'skull_bones.obj',
	tiles        = { 'skull_front.png', 'skull.png', 'edges.png' },
	sounds       = loot_functions.sound_of_drop_loot(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string( 'infotext', title_ancient_miner_mapgen )
	end,
	on_punch      = get_mouse_click_handler('remains:ancient_miner_1', title_remains_skull_bones, drop.skull_bones),
	on_rightclick = get_mouse_click_handler('remains:ancient_miner_1', title_remains_skull_bones, drop.skull_bones),
}

--- нода череп и кирка с лутом для mapgen
--- @type NodeDefinition
local ancient_miner_mapgen_2 = {
	description  = title_ancient_miner_mapgen,
	mesh         = 'skull_pick.obj',
	tiles        = { 'skull_front.png', 'skull.png', 'pick.png' },
	sounds       = loot_functions.sound_of_drop_loot(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', title_ancient_miner_mapgen)
	end,
	on_punch      = get_mouse_click_handler('remains:ancient_miner_2', title_remains_skull_pick, drop.skull_pick),
	on_rightclick = get_mouse_click_handler('remains:ancient_miner_2', title_remains_skull_pick, drop.skull_pick),
}

--- нода добытые останки (для инвентаря)
--- @type NodeDefinition
local ancient_miner = {
	description     = title_ancient_miner,
	inventory_image = 'skull_front_inv.png',
	sounds      = loot_functions.sound_of_dig_remains(),
	on_construct    = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', title_ancient_miner)
	end,
	on_place        = function(itemstack, placer, pointed_thing)
		local stack = ItemStack('remains:ancient_miner_' .. math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		--ret:
		if ret == nil then
			return itemstack
		else
			return ItemStack('remains:ancient_miner ' .. (itemstack:get_count() - (1 - ret:get_count())))
		end
	end
}


--- нода череп и скелет добытый (без лута)
--- @type NodeDefinition
local ancient_miner_1 = {
	description = title_remains_skull_bones,
	mesh        = 'skull_bones.obj',
	tiles       = {'skull_front.png', 'skull.png','edges.png'},
	sounds      = loot_functions.sound_of_dig_remains(),
	drop = {
		max_items = 1,
		items = {
			{items = {'remains:ancient_miner'}}
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', title_remains_skull_bones)
	end
}

--- нода череп и кирка добытый (без лута)
--- @type NodeDefinition
local ancient_miner_2 = {
	description = title_remains_skull_pick,
	mesh        = 'skull_pick.obj',
	tiles       = { 'skull_front.png', 'skull.png','pick.png' },
	sounds      = loot_functions.sound_of_dig_remains(),
	drop = {
		max_items = 1,
		items = {
			{ items = { 'remains:ancient_miner' }}
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', title_remains_skull_pick)
	end
}


return {
	common_definition = common_definition,
	ancient_miner_mapgen_1 = ancient_miner_mapgen_1,
	ancient_miner_mapgen_2 = ancient_miner_mapgen_2,
	ancient_miner = ancient_miner,
	ancient_miner_1 = ancient_miner_1,
	ancient_miner_2 = ancient_miner_2
}
