
local S = minetest.get_translator("lord_default")


minetest.register_craftitem(":default:scorched_stuff", {
	description = S("Scorched Stuff"),
	inventory_image = "default_scorched_stuff.png",
})


----------------------------------
--- Charcoal / Древесный уголь ---
----------------------------------
minetest.register_craftitem(":default:charcoal_lump", {
	description = S("Charcoal Lump"),
	inventory_image = "charcoal_lump.png",
	groups = {coal = 1},
})

minetest.register_node(":default:charcoalblock", {
	description       = S("Charcoal Block"),
	tiles             = { "default_charcoal_block.png" },
	is_ground_content = true,
	groups            = { cracky = 3, flammable = 10 },
	sounds            = default.node_sound_stone_defaults(),
	on_punch          = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:torch" then
			local pos_above = { x = pos.x, y = pos.y + 1, z = pos.z }
			if minetest.get_node(pos_above).name == "air" then
				minetest.set_node(pos_above, { name = "fire:basic_flame" })
			end
		end
	end,
})

minetest.register_craft({
	output = "default:charcoalblock",
	recipe = {
		{"default:charcoal_lump", "default:charcoal_lump", "default:charcoal_lump"},
		{"default:charcoal_lump", "default:charcoal_lump", "default:charcoal_lump"},
		{"default:charcoal_lump", "default:charcoal_lump", "default:charcoal_lump"},
	}
})
minetest.register_craft({
	output = "default:charcoal_lump 9",
	recipe = {
		{"default:charcoalblock"},
	}
})

-- Time of burn:
minetest.register_craft({
	type = "fuel",
	recipe = "default:charcoalblock",
	burntime = 280,
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:charcoal_lump",
	burntime = 30,
})

-- Lump cooking:
minetest.register_craft({
	type = "cooking",
	output = "default:charcoal_lump 3",
	recipe = "group:tree",
})

minetest.register_craft({
	type = "cooking",
	output = "default:charcoal_lump 2",
	recipe = "group:wood",
})

minetest.register_craft({
	type = "cooking",
	output = "default:charcoal_lump",
	recipe = "group:wooden",
})
