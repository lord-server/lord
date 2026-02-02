local S = minetest.get_mod_translator()


local px = 1/16
--- @type {box:number[]}[]
local wooden_bowls = {
	{ box = { -5*px, -8*px, -5*px, 5*px, -6*px, 5*px } },
	{ box = { -4*px, -8*px, -4*px, 4*px, -5*px, 4*px } },
	{ box = { -4*px, -8*px, -4*px, 4*px, -6*px, 4*px } },
	{ box = { -6*px, -8*px, -3*px, 4*px, -6*px, 7*px } },
	{ box = { -2*px, -8*px, -1*px, 6*px, -5*px, 7*px } },
	{ box = { -6*px, -8*px, -7*px, 2*px, -6*px, 1*px } },
}

-- Single Item for all BOWLS_WOOD_COUNT nodes, registered below.
-- Only the Item has craft.
minetest.register_craftitem('lord_vessels:bowl_wood', {
	description = S('Bowl'),
	inventory_image = 'lord_vessels_bowl_inv.png',
	on_place = function(itemstack, placer, pointed_thing)
		-- place a random Bowl node
		local stack = ItemStack('lord_vessels:bowl_wood_' .. math.random(#wooden_bowls))
		local ret = minetest.item_place(stack, placer, pointed_thing)

		return ItemStack('lord_vessels:bowl_wood ' .. itemstack:get_count() - (1 - ret:get_count()))
	end,
	groups      = { vessels = 1, dig_immediate = 3 }
})

-- All variants of Bowls nodes, that placed. Drops the Item.
for i = 1, #wooden_bowls do
	minetest.register_node('lord_vessels:bowl_wood_'..i, {
		description = S('Bowl'),
		drawtype    = 'mesh',
		mesh        = 'lord_vessels_bowl_'..i..'.obj',
		tiles       = { 'lord_vessels_bowl_wood_'..((i-1) % 3 + 1)..'.png' },
		use_texture_alpha = 'clip',
		selection_box   = {
			type  = 'fixed',
			fixed = wooden_bowls[i].box
		},
		paramtype   = 'light',
		paramtype2  = 'facedir',
		walkable    = false,
		drop        = 'lord_vessels:bowl_wood',
		groups      = { vessels = 1, dig_immediate = 3 }
	})
end

-- craft of the wielded Item (of Bowl)
minetest.register_craft({
	output = 'lord_vessels:bowl_wood 3',
	recipe = {
		{'group:wood', '', 'group:wood'},
		{'', 'group:wood', ''},
		{'', '', ''},
	}
})
