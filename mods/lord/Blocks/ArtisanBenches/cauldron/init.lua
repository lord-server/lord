

minetest.mod(function(mod)
	require('cauldron').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
