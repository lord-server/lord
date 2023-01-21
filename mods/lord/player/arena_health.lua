local table_has_value
	= table.has_value

local ARENA_AREA_IDS = {}

local arena_ids      = minetest.settings:get("arenas") or ""
arena_ids            = string.split(arena_ids, ",")
for _, v in ipairs(arena_ids) do
	table.insert(ARENA_AREA_IDS, tonumber(v))
end

--- @param player Player
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

--- @param player Player
local function player_undisplay_hp(player)
	local name = player:get_player_name()
	player:set_properties({nametag = name, nametag_color = "#FFFFFF",})
end

-- TODO: move this function into Core/helpers
--- @param list table
--- @param values table
local function table_keys_has_one_of_values(list, values)
	for key in pairs(list) do
		if table_has_value(values, key) then
			return true
		end
	end
	return false
end

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local pos = vector.round(player:get_pos())
		local in_arena = table_keys_has_one_of_values(areas:getAreasAtPos(pos), ARENA_AREA_IDS)

		if in_arena then
			player_display_hp(player)
		else
			player_undisplay_hp(player)
		end
	end
end)
