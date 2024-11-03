

minetest.mod(function(mod)
	require('glasses')
	require('bottles')
	require('pints')
	require('plates')  -- bowls & other plates
	require('can')     -- steel bottle

	dofile(mod.path .. '/legacy.lua')
end)
