core.mod(function(mod)
    require('armor')
    require('shield')

	-- TODO временно:
    require('racial.dwarf')

    if core.settings:get_bool('toggle_racial_armor', false) then
	    require('racial')
	end
end)
