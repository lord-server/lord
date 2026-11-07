local S        = core.get_mod_translator()
local spec     = forms.Spec
local colorize = core.colorize
local grey     = '#ccc'

--- @param level 1|2|3
--- @return fuel_device.node.Form
return function(level)
	local title = S('Smelter') .. ' ' .. colorize(grey, S('(Level: @1)', level))

	--- @class Lord.smelter.node.Form: fuel_device.node.Form
	local Form = {
		get_spec = function(type, percent)
			assert(type:is_one_of({ 'active', 'inactive' }))
			percent = percent or 0
			local inv_percent = 100 - percent

			return ''
				.. spec.size(8, 9)
				.. spec.label(0, 0, title)
				.. (type == 'inactive'
					and spec.image(3.5, 1, 1, 2, 'lord_smelter_' .. level .. '_front.png')
					or  spec.image(3.5, 1, 1, 2, 'lord_smelter_bg.png^[lowpart:' .. inv_percent .. ':lord_smelter_fg.png]')
				)
				.. spec.image(4.5, 2, 1, 1, 'benches_form_arrow.png')
				.. spec.label(2.3, 3.2, S('Fuel:'))
				.. spec.list('current_name', 'fuel', 3.5, 3, 1, 1)
				.. spec.label(0.5, 1.5, S('Ingredients:'))
				.. spec.list('current_name', 'src', 0.5, 2, 2, 1)
				.. spec.label(5.5, 1.5, S('Result:'))
				.. spec.list('current_name', 'dst',5.5,2,2,2)
				.. spec.list('current_player', 'main',0,5,8,4)
				.. spec.listring('current_name', 'fuel')
				.. spec.listring('current_player', 'main')
				.. spec.listring('current_name', 'src')
				.. spec.listring('current_player', 'main')
				.. spec.listring('current_name', 'dst')
				.. spec.listring('current_player', 'main')
		end
	}

	return Form
end
