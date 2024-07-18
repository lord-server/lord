

minetest.mod(function(mod)
	require("tree").init()

	dofile(mod.path .. "/legacy.lua")
end)
