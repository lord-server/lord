

minetest.mod(function(mod)
	require('anvil').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
