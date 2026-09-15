
-- As for now, this mod extremely small
-- So, it not follow mod structure convention
core.mod(function(mod)
	local S = mod.translator

	-- Lembas (no craft)
	core.register_craftitem('lord_food:lembas', {
		description     = S('Lembas'),
		inventory_image = 'lord_food_lembas.png',
		groups          = { food_bread = 1 },
		on_use          = core.item_eat(30),
		_tt_food_hp     = 30,
	})

	-- Furnance-backed pancakes
	core.register_craftitem('lord_food:pancakes', {
		description     = S('Pancakes'),
		inventory_image = 'lord_food_pancakes.png',
		on_use          = core.item_eat(14),
		_tt_food_hp     = 14,
	})

	core.register_craft({
		type = 'cooking',
		cooktime = 15,
		recipe = 'lottfarming:dough_with_egg',
		output = 'lord_food:pancakes',
	})

	-- Pancakes with honey
	core.register_craftitem('lord_food:pancakes_with_honey', {
		description     = S('Pancakes with honey'),
		inventory_image = 'lord_food_pancakes_with_honey.png',
		on_use          = core.item_eat(25),
		_tt_food_hp     = 25,
	})
	core.register_craft({
		type   = 'shapeless',
		output = 'lord_food:pancakes_with_honey 2',
		recipe = {
			'lord_food:pancakes',
			'lord_food:pancakes',
			'bees:bottle_honey',
		},
		replacements = {
			{'bees:bottle_honey', 'vessels:glass_bottle'},
		},
	})
end)
