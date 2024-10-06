local S = minetest.get_translator("lord_ores")


for name, registration in pairs(rocks.get_lord_nodes()) do
	local stripped_name = name:replace("lord_rocks:", "")
	local rock_texture       = minetest.registered_nodes[name].tiles[1]

	-- MTG ores

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_coal", {
		description = S("Coal Ore"),
		tiles       = { rock_texture .. "^default_mineral_coal.png" },
		groups      = { cracky = 3 },
		drop        = "default:coal_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_iron", {
		description = S("Iron Ore"),
		tiles       = { rock_texture .. "^default_mineral_iron.png" },
		groups      = { cracky = 2 },
		drop        = "default:iron_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_copper", {
		description = S("Copper Ore"),
		tiles       = { rock_texture .. "^default_mineral_copper.png" },
		groups      = { cracky = 2 },
		drop        = "default:copper_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_mese", {
		description = S("Mese Ore"),
		tiles       = { rock_texture .. "^default_mineral_mese.png" },
		groups      = { cracky = 1 },
		drop        = "default:mese_crystal",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_gold", {
		description = S("Gold Ore"),
		tiles       = { rock_texture .. "^default_mineral_gold.png" },
		groups      = { cracky = 2 },
		drop        = "default:gold_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_diamond", {
		description = S("Diamond Ore"),
		tiles       = { rock_texture .. "^default_mineral_diamond.png" },
		groups      = { cracky = 1 },
		drop        = "default:diamond",
		sounds      = default.node_sound_stone_defaults(),
	})


	-- lottores

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_silver", {
		description = S("Silver Ore"),
		tiles       = { rock_texture .. "^lottores_silver_ore.png" },
		groups      = { cracky = 2 },
		drop        = "lottores:silver_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_tin", {
		description = S("Tin Ore"),
		tiles       = { rock_texture .. "^lottores_tin_ore.png" },
		groups      = { cracky = 3 },
		drop        = "lottores:tin_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_lead", {
		description = S("Lead Ore"),
		tiles       = { rock_texture .. "^lottores_lead_ore.png" },
		groups      = { cracky = 2 },
		drop        = "lottores:lead_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_mithril", {
		description = S("Mithril Ore"),
		tiles       = { rock_texture .. "^lottores_mithril_ore.png" },
		groups      = { cracky = 1 },
		drop        = "lottores:mithril_lump",
		sounds      = default.node_sound_stone_defaults(),
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_blue_gem", {
		description = S("Blue Gem Ore"),
		tiles       = { rock_texture .. "^lottores_bluegem_ore.png" },
		groups      = { cracky = 1 },
		sounds      = default.node_sound_stone_defaults(),
		drop        = {
			items = {
				{
					items = {'lottores:blue_gem'},
					rarity = 5,
				},
				{
					items = {''},
				}
			}
		},
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_white_gem", {
		description = S("White Gem Ore"),
		tiles       = { rock_texture .. "^lottores_whitegem_ore.png" },
		groups      = { cracky = 1 },
		sounds      = default.node_sound_stone_defaults(),
		drop        = {
			items = {
				{
					items = {'lottores:white_gem'},
					rarity = 5,
				},
				{
					items = {''},
				}
			}
		},
	})

	minetest.register_node("lord_ores:" .. stripped_name .. "_with_red_gem", {
		description = S("Red Gem Ore"),
		tiles       = { rock_texture .. "^lottores_redgem_ore.png" },
		groups      = { cracky = 1 },
		sounds      = default.node_sound_stone_defaults(),
		drop        = {
			items = {
				{
					items = {'lottores:red_gem'},
					rarity = 5,
				},
				{
					items = {''},
				}
			}
		},
	})
end
