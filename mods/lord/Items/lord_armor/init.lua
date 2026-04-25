minetest.mod(function(mod)
    require('armor')
    require('shield')
    if core.settings:get_bool('toggle_racial_armor', false) then
	    require('racial')
	end
end)
