local ARENA_AREA_ID = 2316

local function player_display_hp(player)
	local name = player:get_player_name()
	local hp = player:get_hp()
	local color
	if hp > 13 then
		color = "#00FF00"
	elseif hp > 6 then
		color = "#FFFF00"
	else
		color = "#FF0000"
	end
	player:set_properties({nametag = name.." ♥ "..hp, nametag_color = color,})
end

local function player_undisplay_hp(player)
	local name = player:get_player_name()
	player:set_properties({nametag = name, nametag_color = "#FFFFFF",})
end

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local pos = vector.round(player:getpos())
		local in_arena = false
		for id, _ in pairs(areas:getAreasAtPos(pos)) do
			if id == ARENA_AREA_ID then
				in_arena = true
				break
			end
		end
		if in_arena then
			player_display_hp(player)
		else
			player_undisplay_hp(player)
		end
	end
end)
