local SL = lord.require_intllib()

minetest.register_craftitem("lottachievements:achievement_book", {
	description = SL("Achievements Book"),
	inventory_image = "lottachievements_achievement_book.png",
	groups = { book = 1 },
	stack_max = 1,
	on_place = function(_, player)
		local name = player:get_player_name()
		lottachievements.show_to(name, name)
	end,
	on_use = function(_, player)
		local name = player:get_player_name()
		lottachievements.show_to(name, name)
	end,
})

minetest.register_craft({
	output = 'lottachievements:achievement_book',
	recipe = {
		{ 'lottores:blue_gem', 'lottores:tilkal_ingot', 'lottother:purple_gem' },
		{ 'default:mese_crystal', 'default:book', 'default:diamond' },
		{ 'lottores:white_gem', 'lottother:ringsilver_ingot', 'lottores:red_gem' },
	}
})
