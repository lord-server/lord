local S = lottfarming.get_translator

minetest.register_craftitem("lottfarming:orc_food", {
	description = S("Orc Food"),
	inventory_image = "lottfarming_orc_food.png",
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		if minetest.is_creative_enabled(name) ~= true then
			itemstack:take_item()
		end
		hbhunger.hunger[name] = 20
		hbhunger.set_hunger_raw(user)
		if not races.get_race(name) then
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
		end
		return itemstack
	end,
})

minetest.register_craftitem("lottfarming:orc_medicine", {
	description = S("Orc Medicine"),
	inventory_image = "lottfarming_orc_medicine.png",
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		if minetest.is_creative_enabled(name) ~= true then
			itemstack:take_item()
		end
		user:set_hp(20)
		if not races.get_race(name) then
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
		end
		return itemstack
	end,
})
