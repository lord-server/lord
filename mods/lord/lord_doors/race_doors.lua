local S = minetest.get_translator("lord_doors")


--- Обработчик on_rightclick для расовых дверей.
---@param owner_race string @раса, которая может открывать эти двери.
---@param pos table
---@param node any @FIXME: нечто неизвестное
---@param clicker Player
---@param itemstack ItemStack
local function race_door_on_rightclick_wrapper(owner_race, pos, node, clicker, itemstack)
	local player = clicker:get_player_name()
	local opened, failed_race = races.can_open_stuff(owner_race, player, itemstack)
	if opened then
		doors.door_toggle(pos, node, clicker)
	elseif failed_race ~= nil then
		minetest.chat_send_player(player, S("This door can only be opened by @1!", failed_race))
	end
end

doors.register("lord_doors:door_dwarf", {
	description = S("Dwarf Door"),
	inventory_image = "lord_doors_item_dwarf.png",
	groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1, },
	tiles = {{ name = "lord_doors_dwarf.png", backface_culling = true }},
	recipe = {
		{"default:stone", "default:stone"},
		{"default:stone", "lottores:silver_ingot"},
		{"default:stone", "default:stone"},
	},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(...)
		race_door_on_rightclick_wrapper("dwarf", ...)
	end,
})

doors.register("lord_doors:door_elven", {
	description = S("Elven Door"),
	inventory_image = "lord_doors_item_elven.png",
	groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1, },
	tiles = {{ name = "lord_doors_elven.png", backface_culling = true }},
	recipe = {
		{"lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottores:silver_ingot"},
		{"lottplants:mallornwood", "lottplants:mallornwood"},
	},
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(...)
		race_door_on_rightclick_wrapper("elf", ...)
	end,
})

doors.register("lord_doors:door_hobbit", {
	description = S("Hobbit Door"),
	inventory_image = "lord_doors_item_hobbit.png",
	groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1, },
	tiles = {{ name = "lord_doors_hobbit.png", backface_culling = true }},
	recipe = {
		{"lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottores:silver_ingot"},
		{"lottplants:birchwood", "lottplants:birchwood"},
	},
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(...)
		race_door_on_rightclick_wrapper("hobbit", ...)
	end,
})

doors.register("lord_doors:door_orc", {
	description = S("Orc Door"),
	inventory_image = "lord_doors_item_orc.png",
	groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1, },
	tiles = {{ name = "lord_doors_orc.png", backface_culling = true }},
	recipe = {
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "lottores:silver_ingot"},
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
	},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(...)
		race_door_on_rightclick_wrapper("orc", ...)
	end,
})

doors.register("lord_doors:door_human", {
	description = S("Human Door"),
	inventory_image = "lord_doors_item_human.png",
	groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1, },
	tiles = {{ name = "lord_doors_human.png", backface_culling = true }},
	recipe = {
		{"lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottores:silver_ingot"},
		{"lottplants:alderwood", "lottplants:alderwood"},
	},
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(...)
		race_door_on_rightclick_wrapper("man", ...)
	end,
})
