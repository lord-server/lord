--lord_gems
local S = minetest.get_mod_translator()

minetest.register_craftitem('lord_gems:blue', {
	description     = S('Blue Gem'),
	inventory_image = 'lord_gems_blue.png',
})

minetest.register_craftitem('lord_gems:red', {
	description     = S('Red Gem'),
	inventory_image = 'lord_gems_red.png',
})

minetest.register_craftitem('lord_gems:white', {
	description     = S('White Gem'),
	inventory_image = 'lord_gems_white.png',
})

minetest.register_craftitem('lord_gems:purple', {
	description     = S('Purple Gem'),
	inventory_image = 'lord_gems_purple.png',
	groups          = { forbidden = 1 },
})

minetest.register_craft({
	type   = 'shapeless',
	output = 'lord_gems:purple',
	recipe = {'lord_gems:blue', 'lord_gems:red'},
})
