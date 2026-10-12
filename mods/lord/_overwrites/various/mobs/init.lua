local S_mobs = core.get_translator('mobs')


core.override_item("bees:honey", {
	on_use      = core.item_eat(18),
	_tt_food_hp = 18,
})

core.override_item('mobs:nametag', {
	description = S_mobs('Name Tag'),
	_hint       = S_mobs('Right-click Mobs Redo mob to apply'),
})
