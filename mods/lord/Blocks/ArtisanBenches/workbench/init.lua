

minetest.mod(function(mod)
	require('workbench').init(mod)

	dofile(mod.path .. '/legacy.lua')
end)
