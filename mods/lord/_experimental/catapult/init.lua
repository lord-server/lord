

minetest.mod(function(mod)
	local environment = minetest.settings:get("environment")
	if not environment or environment == "production" then
		return
	end


	minetest.register_node('catapult:catapult', {
		drawtype = "mesh",
		mesh = 'catapult.obj',
		tiles = {
			'catapult.png'
		},
	})
end)
