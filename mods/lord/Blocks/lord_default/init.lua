
local S = core.get_mod_translator()


core.register_craftitem(":default:scorched_stuff", {
	description = S("Scorched Stuff"),
	inventory_image = "default_scorched_stuff.png",
})

--- Use as `on_punch` callback. Fires node by punching with torch.
--- @param pos           Position      punched `node` position
--- @param node          NodeTable     punched `node` NodeTable
--- @param puncher       Player        who punched the `node`
--- @param pointed_thing pointed_thing params on which node "cursor" is pointed now
local function fire_by_torch_punch(pos, node, puncher, pointed_thing)
	if puncher:get_wielded_item():get_name() == "default:torch" then
		local pos_above = { x = pos.x, y = pos.y + 1, z = pos.z }
		if core.get_node(pos_above).name == "air" then
			-- When there is no delay, the player has time to hit the newly appeared fire and put it out
			-- Когда нет задержки, игрок успевает ударить и по вновь появившемуся костру и потушить его
			core.after(0.25, function()
				core.set_node(pos_above, { name = "fire:basic_flame" })
			end)
		end
	end
	core.node_punch(pos, node, puncher, pointed_thing)
end

-- Поджигание блока угля (каменного) факелом
core.override_item("default:coalblock", {
	on_punch = fire_by_torch_punch,
	_tt_help = S("Ignited by a torch"),
})

----------------------------------
--- Charcoal / Древесный уголь ---
----------------------------------
core.register_craftitem(":default:charcoal_lump", {
	description = S("Charcoal Lump"),
	inventory_image = "charcoal_lump.png",
	groups = {coal = 1},
})

core.register_node(":default:charcoalblock", {
	description       = S("Charcoal Block"),
	tiles             = { "default_charcoal_block.png" },
	is_ground_content = false,
	groups            = { cracky = 3, flammable = 10 },
	sounds            = default.node_sound_stone_defaults(),
	on_punch          = fire_by_torch_punch,
	_tt_help          = S("Ignited by a torch"),
})

core.register_craft({
	output = "default:charcoalblock",
	recipe = {
		{"default:charcoal_lump", "default:charcoal_lump", "default:charcoal_lump"},
		{"default:charcoal_lump", "default:charcoal_lump", "default:charcoal_lump"},
		{"default:charcoal_lump", "default:charcoal_lump", "default:charcoal_lump"},
	}
})
core.register_craft({
	output = "default:charcoal_lump 9",
	recipe = {
		{"default:charcoalblock"},
	}
})

-- Time of burn:
core.register_craft({
	type = "fuel",
	recipe = "default:charcoalblock",
	burntime = 280,
})
core.register_craft({
	type = "fuel",
	recipe = "default:charcoal_lump",
	burntime = 30,
})

-- Lump cooking:
core.register_craft({
	type = "cooking",
	output = "default:charcoal_lump 3",
	recipe = "group:tree",
})

core.register_craft({
	type = "cooking",
	output = "default:charcoal_lump 1",
	recipe = "group:wood",
})

core.register_craft({
	type = "cooking",
	output = "default:charcoal_lump",
	recipe = "group:wooden",
})

core.register_craft({
	output = "default:torch 2",
	recipe = {
		{"default:charcoal_lump"},
		{"group:stick"},
	}
})

----------------------------------
---      Stone-like nodes      ---
----------------------------------
core.register_node(":default:desert_gravel", {
	description = S("Desert Gravel"),
	tiles = {"default_desert_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"default:flint"}, rarity = 16},
			{items = {"default:desert_gravel"}}
		}
	}
})

----------------------------------------------------------
--- Our Additional Crafts / наши дополнительные крафты ---
----------------------------------------------------------
core.register_craft({
	type = "cooking",
	output = "default:cobble",
	recipe = "default:gravel",
})
core.register_craft({
	type = "cooking",
	output = "default:desert_cobble",
	recipe = "default:desert_gravel",
})
core.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "group:steel_item",
})
core.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "group:copper_item",
})
core.register_craft({
	type = "cooking",
	output = "default:bronze_ingot",
	recipe = "group:bronze_item",
})
core.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "group:gold_item",
})
