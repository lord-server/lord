

minetest.mod(function(mod)
	require('ropes').init(mod)

	dofile(mod.path..'/aliases.lua')
end)
