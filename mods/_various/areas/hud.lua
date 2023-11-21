-- This is inspired by the landrush mod by Bremaweb
local S = minetest.get_translator("areas")
areas.hud = {}

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local pos = vector.round(player:get_pos())
		local areaStrings = {}
		for id, area in pairs(areas:getAreasAtPos(pos)) do
			table.insert(areaStrings, ("%s [%u] (%s%s)")
					:format(area.name, id, area.owner,
					area.open and S(":open") or ""))
		end
		local areaString = S("Areas:")
		if #areaStrings > 0 then
			areaString = areaString.."\n"..
				table.concat(areaStrings, "\n")
		else
			areaString = ""
		end
		local hud = areas.hud[name]
		if not hud then
			hud = {}
			areas.hud[name] = hud
			hud.areasId = player:hud_add({
				hud_elem_type = "text",
				name = "Areas",
				number = 0xFFFFFF,
				position = {x=0, y=1},
				offset = {x=8, y=-8},
				text = areaString,
				scale = {x=200, y=60},
				alignment = {x=1, y=-1},
			})
			hud.oldAreas = areaString
			return
		elseif hud.oldAreas ~= areaString then
			player:hud_change(hud.areasId, "text", areaString)
			hud.oldAreas = areaString
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	areas.hud[player:get_player_name()] = nil
end)
