
-- default/chests.lua
-- Нам нужно только подсунуть свой фон (background), но для этого приходится переопределить ф-цию:
default.chest.get_chest_formspec = function(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
	"size[8,9]" ..
		"list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]" ..
		"background[-0.5,-0.65;9,10.35;gui_chestbg.png]" ..
		default.get_hotbar_bg(0,4.85)
	return formspec
end
