local S = minetest.get_mod_translator()

local Name  = require('lord_races.Name')

--- @class lord_races.config.RaceDefinition
--- @field name string
--- @field title string
--- @field title_plural string
--- @field description string
--- @field for_player boolean|nil
--- @field for_player_only boolean|nil
--- @field no_corpse boolean|nil
-- --- @field faction string

--- @type table<string,lord_races.config.RaceDefinition>|lord_races.config.RaceDefinition[]
local races = {
	[Name.SHADOW] = {
		name            = Name.SHADOW,
		title           = S('Shadow'),
		title_plural    = S('Shadows'),
		description     = S(
			'You are a shadow. The disembodied ghost of middle-earth. '..
			'A sad fate awaits you in this guise, no one hears or sees you. '..
			'The only indisputable property of shadows is that they can fly. '..
			'Sauron was kind in those days and gave the repentant spirits the opportunity to take on a bodily form. '..
			'You can look around in different places before using the race selection.'),
		for_player      = true,
		for_player_only = true,
		no_corpse       = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.ORC] = {
		name            = Name.ORC,
		title           = S('Orc'),
		title_plural    = S('Orcs'),
		description     = S(
			'Born in the shadow of the Black Gate, they are strong as Mordor`s steel and stubborn as Gorgoroth`s crags. '..
			'Their curved blades remember a thousand battles, their hearts - the ashes of defeat. '..
			'Their forges made armor that elven arrows could not pierce, their camps endured the harshest lands. '..
			'Their skin is scorched by the sun, their souls scarred by free folk`s mockery. But orcs ask no pity. '..
			'They survive where others would perish. '..
			'Let others see only brutes - they know even an accursed race can earn respect in fair combat. '..
			'Their forges make weapons that poison flesh, and Mordor`s chests open only to those who know the Black Speech.'),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.HUMAN] = {
		name            = Name.HUMAN,
		title           = S('Human'),
		title_plural    = S('Humans'),
		description     = S(
			'Mortal yet great in deeds. '..
			'Their lives are but a flicker in the eyes of elves, yet it is men who change the course of history. '..
			'Strong in spirit yet prone to temptation, they build kingdoms that flourish and fall in an endless cycle. '..
			'Their swords may lack elven craft, but in a heroes hand, they work wonders. '..
			'Their hands can open the chests of Gondor and Rohan, for the blood of Númenor still flows in their veins - '..
			'but will they be wise enough not to repeat its downfall?'),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.DWARF] = {
		name            = Name.DWARF,
		title           = S('Dwarf'),
		title_plural    = S('Dwarves'),
		description     = S(
			'Born in mountain depths, dwarves are strong as adamant and stubborn as stone. '..
			'Their axes hew rock and flesh with equal fury. '..
			'Dwarves neither forgive wrongs nor forget friendships. '..
			'Their treasuries delve deeper than world roots, their cavern cities outlast ages. '..
			'Gold flows in their veins, but their hearts are harder than mithril. '..
			'Their doors open only to those who know secret runes, and their forges make weapons that '..
			'make even Mordor`s darkness tremble. '..
			'Their axes crush foes as easily as stone, and the locks of dwarven treasuries yield to none but Durin`s kin.'),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.HOBBIT] = {
		name            = Name.HOBBIT,
		title           = S('Hobbit'),
		title_plural    = S('Hobbits'),
		description     = S(
			'Small yet great in simplicity. '..
			'Their homes are cozy, their fields green, and their hearts brave when need arises. '..
			'They don`t seek glory, yet glory finds them. They wear no crowns nor wield magic, '..
			'yet their courage - quiet as the rustle of the Shire`s grass - can topple even the darkest lords. '..
			'Their knives are small, yet one such blade has already torn the Shadow. '..
			'A hobbit would prefer a feast to a fight, but when enemies come knocking, they battle like lions. '..
			'Their small hands deftly open the Shire`s round doors, '..
			'and their knives - unassuming though they seem - once decided the Dark Lord`s fate.'),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
	[Name.ELF] = {
		name            = Name.ELF,
		title           = S('Elf'),
		title_plural    = S('Elves'),
		description     = S(
			'Ancient and wise, they came into the world beneath starlight and are in no hurry to depart. '..
			'Lothlórien and Mirkwood guard their secrets, '..
			'their blades remain ever-sharp even in battles against ancient demons, their arrows chase shadows. '..
			'Elves cannot master time, yet time cannot master them. When the world was young, elves already sang of its fate. '..
			'Now they have grown rare as morning dew at dusk, yet their power remains undiminished. '..
			'Those who choose this folk will walk among trees that remember the first dawns and wield swords that hold '..
			'the light of Valinor. Only their fingers know the ancient runes on Lorien`s chests, and their blades, '..
			'forged under the light of the Silmarils, never dull.'),
		for_player      = true,
		--faction         = factions.Name.NEUTRAL
	},
}


return races
