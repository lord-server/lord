

minetest.mod(function(mod)
	require("planks").init()

	dofile(mod.path .. "/legacy.lua")
end)
