

minetest.mod(function(mod)
	require("ground").init()

	dofile(mod.path.."/legacy.lua")
end)
