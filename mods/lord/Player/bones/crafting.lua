core.register_craft({
	output = 'bones:bone 9',
	recipe = {
		{'group:corpse'},
	}
})

core.register_craft({
	type = "cooking",
	output = "bones:bonedust",
	recipe = "bones:bone",
})

core.register_craft({
	output = 'bones:bone_scythe',
	recipe = {
		{'bones:bone', 'bones:bone', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick',''},
	}
})

core.register_craft({
	output = 'bones:skeleton_body',
	recipe = {
		{'bones:bone', 'bones:bone', 'bones:bone'},
		{'bones:bone', 'bones:bone', 'bones:bone'},
		{'bones:bone', 'bones:bone', 'bones:bone'},
	}
})

core.register_craft({
	output = 'bones:bone 9',
	recipe = {
		{'bones:skeleton_body'},
	}
})
