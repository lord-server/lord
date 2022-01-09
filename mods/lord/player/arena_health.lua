local ARENA_AREA_IDS = {}

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

local function has_value(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

local function mysplit(s, sep)
	local t={}
        for str in string.gmatch(s, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

local arena_ids = minetest.settings:get("arenas") or ""
arena_ids = arena_ids:gsub(" ", "")
local ids = mysplit(arena_ids, ",")

for _, v in ipairs(ids) do
	local id = tonumber(v)
	table.insert(ARENA_AREA_IDS, id)
end

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local pos = vector.round(player:getpos())
		local in_arena = false
		for id, _ in pairs(areas:getAreasAtPos(pos)) do
			if has_value(ARENA_AREA_IDS, id) then
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
