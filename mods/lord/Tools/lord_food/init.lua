
-- As for now, this mod extremely small
-- So, it not follow mod structure convention
minetest.mod(function(mod)
	local S = mod.translator

	-- Lembas (no craft)
	minetest.register_craftitem('lord_food:lembas', {
		description     = S('Lembas'),
		inventory_image = 'lord_food_lembas.png',
		groups          = { food_bread = 1 },
		on_use          = minetest.item_eat(30),
		_tt_food_hp     = 30,
	})

	-- Pancakes
	minetest.register_craftitem('lord_food:pancakes', {
		description     = S('Pancakes'),
		inventory_image = 'lord_food_pancakes.png',
		on_use          = minetest.item_eat(24),
		_tt_food_hp     = 24,
	})
	minetest.register_craft({
		type   = 'shapeless',
		recipe = {
			'lord_vessels:glass_bottle_water',
			'farming:flour',
			'lottmobs:egg',
			'bees:bottle_honey',
		},
		output = 'lord_food:pancakes',
	})
end)
