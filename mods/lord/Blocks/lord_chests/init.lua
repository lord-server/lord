

minetest.mod(function(mod)
	require('chests').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
