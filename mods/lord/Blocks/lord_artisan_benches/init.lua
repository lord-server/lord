

minetest.mod(function(mod)
	require('artisan_benches').init()

	dofile(mod.path..'/legacy.lua')
end)
