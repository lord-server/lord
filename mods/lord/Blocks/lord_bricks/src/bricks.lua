local S = minetest.get_mod_translator()

require('bricks.rock')

-- Raw Brick for default clay
minetest.register_craftitem("lord_bricks:clay_brick_raw", {
	description = S("Raw Clay Brick"),
	inventory_image = "lord_bricks_clay_brick_raw.png"
})


return {
	--- @param mod minetest.Mod
	init = function(mod)
		require('bricks.crafts')
		require('bricks.chamotte')
		require('bricks.mordor')

	end
}
