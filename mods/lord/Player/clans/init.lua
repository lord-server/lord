--- @class Clan
--- @field public title string
--- @field public players table<number,string>


-- HACK: this is a quick hardcoded local storage for clans data
-- TODO: save this data somewhere else (mod-storage?)
-- TODO: commands for manage
--- @type table<string,Clan>
local clans = {
	masons = {
		title = "Masons",
		players = {	"Petus_mason", "Swed_mason", "Dormi_mason", "Jiki_mason", "Alek_mason", "Zhekil_mason" },
	},
	havit = {
		title = "Havit-Nakyar",
		players = { "Doloment", "Sdoh", "Aiex" }
	},
	vassals = {
		title = "Vassals",
		players = { "Pilsner_vassal", "PePe_vassal", "JakeVovaDimas", "Semi_vassal" },
	},
}

--- @param player Player
--- @return Clan|table|nil returns clan data ( `{ title = "...", players {...}, ... }` )
local function get_clan(player)
	local player_name = player:get_player_name()

	for _, clan in pairs(clans) do
		if table.contains(clan.players, player_name) then
			return clan
		end
	end

	return nil
end

minetest.register_on_joinplayer(function(player, last_login)
	if not player or not player:is_player() then
		return
	end

	local clan = get_clan(player)
	if not clan then
		return
	end

	player:set_nametag_attributes({
		text = player:get_player_name() .. " " .. minetest.colorize("#3d7", "["..clan.title.."]"),
	})
end)
