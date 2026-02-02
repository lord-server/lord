

minetest.mod(function(mod)
	require('lord_alcohol').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
