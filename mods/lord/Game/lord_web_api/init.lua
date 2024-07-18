

minetest.mod(function(mod)
	if not rawget(_G, "http") then
		minetest.log(
			"warning",
			"Can't initialize `lord_web_api`: Global variable `http` not found: mod `http` not loaded or not initialized."
		)
		return
	end
	require("web_api").init()
end)
