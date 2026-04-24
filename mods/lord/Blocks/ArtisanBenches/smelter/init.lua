
minetest.mod(function(mod)
	if mod.settings:get_bool('toggle_smelter', false) then
		return
	end

	require('smelter').init(mod)
	require('recipes')
end)
