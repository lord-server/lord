
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
--[[
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
]]--

	-- Furnance-backed pancakes
	minetest.register_craftitem('lord_food:pancakes', {
		description     = S('Pancakes'),
		inventory_image = 'lord_food_pancakes.png',
		on_use          = minetest.item_eat(14),
		_tt_food_hp     = 14,
	})

	minetest.register_craft({
		type = 'cooking',
		cooktime = 15,
		recipe = 'lottfarming:dough_with_egg',
		output = 'lord_food:pancakes',
	})

	-- Pancakes with honey
	minetest.register_craftitem('lord_food:pancakes_with_honey', {
		description     = S('Pancakes with honey'),
		inventory_image = 'lord_food_pancakes_with_honey.png',
		on_use          = minetest.item_eat(25),
		_tt_food_hp     = 25,
	})
	minetest.register_craft({
		type   = 'shapeless',
		output = 'lord_food:pancakes_with_honey 2',
		recipe = {
			'lord_food:pancakes',
			'lord_food:pancakes',
			'bees:bottle_honey',
		},

	})
end)
