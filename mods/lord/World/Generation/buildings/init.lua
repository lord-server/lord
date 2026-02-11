

minetest.mod(function(mod)
	require('dwarven')

	if mod.settings:get_bool('toggle_dungeons', false) then
		require('orcish').init(mod)
	end
end)
