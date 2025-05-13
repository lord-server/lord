

minetest.mod(function(mod)
	local environment         = minetest.settings:get('environment')
	local caves_debug_enabled = mod.settings:get_bool('enabled', false)

	if not environment or environment == 'production' or not caves_debug_enabled then
		return
	end

	minetest.register_decoration({
		name         = 'caves_debug:lighting_gas',
		deco_type    = 'simple',
		place_on     = table.keys(rocks.get_nodes()),
		sidelen      = 32,
		fill_ratio   = 0.2,
		y_min        = -31000,
		y_max        = -10,
		decoration   = 'arena:lighting_gas',
		spawn_by     = 'air',
		num_spawn_by = 2,
		flags        = 'liquid_surface, force_placement, all_floors, all_ceilings',
	})
end)
