
minetest.mod(function(mod)
	require('photometer')
	require('commands.character')

	local environment = minetest.settings:get("environment")
	if not environment or environment == "production" then
		return
	end

	require('commands')
	require('embrasure')
	require('lists')
end)
