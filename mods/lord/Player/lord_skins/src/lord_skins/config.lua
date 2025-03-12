

--- @type table<string,{skins_count:{male:number,female:number}}>
local skins = {
	[lord_races.Name.SHADOW] = { skins_count = {
		male   = 1,
		female = 1,
	} },
	[lord_races.Name.ORC]    = { skins_count = {
		male   = 5,
		female = 5,
	} },
	[lord_races.Name.HUMAN]  = { skins_count = {
		male   = 8,
		female = 5,
	} },
	[lord_races.Name.DWARF]  = { skins_count = {
		male   = 5,
		female = 5,
	} },
	[lord_races.Name.HOBBIT] = { skins_count = {
		male   = 5,
		female = 5,
	} },
	[lord_races.Name.ELF]    = { skins_count = {
		male   = 6,
		female = 5,
	} },
}

return skins
