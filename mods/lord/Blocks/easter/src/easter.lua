require('api')
--require('commands')


local eggs = {
	{"red", "#ff0000", 100, "Red Easter egg" },
	{"green", "#00ff00", 100, "Yellow Easter egg" },
	{"blue", "#0000ff", 100, "Green Easter egg"},
	{"yellow", "#ffff00", 100, "Blue Easter egg" },
}

for _, egg in ipairs(eggs) do
	
	local color_name = egg[1]
	local color_code = egg[2]
	local color_ratio = egg[3]
	local egg_description = egg[4]

	minetest.register_craftitem("easter:egg_" .. color_name, {
		description     = egg_description,
		inventory_image = "lottmobs_egg^[colorize:" .. color_code .. ":" .. color_ratio,
		on_use = function(itemstack, user, pointed_thing)
			-- Показываем форму с сообщением
			local player_name = user:get_player_name()
			local formspec = "size[5,1]" ..
							 "label[0.2,0.2; You can sell this " .. color_name:gsub("^%l", string.upper) .. " Egg!]"

			minetest.show_formspec(player_name, "your_mod:egg_message", formspec)
			return itemstack
		end,
	})
end