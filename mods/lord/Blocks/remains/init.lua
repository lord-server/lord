minetest.mod(function(mod)
	local S = minetest.get_mod_translator()

	local drop_loot = require('drop_loot')

	local title_ancient_miner = S('Remains')
	local title_ancient_miner_mapgen = S('Remains of ancient miner')
	local title_remains_scull_bones = S('Remains. Scull and bones')
	local title_remains_scull_pick = S('Remains. Scull and pick')

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

	minetest.register_node('remains:ancient_miner_mapgen_1', table.merge(common_definition, {
		description = title_ancient_miner_mapgen,
		drop = {
			max_items = 5,
			items = drop_loot
		},
		mesh         = 'scull_bones.obj',
		tiles        = { 'scull_front.png', 'scull.png', 'edges.png' },
		sounds       = default.node_sound_gravel_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
            meta:set_string( 'infotext', title_ancient_miner_mapgen )
		end
	}))

	minetest.register_node('remains:ancient_miner_mapgen_2', table.merge(common_definition, {
		description  = title_ancient_miner_mapgen,
		drop = {
			max_items = 5,
			items = drop_loot
		},
		mesh         = 'scull_pick.obj',
		tiles        = { 'scull_front.png', 'scull.png', 'pick.png' },
		sounds       = default.node_sound_gravel_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
            meta:set_string('infotext', title_ancient_miner_mapgen)
		end
	}))

	minetest.register_node('remains:ancient_miner', table.merge(common_definition, {
		description     = title_ancient_miner,
		inventory_image = 'scull_front_inv.png',
		sounds          = default.node_sound_gravel_defaults(),
		on_construct    = function(pos)
			local meta = minetest.get_meta(pos)
            meta:set_string('infotext', title_ancient_miner)
		end,
		on_place         = function(itemstack, placer, pointed_thing)
                -- place a random grass node
                local stack = ItemStack('remains:ancient_miner_' .. math.random(1,2))
                local ret = minetest.item_place(stack, placer, pointed_thing)
                return ItemStack('remains:ancient_miner ' ..
                        itemstack:get_count() - (1 - ret:get_count()))
        end
	}))

	minetest.register_node('remains:ancient_miner_1', table.merge(common_definition, {
		description = title_remains_scull_bones,
		mesh        = 'scull_bones.obj',
		tiles       = {'scull_front.png', 'scull.png','edges.png'},
		sounds      = default.node_sound_gravel_defaults(),
		drop = {
			max_items = 1,
			items = {
				{items = {'remains:ancient_miner'}}
			}
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
            meta:set_string('infotext', title_remains_scull_bones)
		end
	}))

	minetest.register_node('remains:ancient_miner_2', table.merge(common_definition, {
		description = title_remains_scull_pick,
		mesh        = 'scull_pick.obj',
		tiles       = { 'scull_front.png', 'scull.png','pick.png' },
		sounds      = default.node_sound_gravel_defaults(),
		drop = {
			max_items = 1,
			items = {
				{ items = { 'remains:ancient_miner' }}
			}
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
            meta:set_string('infotext', title_remains_scull_pick)
		end
	}))
end)
