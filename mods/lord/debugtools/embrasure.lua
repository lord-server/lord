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
		local arrow = "arrows:arrow_steel"
		minetest.log("shoot at "..pos.x.." "..pos.y.." "..pos.z)
		throwing:shoot({x=pos.x, y=pos.y, z=pos.z}, "node", arrow, pos, dir, 0.5)
	end,
})
