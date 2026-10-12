local S = core.get_mod_translator()


core.register_craftitem('lord_smelter:crucible', {
	description     = S('Crucible of Isengard'),
	_annotation =
		S('A black crucible from the depths of Isengard.') .. '\n' ..
		S('It smelted steel for the Uruk-Hai armies') .. '\n' ..
		S('— and he still remembers that heat.'),
	_rank           = item_rank.Type.EPIC,
	inventory_image = 'crucible_of_isengard.png',
})

core.register_craftitem('lord_smelter:hearth', {
	description     = S('Hearth of Khazad-dûm'),
	_annotation =
		S('A blazing hearth from the depths of Khazad-dûm.') .. '\n' ..
		S('Only it can produce heat sufficient to') .. '\n' ..
		S('smelt mithril.'),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'hearth_kd.png',
})
