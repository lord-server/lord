

minetest.mod(function(mod)
	require('lord_potions').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
