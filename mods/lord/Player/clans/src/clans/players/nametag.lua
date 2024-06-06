
nametag.segments.add("clan", "lime", "[%s]")

---@param player_name string
---@param clan_title  string|nil
local function set_player_nametag(player_name, clan_title)
	local player = minetest.get_player_by_name(player_name)
	if not player then return end

	nametag.for_player(player):segment("clan"):set_value(clan_title):update()
end

clans.on_clan_created(function(clan)
	for _, player_name in ipairs(clan.players) do
		set_player_nametag(player_name, clan.title)
	end
end)

clans.on_clan_deleted(function(clan)
	for _, player_name in ipairs(clan.players) do
		set_player_nametag(player_name)
	end
end)

clans.on_clan_player_added(function(clan, player_name)
	set_player_nametag(player_name, clan.title)
end)

clans.on_clan_player_removed(function(clan, player_name)
	set_player_nametag(player_name)
end)
