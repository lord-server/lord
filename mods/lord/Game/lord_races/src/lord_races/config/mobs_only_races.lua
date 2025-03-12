local S = minetest.get_mod_translator()

local Name  = require('lord_races.Name')


--- @type table<string,lord_races.Race>|lord_races.Race[]
local races = {
	[Name.DUNLENDING] = {
		name            = Name.DUNLENDING,
		title           = S('Dunlending'),
		title_plural    = S('Dunlendings'),
		description     = S(''),
		--faction         = factions.Name.NEUTRAL
	},
	[Name.HALF_TROLL] = {
		name            = Name.HALF_TROLL,
		title           = S('Half-troll'),
		title_plural    = S('Half-trolls'),
		description     = S(''),
		--faction         = factions.Name.NEUTRAL
	},
	[Name.ENT] = {
		name            = Name.ENT,
		title           = S('Ent'),
		title_plural    = S('Ents'),
		description     = S(''),
		--faction         = factions.Name.NEUTRAL
	},
	[Name.TROLL] = {
		name            = Name.TROLL,
		title           = S('Troll'),
		title_plural    = S('Trolls'),
		description     = S(''),
		--faction         = factions.Name.NEUTRAL
	},
	[Name.DEAD_MAN] = {
		name            = Name.DEAD_MAN,
		title           = S('Dead Man'),
		title_plural    = S('Dead People'),
		description     = S(''),
		--faction         = factions.Name.NEUTRAL
	},
	[Name.NAZGUL] = {
		name            = Name.NAZGUL,
		title           = S('Nazgul'),
		title_plural    = S('Nazguls'),
		description     = S(''),
		--faction         = factions.Name.NEUTRAL
	},
	[Name.BALROG] = {
		name            = Name.BALROG,
		title           = S('Balrog'),
		title_plural    = S('Balrogs'),
		description     = S(''),
		--faction         = factions.Name.NEUTRAL
	},
}


return races
