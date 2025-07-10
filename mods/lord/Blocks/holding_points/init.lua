

minetest.mod(function(mod)
	if mod.settings:get_bool('disabled', false) then
		mod.logger.warning('Mod `holding_points` disabled.')

		return
	end

	require('holding_points').init(mod)
end)
