

minetest.mod(function(mod)
	require('glasses')
	require('bottles')
	require('pints')

	dofile(mod.path .. '/legacy.lua')
end)
