local S = minetest.get_mod_translator()

local drop = require('ancient_miners.drop.config')
local loot_functions = require("loot_functions")


-- title используется как node.description и meta.infotext
local title_ancient_miner = S('Remains')
local title_ancient_miner_mapgen = S('Remains of ancient miner')
local title_remains_skull_bones = S('Remains. Skull and bones')
local title_remains_skull_pick = S('Remains. Skull and pick')

-- лейвый, правый клик выбрасывает лут
local function get_mouse_click_handler(swap_to_node, title, drop_items)
    return function(pos, node, clicker)
        local meta        = minetest.get_meta(pos)
        loot_functions.drop_items_to_world(pos, clicker:get_pos(), drop_items)
        core.swap_node(pos, { name = swap_to_node })
        meta:set_string('infotext', title)
    end
end

-- общие определения регистрируемых нод

local common_definition = {
	node_box = { type = 'fixed', fixed = {
		0.5, -0.5, -0.5, 0.5, -0.1, 0.5,
	}},
	selection_box = { type = 'fixed', fixed = {
		-.5, -0.5, -0.5, 0.5, -0.1, 0.5,
	}},
	visual_scale = 0.95,
	groups       = { oddly_breakable_by_hand = 3, falling_node = 1 },
	drawtype     = 'mesh',
	paramtype    = 'light',
	paramtype2   = 'facedir',
}

-- нода череп и скелет с лутом для mapgen
local ancient_miner_mapgen_1 = {
	description = title_ancient_miner_mapgen,
	mesh         = 'skull_bones.obj',
	tiles        = { 'skull_front.png', 'skull.png', 'edges.png' },
	sounds       = default.node_sound_gravel_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string( 'infotext', title_ancient_miner_mapgen )
	end,
	on_punch      = get_mouse_click_handler('remains:ancient_miner_1', title_remains_skull_bones, drop.skull_bones),
	on_rightclick = get_mouse_click_handler('remains:ancient_miner_1', title_remains_skull_bones, drop.skull_bones),
}

-- нода череп и кирка с лутом для mapgen
local ancient_miner_mapgen_2 = {
	description  = title_ancient_miner_mapgen,
	mesh         = 'skull_pick.obj',
	tiles        = { 'skull_front.png', 'skull.png', 'pick.png' },
	sounds       = default.node_sound_gravel_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', title_ancient_miner_mapgen)
	end,
	on_punch      = get_mouse_click_handler('remains:ancient_miner_2', title_remains_skull_pick, drop.skull_bones),
	on_rightclick = get_mouse_click_handler('remains:ancient_miner_2', title_remains_skull_pick, drop.skull_bones),
}

-- нода добытые останки (для инвентаря)
local ancient_miner = {
	description     = title_ancient_miner,
	inventory_image = 'skull_front_inv.png',
	sounds          = default.node_sound_gravel_defaults(),
	on_construct    = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', title_ancient_miner)
	end,
	on_place        = function(itemstack, placer, pointed_thing)
		local stack = ItemStack('remains:ancient_miner_' .. math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack('remains:ancient_miner ' ..
		itemstack:get_count() - (1 - ret:get_count()))
	end
}

-- нода череп и скелет добытый (без лута)
local ancient_miner_1 = {
	description = title_remains_skull_bones,
	mesh        = 'skull_bones.obj',
	tiles       = {'skull_front.png', 'skull.png','edges.png'},
	sounds      = default.node_sound_gravel_defaults(),
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

-- нода череп и кирка добытый (без лута)
local ancient_miner_2 = {
	description = title_remains_skull_pick,
	mesh        = 'skull_pick.obj',
	tiles       = { 'skull_front.png', 'skull.png','pick.png' },
	sounds      = default.node_sound_gravel_defaults(),
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
