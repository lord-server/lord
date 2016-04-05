local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

defaults = {}

-- GHOST
-- ghost_stone
minetest.register_node("defaults:st0ne", {
	description = SL("Ghost Stone"), 
	tiles = {"default_stone.png"},
	--tiles = {"ghost_stone_inv.png"},
	is_ground_content = true,
	inventory_image = "ghost_stone_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	--drop = 'defaults:st0ne',
	legacy_mineral = true,
	--liquidtype = "flowing",
	--liquid_viscosity = 1,
	--liquid_range = 2,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:st0ne',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:stone', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost cobble
minetest.register_node("defaults:c0bble", {
	description = SL("Ghost Cobble"), 
	tiles = {"default_cobble.png"},
	is_ground_content = true,
	inventory_image = "ghost_cobble_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:c0bble',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:cobble', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost desert stone
minetest.register_node("defaults:desert_st0ne", {
	description = SL("Ghost Desert Stone"), 
	tiles = {"default_desert_stone.png"},
	is_ground_content = true,
	inventory_image = "ghost_desert_stone_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:desert_st0ne',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:desert_stone', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost desert cobble
minetest.register_node("defaults:desert_c0bble", {
	description = SL("Ghost Desert Cobble"), 
	tiles = {"default_desert_cobble.png"},
	is_ground_content = true,
	inventory_image = "ghost_desert_cobble_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:desert_c0bble',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:desert_cobble', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost brick
minetest.register_node("defaults:bricks", {
	description = SL("Ghost Brick"), 
	tiles = {"default_brick.png"},
	is_ground_content = true,
	inventory_image = "ghost_brick_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:bricks',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:brick', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost stone brick
minetest.register_node("defaults:st0ne_brick", {
	description = SL("Ghost Stone Brick"), 
	tiles = {"default_stone_brick.png"},
	is_ground_content = true,
	inventory_image = "ghost_stone_brick_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:st0ne_brick',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:stonebrick', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost desert stone brick
minetest.register_node("defaults:desert_st0ne_brick", {
	description = SL("Ghost Desert Stone Brick"), 
	tiles = {"default_desert_stone_brick.png"},
	is_ground_content = true,
	inventory_image = "ghost_desert_stone_brick_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:desert_st0ne_brick',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:desert_stonebrick', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost sandstone
minetest.register_node("defaults:sandst0ne", {
	description = SL("Ghost Sandstone"), 
	tiles = {"default_sandstone.png"},
	is_ground_content = true,
	inventory_image = "ghost_sandstone_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:sandst0ne',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:sandstone', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

-- ghost sandstone brick
minetest.register_node("defaults:sandst0nebrick", {
	description = SL("Ghost Sandstone Brick"), 
	tiles = {"default_sandstone_brick.png"},
	is_ground_content = true,
	inventory_image = "ghost_sandstone_brick_inv.png",
	walkable = false,
	groups = {cracky=3, stone=1},
	legacy_mineral = true,
	post_effect_color = {a = 255, r = 0, g = 0, b = 0},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'defaults:sandst0nebrick',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:sandstonebrick', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
