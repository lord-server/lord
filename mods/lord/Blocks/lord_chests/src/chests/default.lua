local spec = minetest.formspec


--- Overwrites `default.chest.get_chest_formspec` function.
--- @return void
local function overwrite_chest_formspec()
	--- @overload fun(position:Position)
	--- @overload fun(position:Position,background:string)
	--- @param position   Position position of chest.
	--- @param background string   form background image file name. [optional]
	--- @param icon       string   icon image file name. [optional]
	default.chest.get_chest_formspec = function(position, background, icon)
		background = background or 'default_chest_form-bg.png'
		icon       = icon       or 'default_chest_form-icon.png'

		local spos = position.x .. ',' .. position.y .. ',' .. position.z

		local formspec = ''
			.. spec.size(8, 9)
			.. spec.no_prepend()
			.. spec.bgcolor('#000c', 'true')
			.. spec.listcolors('#0007', '#5a5a5a', '#141318', '#1238', '#fffc')
			.. spec.background9(0, 0, 8, 9, background, 'true', 0)
			.. spec.background(-.8, -1, 1, 1, icon)
			.. spec.list('nodemeta:' .. spos, 'main', 0, 0.3, 8, 4)
			.. spec.list('current_player', 'main', 0, 4.85, 8, 1)
			.. spec.list('current_player', 'main', 0, 6.08, 8, 3, 8)
			.. spec.listring('nodemeta:' .. spos, 'main')
			.. spec.listring('current_player', 'main')

		return formspec
	end
end


return {
	overwrite_chest_formspec = overwrite_chest_formspec,
}
