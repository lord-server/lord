local table_keys_has_one_of_values
    = table.keys_has_one_of_values

local ARENA_AREA_IDS = {}

local arena_ids = minetest.settings:get('arenas') or ''
arena_ids       = string.split(arena_ids, ',')
for _, v in ipairs(arena_ids) do
	table.insert(ARENA_AREA_IDS, tonumber(v))
end

nametag.segments.add('health', '#0f0', ' ♥ %s')

--- This table shows for whom of players hp is now displaying.
--- @type table<string,boolean>
local health_displayed_for = {}

--- @param player Player
local function player_display_hp(player)
	local name = player:get_player_name()
	local tag_segment = nametag.for_player(player):segment('health')
	local hp = player:get_hp()

	if health_displayed_for[name] and tag_segment:get_value() == hp then
		return
	end

	local color = hp > 13 and '#00FF00'	or (hp > 6 and '#FFFF00' or '#FF0000')
	tag_segment:set_value(hp, color):update()
	health_displayed_for[name] = true
end

--- @param player Player
local function player_undisplay_hp(player)
	local name = player:get_player_name()
	if not health_displayed_for[name] then
		return
	end

	nametag.for_player(player):segment('health'):set_value(nil):update()
	health_displayed_for[name] = nil
end

minetest.foreach_player_every(0.2, function(player)
	local pos = vector.round(player:get_pos())
	local in_arena = table_keys_has_one_of_values(areas:getAreasAtPos(pos), ARENA_AREA_IDS)

	if in_arena then
		player_display_hp(player)
	else
		player_undisplay_hp(player)
	end
end)
