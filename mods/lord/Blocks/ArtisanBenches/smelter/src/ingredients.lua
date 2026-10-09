local S     = minetest.get_mod_translator()
local colorize = minetest.colorize

core.register_craftitem('smelter:crucible', {
	description     = S('Crucible of Isengard')  .. '\n' ..
		colorize ('#AAAAAA',S ('A black crucible from the depths of Isengard.')) .. '\n' ..
		colorize ('#AAAAAA',S('It smelted steel for the Uruk-Hai armies')) .. '\n' ..
		colorize ('#AAAAAA',S('— and he still remembers that heat.')),
	_rank           = item_rank.Type.EPIC,
	inventory_image = 'crucible_of_isengard.png',
})

core.register_craftitem('smelter:hearth', {
	description     = S('Hearth of Khazad-dûm') .. '\n' ..
		colorize ('#AAAAAA',S('A blazing hearth from the depths of Khazad-dûm.')) .. '\n' ..
		colorize ('#AAAAAA',S('Only it can produce heat sufficient to')) .. '\n' ..
		colorize ('#AAAAAA',S('smelt mithril.')),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'hearth_kd.png',
})
