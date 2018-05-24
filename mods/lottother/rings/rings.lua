local SL = lord.require_intllib()

--ELF RINGS
--FUNCTION = Sets your health to max every 10 seconds.

minetest.register_craftitem("lottother:vilya_new", {
	description = minetest.colorize("skyblue", SL("Vilya\nElven Ring of Power")) ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_vilya.png",
	groups = {forbidden=1},
	stack_max = 1,
})
local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 10 then
		time = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:vilya"
			and player:get_hp() < 19 then
				player:set_hp(20)
			end
		end
	end
end)

--FUNCTION = Makes (good) mobs follow you.

minetest.register_craftitem("lottother:narya_new", {
	description = minetest.colorize("crimson", SL("Narya\nElven Ring of Power")) ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_narya.png",
	groups = {forbidden=1},
	stack_max = 1,
})
--In mob def:
--follow = "lottother:narya",

--FUNCTION = Same armor stats as a full set of mithril.

minetest.register_tool("lottother:nenya_new", {
	description = minetest.colorize("silver", "Nenya\nElven Ring of Power") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_nenya_inv.png",
	stack_max = 1,
	groups = {armor_shield=90,forbidden=1},
	wear = 0,
})

--------------------------------------------------------

--Dwarf Ring:

minetest.register_craftitem("lottother:dwarf_ring_new", {
	description = minetest.colorize("darkviolet", SL("Dragakoo\nDwarvern Ring of Power")) ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_dwarf_ring.png",
	stack_max = 1,
	groups = {forbidden=1},
})

--Dwarf ring crafts...
minetest.register_craft({
	type = "shapeless",
	output = "lottores:silver_ingot 2",
	recipe = {"lottores:silver_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:tin_ingot 2",
	recipe = {"lottores:tin_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:lead_ingot 2",
	recipe = {"lottores:lead_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:steel_ingot 2",
	recipe = {"default:iron_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:copper_ingot 2",
	recipe = {"default:copper_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:gold_ingot 2",
	recipe = {"default:gold_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

--Beast Ring
minetest.register_craftitem("lottother:beast_ring_new", {
	description = minetest.colorize("goldenrod", SL("Suotty\nHuman Ring of Power")) ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_beast_ring.png",
	stack_max = 1,
	groups = {forbidden=1},
})
