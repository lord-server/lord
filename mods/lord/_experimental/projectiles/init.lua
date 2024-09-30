GRAVITY = minetest.settings:get("movement_gravity") or 9.81

minetest.mod(function(mod)
	require("projectiles").init()
end)
