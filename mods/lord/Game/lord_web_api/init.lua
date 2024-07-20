

minetest.mod(function(mod)
	if not rawget(_G, "http") then
		-- Don't use `mod.logger` here. This will create new Logger instance, but it will not be used.
		minetest.log(
			"warning",
			"[" .. mod.name .. "] Can't initialize `lord_web_api`: " ..
				"Global variable `http` not found: mod `http` not loaded or not initialized."
		)
		return
	end
	require("web_api").init(mod)
end)
