local S     = minetest.get_mod_translator()

core.register_craftitem('smelter:crucible', {
	description     = S('Crucible of Isengard')  .. '\n' ..
		S('A black crucible from the depths of Isengard. It smelted steel for the Uruk-Hai armies') .. '\n' ..
		S('— and he still remembers that heat.'),
	_rank           = item_rank.Type.EPIC,
	inventory_image = 'crucible_of_isengard.png',
	groups          = {},
})

core.register_craftitem('smelter:hearth', {
	description     = S('Hearth of Khazad-dûm') .. '\n' ..
		S('A blazing hearth from the depths of Khazad-dûm. Only it can produce heat sufficient to') .. '\n' ..
		S('smelt mithril.'),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'hearth_kd.png',
	groups          = {},
})
