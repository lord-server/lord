
-- default/chests.lua
-- Нам нужно только подсунуть свой фон (background), но для этого приходится переопределить ф-цию:
local old_chest_get_chest_formspec = default.chest.get_chest_formspec
default.chest.get_chest_formspec = function(pos)
	return old_chest_get_chest_formspec(pos) .. "background[-0.5,-0.65;9,10.35;gui_chestbg.png]"
end


-- default/furnace.lua
-- Нам нужно только подсунуть свой фон
local old_get_furnace_active_formspec = default.get_furnace_active_formspec
local old_get_furnace_inactive_formspec = default.get_furnace_inactive_formspec
default.get_furnace_active_formspec = function(fuel_percent, item_percent)
	return old_get_furnace_active_formspec(fuel_percent, item_percent) ..
		"background[-0.5,-0.65;9,10.35;gui_furnacebg.png]"
end
default.get_furnace_inactive_formspec = function()
	return old_get_furnace_inactive_formspec() ..
		"background[-0.5,-0.65;9,10.35;gui_furnacebg.png]"
end
