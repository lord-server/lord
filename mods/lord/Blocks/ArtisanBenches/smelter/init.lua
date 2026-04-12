
minetest.mod(function(mod)
	if not core.settings:get_bool('toggle_smelter', false) then
		return
	end

	require('smelter').init(mod)
	require('legacy')
	require('register_recipes')
end)
