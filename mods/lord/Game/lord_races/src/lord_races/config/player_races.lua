local S = minetest.get_mod_translator()

local Name  = require('lord_races.Name')


--- @type table<string,lord_races.Race>|lord_races.Race[]
local races = {
	[Name.SHADOW] = {
		name            = Name.SHADOW,
		title           = S('Shadow'),
		title_plural    = S('Shadows'),
		description     = S(''),
		for_player      = true,
		for_player_only = true,
		no_corpse       = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.ORC] = {
		name            = Name.ORC,
		title           = S('Orc'),
		title_plural    = S('Orcs'),
		description     = S(''),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.HUMAN] = {
		name            = Name.HUMAN,
		title           = S('Human'),
		title_plural    = S('Humans'),
		description     = S(''),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.DWARF] = {
		name            = Name.DWARF,
		title           = S('Dwarf'),
		title_plural    = S('Dwarves'),
		description     = S(''),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.HOBBIT] = {
		name            = Name.HOBBIT,
		title           = S('Hobbit'),
		title_plural    = S('Hobbits'),
		description     = S(''),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.ELF] = {
		name            = Name.ELF,
		title           = S('Elf'),
		title_plural    = S('Elves'),
		description     = S(''),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
}


return races
