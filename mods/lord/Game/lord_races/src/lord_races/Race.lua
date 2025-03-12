
--- @class lord_races.Race
local Race = {
	--- @type string  race-code, one of `lord_races.Race.<NAME>` constants.
	name            = nil,
	--- @type string  human-readable translated race title.
	title           = '',
	--- @type string  human-readable translated race title in the plural.
	title_plural    = '',
	--- @type string  human-readable translated description of race.
	description     = '',
	--- @type boolean whether the race can be chosen by player.
	for_player      = false,
	--- @type boolean whether the race is only for player (not for mobs).
	for_player_only = false,
	--- @type boolean whether the corpse of player with this race must be left on die place (not for mobs).
	no_corpse       = false,
	--- @type string  faction-code.
	faction         = nil,
}

--- @param race table|lord_races.Race
function Race:new(race)
	return setmetatable(race, { __index = Race })
end


return Race
