local S    = minetest.get_mod_translator()
local Form = require('anvil.Form')


local px = 1/16
local node_box = {
	type  = 'fixed',
	fixed = {
		-- Подошва
		{ -8*px, -8*px, -8*px,  -4*px, -5*px, -4*px }, -- ножки подошвы
		{ -8*px, -8*px,  8*px,  -4*px, -5*px,  4*px },
		{  8*px, -8*px,  8*px,   4*px, -5*px,  4*px },
		{  8*px, -8*px, -8*px,   4*px, -5*px, -4*px },

		{ -7*px, -8*px, -6*px,   7*px, -5*px,  6*px }, -- сердцевины подошвы
		{ -5*px, -5*px, -4*px,   5*px, -2*px,  4*px },

		-- Ножка / шея
		{ -3*px, -2*px, -2*px,   3*px,  3*px,  2*px },
		-- Рабочая область (наличник)
		{ -5*px,  3*px, -4*px,   5*px,  8*px,  4*px },

		-- Рог
		{ -5*px,  5*px, -2*px,  -8*px,  8*px,  2*px },

		-- Обух с отверстием Харди
		{ 7*px, 5*px, -4*px,   8*px, 8*px,  4*px  },
		{ 5*px, 5*px, -2*px,   7*px, 6*px,  2*px  },
		{ 5*px, 5*px, -4*px,   7*px, 8*px, -2*px  },
		{ 5*px, 5*px,  2*px,   7*px, 8*px,  4*px  },
	},
}

local function register_node()
	minetest.register_node('anvil:anvil', {
		description   = S('Anvil'),
		drawtype      = 'mesh',
		mesh          = 'anvil.obj',
		tiles         = { 'benches_anvil.png' },
		groups        = { cracky = 1, falling_node = 1 },
		selection_box = node_box,
		collision_box = node_box,
		paramtype     = 'light',
		paramtype2    = 'facedir',
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			Form:new(clicker, pos):open()
		end
	})
end

local function register_craft()
	minetest.register_craft({
		output = 'anvil:anvil',
		recipe = {
			{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
			{ '', 'default:steel_ingot', '' },
			{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		}
	})
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		minetest.CraftMethod.ANVIL = 'anvil'
		minetest.register_craft_method(minetest.CraftMethod.ANVIL)

		Form:register()

		register_node()
		register_craft()
	end,
}
