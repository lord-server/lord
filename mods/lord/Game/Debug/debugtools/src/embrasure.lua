minetest.register_node("debugtools:arrownode", {
	description = "Automatic shooting node",
	tiles = {"lottblocks_snowycobble.png"},
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos, elapsed)
		local timer = minetest.get_node_timer(pos)
		timer:start(1)
		local dir = {x = -1, y=0, z=0}
		local arrow = "lord_projectiles:steel_arrow"
		minetest.log("shoot at "..pos.x.." "..pos.y.." "..pos.z)
		archery.projectile_shoot(nil, arrow, 1, dir, {x=pos.x, y=pos.y, z=pos.z})
	end,
})
