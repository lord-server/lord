-- register monster/animal/npc as factions

factions.register({
	name        = 'animal',
	title       = 'Animals',
	description = 'All neutral animals.',
})

factions.register({
	name        = 'npc',
	title       = 'NPCs',
	description = '',
	friends     = { 'npc' },
	hostiles    = { 'monster' },
})

factions.register({
	name        = 'monster',
	title       = 'Monsters',
	description = '',
	friends     = { 'monster' },
	hostiles    = { 'npc' },
})
