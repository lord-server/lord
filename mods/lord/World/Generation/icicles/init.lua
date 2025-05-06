

minetest.mod(function(mod)
	require('icicles').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
