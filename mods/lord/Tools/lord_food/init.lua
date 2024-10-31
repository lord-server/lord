
-- As for now, this mod extremely small
-- So, it not follow mod structure convention
minetest.mod(function(mod)
	local S = mod.translator

	minetest.register_craftitem("lord_food:lembas", {
		description     = S("Lembas"),
		inventory_image = "lord_food_lembas.png",
		groups          = { food_bread = 1 },
		on_use          = minetest.item_eat(30),
		_tt_food_hp     = 30,
	})
end)
