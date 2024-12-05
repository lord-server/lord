

minetest.mod(function(mod)
	require('laboratory').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
