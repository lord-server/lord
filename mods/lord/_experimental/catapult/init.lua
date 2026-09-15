

core.mod(function(mod)
	local environment = core.settings:get("environment")
	if not environment or environment == "production" then
		return
	end


	core.register_node('catapult:catapult', {
		drawtype = 'mesh',
		mesh = 'catapult.obj',
		tiles = {
			'catapult.png'
		},
		paramtype = 'light',
	})
end)
