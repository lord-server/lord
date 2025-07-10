local S    = minetest.get_mod_translator()
local Form = require('anvil.Form')


local px = 1/16
local node_box = {
	type  = 'fixed',
	fixed = {
		{-8/16, 2/16, -5/16, 8/16, 8/16, 5/16},
		{-5/16, -4/16, -2/16, 5/16, 5/16, 2/16},
		{-8/16, -8/16, -5/16, 8/16, -4/16, 5/16},
	},
}

local function register_node()
	minetest.register_node('anvil:anvil', {
		description   = S('Anvil'),
		drawtype      = 'nodebox',
		tiles         = {
			'benches_anvil_top.png',
			'benches_anvil_top.png',
			'benches_anvil_side.png',
			'benches_anvil_side.png',
			'benches_anvil_front.png',
			'benches_anvil_front.png'
		},
		groups        = { cracky = 1, falling_node = 1 },
		node_box      = node_box,
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
