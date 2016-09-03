local SL = lord.require_intllib()

local DWARF_RING_USES = 300

minetest.register_craftitem("lottother:ringsilver_lump", {
	description = SL("Unrefined Ring Silver"),
	inventory_image = "lottother_ringsilver_lump.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:ringsilver_ingot", {
	description = SL("Refined Ring Silver"),
	inventory_image = "lottother_ringsilver_ingot.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:ring", {
	description = SL("Plain Ring"),
	inventory_image = "lottother_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:purple_gem", {
	description = SL("Purple Gem"),
	inventory_image = "lottother_purplegem.png",
     groups = {forbidden=1},
})


--ELF RINGS
--FUNCTION = Sets your health to max every 30 seconds.
minetest.register_craftitem("lottother:blue_gem_ring", {
	description = SL("Blue Gem Ring"),
	inventory_image = "lottother_bluegem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:blue_am_ring", {
	description = SL("Blue Almost Magic Ring"),
	inventory_image = "lottother_bluegem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:vilya", {
	description = SL("Vilya"),
	inventory_image = "lottother_vilya.png",
     groups = {forbidden=1},
})
minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		if math.random() < 0.1 then
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:vilya"
			and player:get_hp() < 19 then
				player:set_hp(20)
			end

		end
	end

end)

--FUNCTION = Makes (good) mobs follow you.
minetest.register_craftitem("lottother:red_gem_ring", {
	description = SL("Red Gem Ring"),
	inventory_image = "lottother_redgem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:red_am_ring", {
	description = SL("Red Almost Magic Ring"),
	inventory_image = "lottother_redgem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:narya", {
	description = SL("Narya"),
	inventory_image = "lottother_narya.png",
     groups = {forbidden=1},
})
--follow = "lottother:narya",

--FUNCTION = Same armor stats as a full set of mithril.
minetest.register_craftitem("lottother:white_gem_ring", {
	description = SL("White Gem Ring"),
	inventory_image = "lottother_whitegem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:white_am_ring", {
	description = SL("White Almost Magic Ring"),
	inventory_image = "lottother_whitegem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_tool("lottother:nenya", {
	description = SL("Nenya"),
	inventory_image = "lottother_nenya_inv.png",
	groups = {armor_head=15, armor_torso=20, armor_legs=20, armor_feet=15, armor_shield=25,forbidden=1},
	wear = 0,
})

minetest.register_craft({
	type = "shapeless",
	output = "lottother:ringsilver_lump",
	recipe = {"lottores:mithril_lump", "default:gold_lump", "lottores:silver_lump", "lottores:silver_lump"},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:ringsilver_ingot",
	recipe = "lottother:ringsilver_lump",
	cooktime = 35,
})
minetest.register_craft({
	output = "lottother:ring",
	recipe = {
	{"lottother:ringsilver_ingot", "lottother:ringsilver_ingot", "lottother:ringsilver_ingot"},
	{"lottother:ringsilver_ingot", "", "lottother:ringsilver_ingot"},
	{"lottother:ringsilver_ingot", "lottother:ringsilver_ingot", "lottother:ringsilver_ingot"},
	},
})
minetest.register_craft({
	type = "shapeless",
	output = "lottother:purple_gem",
	recipe = {"lottores:blue_gem", "lottores:red_gem"},
})

minetest.register_craft({
	output = "lottother:blue_gem_ring",
	recipe = {
	{"lottores:blue_gem"},
	{"lottother:ring"},
	},
})
minetest.register_craft({
	output = "lottother:blue_am_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:blue_gem_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:vilya",
	recipe = "lottother:blue_am_ring",
	cooktime = 1000,
})

minetest.register_craft({
	output = "lottother:red_gem_ring",
	recipe = {
	{"lottores:red_gem"},
	{"lottother:ring"},
	},
})
minetest.register_craft({
	output = "lottother:red_am_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:red_gem_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:narya",
	recipe = "lottother:red_am_ring",
	cooktime = 1000,
})

minetest.register_craft({
	output = "lottother:white_gem_ring",
	recipe = {
	{"lottores:white_gem"},
	{"lottother:ring"},
	},
})
minetest.register_craft({
	output = "lottother:white_am_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:white_gem_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:nenya",
	recipe = "lottother:white_am_ring",
	cooktime = 1000,
})

--OTHER RINGS
--Mithril ring (base for Dwarf ring)
minetest.register_craftitem("lottother:purple_gem_ring", {
	description = SL("Purple Gem Ring"),
	inventory_image = "lottother_purplegem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:purple_gem_mithril_ring", {
	description = SL("Purple Gem Mithril Ring"),
	inventory_image = "lottother_purplegem_mithril_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("lottother:purple_am_ring", {
	description = SL("Mithril Almost Magic Ring"),
	inventory_image = "lottother_purplegem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_tool("lottother:dwarf_ring", {
	description = SL("Dwarf Ring"),
	inventory_image = "lottother_dwarf_ring.png",
	groups = {forbidden=1},
})

minetest.register_craft({
	output = "lottother:purple_gem_ring",
	recipe = {
	{"lottother:purple_gem"},
	{"lottother:ring"},
	},
})
minetest.register_craft({
	output = "lottother:purple_gem_mithril_ring",
	recipe = {
	{"lottores:mithril_ingot", "lottores:mithril_ingot", "lottores:mithril_ingot"},
	{"lottores:mithril_ingot", "lottother:purple_gem_ring", "lottores:mithril_ingot"},
	{"lottores:mithril_ingot", "lottores:mithril_ingot", "lottores:mithril_ingot"},
	},
})
minetest.register_craft({
	output = "lottother:purple_am_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:purple_gem_mithril_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:dwarf_ring",
	recipe = "lottother:purple_am_ring",
	cooktime = 1000,
})

local lumps = {
	-- ["name"] = level,
	["lottores:limestone_lump"] = 1,
	["lottores:silver_lump"] = 3,
	["lottores:tin_lump"] = 1,
	["lottores:lead_lump"] = 1,
	["default:coal_lump"] = 2,
	["default:iron_lump"] = 2,
	["default:copper_lump"] = 2,
	["default:gold_lump"] = 3,
	["lottores:rough_rock_lump"] = 1,
}

for i, j in pairs(lumps) do
	minetest.register_craft({
		type = "shapeless",
		output = i .. " 2",
		recipe = {i, "lottother:dwarf_ring"},
		replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
	})
end

local function starts_with(str, st)
	return string.sub(str, 1, string.len(st)) == st
end

-- Ring wearing
minetest.register_on_craft(function(is, player, old_grid, inv)
	local has_ring = inv:contains_item("craft", ItemStack("lottother:dwarf_ring"))
	local ring_itemstack
	local ring_index
	local lump

	if has_ring then
		for i, itemstack in ipairs(old_grid) do
			local name = itemstack:to_string()
			-- We know that there's an ore
			if not starts_with(name, "lottother:dwarf_ring") and name ~= "" then
				lump_name, trash = name:match("([%w:_]+)(.*)")
				lump = lump_name
			elseif starts_with(name, "lottother:dwarf_ring") then
				ring_itemstack = itemstack
				ring_index = i
			end
		end
		print(lump)
		ring_itemstack:add_wear(65535/(DWARF_RING_USES / lumps[lump] - 1))
		inv:set_stack("craft", ring_index, ring_itemstack)
	end
end)
