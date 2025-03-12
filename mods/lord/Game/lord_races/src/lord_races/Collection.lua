
--- @class lord_races.Collection
local Collection = {
	--- @type lord_races.Race[]
	all          = {},
	--- @type lord_races.Race[]
	player_races = {},
	--- @type lord_races.Race[]
	mob_races    = {},
}

--- @static
--- @param race lord_races.Race
function Collection.add(race)
	Collection.all[race.name] = race
	if race.for_player then
		Collection.player_races[race.name] = race
	end
	if not race.for_player_only then
		Collection.mob_races[race.name] = race
	end
end


return Collection
