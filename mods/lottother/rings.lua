local SL = lord.require_intllib()

local DWARF_RING_USES = 400

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
	description = minetest.colorize("silver", SL("Nenya\nElven Ring of Power")) ..
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
		replacements = {{ "lottother:dwarf_ring_new", "lottother:dwarf_ring_new"}},
	})
end

--Beast Ring
minetest.register_craftitem("lottother:beast_ring_new", {
	description = minetest.colorize("goldenrod", SL("Suotty\nBeast Ring of Power")) ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_beast_ring.png",
	stack_max = 1,
	groups = {forbidden=1},
})

-- Dragakoo wearing
minetest.register_on_craft(function(is, player, old_grid, inv)
	local has_ring = inv:contains_item("craft", ItemStack("lottother:dwarf_ring_new"))
	local ring_itemstack
	local ring_index
	local lump

	if has_ring then
		for i, itemstack in ipairs(old_grid) do
			local name = itemstack:to_string()
			-- We know that there's an ore
			if not starts_with(name, "lottother:dwarf_ring_new") and name ~= "" then
				lump_name, trash = name:match("([%w:_]+)(.*)")
				lump = lump_name
			elseif starts_with(name, "lottother:dwarf_ring_new") then
				ring_itemstack = itemstack
				ring_index = i
			end
		end
		print(lump)
		ring_itemstack:add_wear(65535/(DWARF_RING_USES / lumps[lump] - 1))
		inv:set_stack("craft", ring_index, ring_itemstack)
	end
end)
