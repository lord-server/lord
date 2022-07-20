-- lord_money/money.lua

local SL = minetest.get_translator("lord_money")

minetest.register_craftitem("lord_money:diamond_coin", {
	description = SL("Diamond Coin"),
	inventory_image = "lord_money_diamond_coin.png",
	groups = {not_in_creative_inventory=1},
	stack_max = 999,
})

minetest.register_craftitem("lord_money:gold_coin", {
	description = SL("Gold Coin"),
	inventory_image = "lord_money_gold_coin.png",
	groups = {not_in_creative_inventory=1},
	stack_max = 999,
})

minetest.register_craftitem("lord_money:silver_coin", {
	description = SL("Silver Coin"),
	inventory_image = "lord_money_silver_coin.png",
	groups = {not_in_creative_inventory=1},
	stack_max = 999,
})

minetest.register_craftitem("lord_money:copper_coin", {
	description = SL("Copper Coin"),
	inventory_image = "lord_money_copper_coin.png",
	groups = {not_in_creative_inventory=1},
	stack_max = 999,
})
