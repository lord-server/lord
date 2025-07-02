
local S = minetest.get_mod_translator()

minetest.register_node('lord_gems:blue_block', {
	description     = S('Blue Gem Block'),
	inventory_image = 'lord_gems_blue_block.png',
	tiles           = { 'lord_gems_blue_block.png' },
	sounds          = {
		footstep = { name = 'footstep_blue_block',        gain = 0.25 },
		dug      = { name = 'footstep_blue_block',        gain = 0.25 },
		place    = { name = 'footstep_blue_block',        gain = 0.25 },
	},
	groups = {cracky = 3, stone = 1},
})

minetest.register_node('lord_gems:red_block', {
	description     = S('Red Gem Block'),
	inventory_image = 'lord_gems_red_block.png',
	tiles           = { 'lord_gems_red_block.png' },
	sounds          = {
		footstep = { name = 'footstep_red_block',        gain = 0.25 },
		dug      = { name = 'footstep_red_block',        gain = 0.25 },
		place    = { name = 'footstep_red_block',        gain = 0.25 },
	},
	groups = {cracky = 3, stone = 1},
})

minetest.register_node('lord_gems:white_block', {
	description     = S('White Gem Block'),
	inventory_image = 'lord_gems_white_block.png',
	tiles           = { 'lord_gems_white_block.png' },
	sounds          = {
		footstep = { name = 'footstep_white_block',        gain = 0.25 },
		dug      = { name = 'footstep_white_block',        gain = 0.25 },
		place    = { name = 'footstep_white_block',        gain = 0.25 },
	},
	groups = {cracky = 3, stone = 1},
})

minetest.register_node('lord_gems:purple_block', {
	description     = S('Purple Gem Block'),
	inventory_image = 'lord_gems_purple_block.png',
	tiles           = { 'lord_gems_purple_block.png' },
	sounds          = {
		footstep = { name = 'footstep_purple_block',        gain = 0.25 },
		dug      = { name = 'footstep_purple_block',        gain = 0.25 },
		place    = { name = 'footstep_purple_block',        gain = 0.25 },
	},
	groups = {cracky = 3, stone = 1},
})


minetest.register_craft({
	output = 'lord_gems:blue_block',
	recipe = {
		{'lord_gems:blue', 'lord_gems:blue', 'lord_gems:blue'},
		{'lord_gems:blue', 'lord_gems:blue', 'lord_gems:blue'},
		{'lord_gems:blue', 'lord_gems:blue', 'lord_gems:blue'},
	}
})

minetest.register_craft({
        output = 'lord_gems:blue 9',
        recipe = {
                {'lord_gems:blue_block'},
        }
})

minetest.register_craft({
	--type   = 'shapeless',
	output = 'lord_gems:red_block',
	recipe = {
		{'lord_gems:red', 'lord_gems:red', 'lord_gems:red'},
		{'lord_gems:red', 'lord_gems:red', 'lord_gems:red'},
		{'lord_gems:red', 'lord_gems:red', 'lord_gems:red'},
	}
})

minetest.register_craft({
        output = 'lord_gems:red 9',
        recipe = {
                {'lord_gems:red_block'},
        }
})

minetest.register_craft({
	--type   = 'shapeless',
	output = 'lord_gems:white_block',
	recipe = {
		{'lord_gems:white', 'lord_gems:white', 'lord_gems:white'},
		{'lord_gems:white', 'lord_gems:white', 'lord_gems:white'},
		{'lord_gems:white', 'lord_gems:white', 'lord_gems:white'},
	}
})

minetest.register_craft({
        output = 'lord_gems:white 9',
        recipe = {
                {'lord_gems:white_block'},
        }
})

minetest.register_craft({
	output = 'lord_gems:purple_block',
	recipe = {
		{'lord_gems:purple', 'lord_gems:purple', 'lord_gems:purple'},
		{'lord_gems:purple', 'lord_gems:purple', 'lord_gems:purple'},
		{'lord_gems:purple', 'lord_gems:purple', 'lord_gems:purple'},
	}
})

minetest.register_craft({
        output = 'lord_gems:purple 9',
        recipe = {
                {'lord_gems:purple_block'},
        }
})
