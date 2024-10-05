

minetest.mod(function(mod)
	require('bricks').init(mod)

	dofile(mod.path .. "/legacy.lua")
end)
