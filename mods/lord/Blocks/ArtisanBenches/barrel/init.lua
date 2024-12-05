

minetest.mod(function(mod)
	require('barrel').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
