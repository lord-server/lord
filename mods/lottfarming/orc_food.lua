local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:orc_food", {
	description = SL("Orc Food"),
	inventory_image = "lottfarming_orc_food.png",
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		hbhunger.hunger[name] = 20
		hbhunger.set_hunger_raw(user)
		local first_screen = user:hud_add({
			hud_elem_type = "image",
			position = {x=0, y=0},
			scale = {x=100, y=100},
			text = "orc_food.png",
			offset = {x=0, y=0},
		})
		minetest.after(10, function()
			user:hud_remove(first_screen)
			local second_screen = user:hud_add({
				hud_elem_type = "image",
				position = {x=0.5, y=0.5},
				scale = {x=-100, y=-100},
				text = "orc_food1.png",
				offset = {x=0, y=0},
			})
			minetest.after(10, function()
				user:hud_remove(second_screen)
			end)
		end)
		itemstack:take_item(1)
		local inv = user:get_inventory()
		if inv:room_for_item("main", "lottfarming:bowl") then
			inv:add_item("main", "lottfarming:bowl")
		else
			minetest.item_drop(ItemStack("lottfarming:bowl"), user, user:getpos())
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = "lottfarming:orc_food 4",
	recipe = {
		{"default:dirt", "lottfarming:potato_cooked", "default:dirt"},
		{"lottmobs:rotten_meat", "farming:bread", "lottmobs:rotten_meat"},
		{"default:dirt", "default:dirt", "default:dirt"},
	}
})

minetest.register_craftitem("lottfarming:orc_medicine", {
	description = SL("Orc medicine"),
	inventory_image = "lottfarming_orc_medicine.png",
	on_use = function(itemstack, user, pointed_thing)
		user:set_hp(20)
		local first_screen = user:hud_add({
			hud_elem_type = "image",
			position = {x=0, y=0},
			scale = {x=100, y=100},
			text = "orc_medicine.png",
			offset = {x=0, y=0},
		})
		minetest.after(10, function()
			user:hud_remove(first_screen)
			local second_screen = user:hud_add({
				hud_elem_type = "image",
				position = {x=0.5, y=0.5},
				scale = {x=-100, y=-100},
				text = "orc_medicine1.png",
				offset = {x=0, y=0},
			})
			minetest.after(10, function()
				user:hud_remove(second_screen)
			end)
		end)
		itemstack:take_item(1)
		local inv = user:get_inventory()
		if inv:room_for_item("main", "vessels:drinking_glass") then
			inv:add_item("main", "vessels:drinking_glass")
		else
			minetest.item_drop(ItemStack("vessels:drinking_glass"), user, user:getpos())
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = "lottfarming:orc_medicine",
	recipe = {
		{"", "lottfarming:berries", ""},
		{"lottfarming:berries", "lottfarming:orc_food", "lottfarming:berries"},
		{"", "vessels:drinking_glass", ""},
	}
})
