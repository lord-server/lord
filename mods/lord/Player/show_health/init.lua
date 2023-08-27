local ARENA_AREA_IDS = {}

local arena_ids      = minetest.settings:get("arenas") or ""
arena_ids            = string.split(arena_ids, ",")
for _, v in ipairs(arena_ids) do
	table.insert(ARENA_AREA_IDS, tonumber(v))
end

--- This table shows for whom of players hp is now displaying. And stores previous nametag.
--- @type table<string,boolean>
local displayed_after_nametag = {}

--- @param player Player
local function player_display_hp(player)
	local name = player:get_player_name()
	if displayed_after_nametag[name] then -- if health already displaying
		return
	end

	local previous_nametag = player:get_nametag_attributes().text
	if not previous_nametag or previous_nametag == "" then
		previous_nametag = name
	end
	local hp = player:get_hp()
	local color
	if hp > 13 then
		color = "#00FF00"
	elseif hp > 6 then
		color = "#FFFF00"
	else
		color = "#FF0000"
	end
	player:set_properties({nametag = previous_nametag .. minetest.colorize(color, " ♥ "..hp)})
	displayed_after_nametag[name] = previous_nametag
end

--- @param player Player
local function player_undisplay_hp(player)
	local name = player:get_player_name()
	if not displayed_after_nametag[name] then
		return
	end
	local previous_nametag = displayed_after_nametag[name]
	player:set_properties({nametag = previous_nametag})
	displayed_after_nametag[name] = nil
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
