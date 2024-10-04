local S = minetest.get_translator(minetest.get_current_modname())


-- TODO: deduplicate `mordor_stone_{brick|block}` & stairs|slab
-- now them duplicates in `lottblocks`


for node_name, registration in pairs(rocks.get_lord_nodes()) do
	local rock = minetest.registered_nodes[node_name]
	local name = node_name:split(':')[2]
	local base_description = registration.original_description
	local texture = rock.tiles[1]
	minetest.log('info', 'use texture: ' .. texture .. ' at ' .. __FILE_LINE__())

	local brick_name = 'lord_bricks:' .. name .. '_brick'
	local brick_tile = texture .. '^(lord_bricks_overlay_brick.png^[opacity:70)'
	minetest.register_node(brick_name, {
		description       = S(base_description .. ' Brick'),
		paramtype2        = 'facedir',
		place_param2      = 0,
		tiles             = { brick_tile },
		is_ground_content = false,
		groups            = { cracky = rock.groups.cracky, stone = 1, brick = 1 },
		sounds            = default.node_sound_stone_defaults(),
	})

	local block_name = 'lord_bricks:' .. name .. '_block'
	local block_tile = texture .. '^(lord_bricks_overlay_block.png^[opacity:70)'
	minetest.register_node(block_name, {
		description       = S(base_description .. ' Block'),
		tiles             = { block_tile },
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

	stairs.register_stair_and_slab(
		brick_name:split(':')[2],
		brick_name,
		{ cracky = rock.groups.cracky, stone = 1 },
		{ brick_tile },
		S(base_description .. ' Brick Stair'),
		S(base_description .. ' Brick Slab'),
		default.node_sound_stone_defaults(),
		false,
		S('Inner' .. base_description .. ' Brick Stair'),
		S('Outer' .. base_description .. ' Brick Stair')
	)

	stairs.register_stair_and_slab(
		block_name:split(':')[2],
		block_name,
		{ cracky = rock.groups.cracky, stone = 1 },
		{ block_tile },
		S(base_description .. ' Block Stair'),
		S(base_description .. ' Block Slab'),
		default.node_sound_stone_defaults(),
		false,
		S('Inner' .. base_description .. ' Block Stair'),
		S('Outer' .. base_description .. ' Block Stair')
	)
end
