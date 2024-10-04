local S = minetest.get_translator(minetest.get_current_modname())

for node_name, registration in pairs(rocks.get_lord_nodes()) do
	local rock = minetest.registered_nodes[node_name]
	local name = node_name:split(':')[2]
	local base_description = registration.original_description
	local texture = rock.tiles[1]
	minetest.log('info', 'use texture: ' .. texture .. ' at ' .. __FILE_LINE__())

	local brick_name = 'lord_bricks:' .. name .. '_brick'
	minetest.register_node(brick_name, {
		description       = S(base_description .. ' Brick'),
		paramtype2        = 'facedir',
		place_param2      = 0,
		tiles             = { texture .. '^(lord_bricks_overlay_brick.png^[opacity:70)' },
		is_ground_content = false,
		groups            = { cracky = rock.groups.cracky, stone = 1, brick = 1 },
		sounds            = default.node_sound_stone_defaults(),
	})

	local block_name       = 'lord_bricks:' .. name .. '_block'
	minetest.register_node(block_name, {
		description       = S(base_description .. ' Block'),
		tiles             = { texture .. '^(lord_bricks_overlay_block.png^[opacity:70)' },
		is_ground_content = false,
		groups            = { cracky = rock.groups.cracky, stone = 1, brick = 1 },
		sounds            = default.node_sound_stone_defaults(),
	})

	minetest.register_craft({
		type   = 'shaped',
		output = brick_name .. ' 4',
		recipe = {
			{ node_name, node_name, },
			{ node_name, node_name, },
		},
	})

	minetest.register_craft({
		type   = 'shaped',
		output = block_name .. ' 9',
		recipe = {
			{ node_name, node_name, node_name, },
			{ node_name, node_name, node_name, },
			{ node_name, node_name, node_name, },
		},
	})
end
