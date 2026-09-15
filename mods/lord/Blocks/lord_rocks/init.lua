

core.mod(function(mod)
	require("rocks").init()

	dofile(mod.path .. "/legacy.lua")
end)
