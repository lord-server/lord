local S = minetest.get_mod_translator()


local function register_dwarven()
	minetest.register_node('lord_ropes:dwarven_ropes', {
		description         = S('Dwarven ropes'),
		drawtype            = 'nodebox',
		sunlight_propagates = true,
		tiles               = {
			'lord_ropes_rope_top.png',
			'lord_ropes_rope_top.png',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:0,0',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:0,0',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:1,0',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:1,0',
		},
		use_texture_alpha   = 'clip',
		groups              = {
			choppy = 3,
			snappy = 3,
			oddly_breakable_by_hand = 3,
			flammable = 1
		},
		paramtype           = 'light',
		climbable           = true,
		walkable            = false,
		node_box            = {
			type  = 'fixed',
			fixed = {
				{ -1/16, -8/16, -1/16, 1/16, 8/16, 1/16 },
			},
		},
		selection_box       = {
			type  = 'fixed',
			fixed = {
				{ -1/16, -8/16, -1/16, 1/16, 8/16, 1/16 },
			},
		},
		sounds = default.node_sound_defaults(),
	})

	minetest.register_craft({
		output              = 'lord_ropes:dwarven_ropes',
		recipe              = {
			{ 'farming:string' },
			{ 'farming:string' },
			{ 'farming:string' },
		}
	})

	minetest.register_node('lord_ropes:dwarven_rope_hanging', {
		paramtype           = 'light',
		sunlight_propagates = true,
		tiles               = {
			'[fill:1x1:0,0:#00000000',
			'[fill:1x1:0,0:#00000000',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:0,0',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:0,0',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:1,0',
			'lord_ropes_dwarven_ropes.png^[sheet:2x1:1,0',
		},
		use_texture_alpha   = 'clip',
		groups              = { not_in_creative_inventory = 1 },
		climbable           = true,
		walkable            = false,
		diggable            = false,
		drawtype            = 'nodebox',
		node_box            = {
			type  = 'connected',
			fixed = { -1/16, -1/2, -1/16, 1/16, 1/2, 1/16 },
			connect_top = { -1/16, 1/2, -1/16, 1/16, 3/4, 1/16 }
		},
		connects_to         = { 'group:rope_block' },
		connect_sides       = { 'top' },
		selection_box       = {
			type  = 'fixed',
			fixed = { -1/16, -1/2, -1/16, 1/16, 1/2, 1/16 },
		},
		sounds              = default.node_sound_wood_defaults(),
		after_destruct = function(pos, oldnode)
			local node = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })
			if node.name == 'lord_ropes:dwarven_rope_hanging' then
				minetest.remove_node({ x = pos.x, y = pos.y - 1, z = pos.z })
			end
		end,
	})

	minetest.register_node('lord_ropes:dwarven_ropebox', {
		description         = S('Dwarven ropebox'),
		drawtype            = 'mesh',
		mesh                = 'lord_ropes_dwarven_rope_block.obj',
		tiles               = { 'dwarven_rope.png' },
		selection_box       = {
			type  = 'fixed',
			fixed = {
				{ -3/16, -1/2, -1/8, -1/8, 1/8, 1/8 },
				{ -1/8, -1/4, -1/4, 1/8, 1/4, 1/4 },
				{ 1/8, -1/2, -1/8, 3/16, 1/8, 1/8 },
			},
		},
		sunlight_propagates = true,
		use_texture_alpha   = 'clip',
		paramtype           = 'light',
		paramtype2          = 'wallmounted',
		groups              = { oddly_breakable_by_hand = 2, cracky = 3, rope_block = 1 },
		sounds              = default.node_sound_wood_defaults(),
		after_destruct = function(pos, oldnode)
			local node = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })
			if node.name == 'lord_ropes:dwarven_rope_hanging' then
				minetest.remove_node({ x = pos.x, y = pos.y - 1, z = pos.z })
			end
		end,
	})

	minetest.register_abm({
		nodenames           = { 'lord_ropes:dwarven_ropebox' },
		interval            = 1,
		chance              = 1,
		action = function(pos, node)
			if minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z }).name ~= 'air' then return end
			minetest.add_node({ x = pos.x, y = pos.y - 1, z = pos.z }, { name = 'lord_ropes:dwarven_rope_hanging' })
		end
	})

	minetest.register_abm({
		nodenames = { 'lord_ropes:dwarven_rope_hanging' },
		interval = 1,
		chance = 1,
		action = function(pos, node)
			if minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z }).name ~= 'air' then return end
			minetest.add_node({ x = pos.x, y = pos.y - 1, z = pos.z }, { name = 'lord_ropes:dwarven_rope_hanging' })
		end
	})

	minetest.register_craft({
		output = 'lord_ropes:dwarven_ropebox',
		recipe = {
			{ 'default:steel_ingot', 'carts:gear',              'default:steel_ingot' },
			{ '',                    'lord_ropes:dwarven_ropes',                   '' },
			{ '',                    'lord_ropes:dwarven_ropes',                   '' },
		}
	})
end


return {
	register = register_dwarven,
}
