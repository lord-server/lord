local SL = lord.require_intllib()

-- Register Protected Doors

local function reg_prot_door(desc, name, door, mat, texture, texture_i)
	local gd
	if mat == "wood" then
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1, wooden = 1}
	elseif mat == "steel" then
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1, steel_item = 1}
	else
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1}
	end

	doors.register(name, {
		tiles = {{ name = texture.."^protector_logo_door_overlay.png", backface_culling = true }},
		description = SL(desc),
		inventory_image = texture_i.."^protector_logo_i.png",
		groups = gd,
		sounds = default.node_sound_wood_defaults(),
		sunlight = true,
		protected = true,
	})

	minetest.register_craft({
		output = name,
		recipe = {
			{door, "protector_lott:protect2"}
		}
	})
end

-- from doors mod
reg_prot_door(
	"Protected Wooden Door", "protector_lott:door_wood", "doors:door_wood", "wood",
	"doors_door_wood.png",
	"doors_item_wood.png"
)

reg_prot_door(
	"Protected Steel Door", "protector_lott:door_steel", "doors:door_steel", "steel",
	"doors_door_steel.png",
	"doors_item_steel.png"
)

reg_prot_door(
	"Protected Glass Door", "protector_lott:door_glass", "doors:door_glass", "glass",
	"doors_door_glass.png",
	"doors_item_glass.png"
)

reg_prot_door(
	"Protected Obsidian Glass Door", "protector_lott:door_obsidian_glass", "doors:door_obsidian_glass", "glass",
	"doors_door_obsidian_glass.png",
	"doors_item_obsidian_glass.png"
)

-- from lottblocks mod
reg_prot_door(
	"Protected Junglewood Door", "protector_lott:door_junglewood", "lottblocks:door_junglewood", "wood",
	"lottblocks_door_junglewood.png",
	"lottblocks_door_junglewood_inv.png"
)

reg_prot_door(
	"Protected Alder Door", "protector_lott:door_alder", "lottblocks:door_alder", "wood",
	"lottblocks_door_alder.png",
	"lottblocks_door_alder_inv.png"
)

reg_prot_door(
	"Protected Birch Door", "protector_lott:door_birch", "lottblocks:door_birch", "wood",
	"lottblocks_door_birch.png",
	"lottblocks_door_birch_inv.png"
)

reg_prot_door(
	"Protected Pine Door", "protector_lott:door_pine", "lottblocks:door_pine", "wood",
	"lottblocks_door_pine.png",
	"lottblocks_door_pine_inv.png"
)

reg_prot_door(
	"Protected Lebethron Door", "protector_lott:door_lebethron", "lottblocks:door_lebethron", "wood",
	"lottblocks_door_lebethron.png",
	"lottblocks_door_lebethron_inv.png"
)

reg_prot_door(
	"Protected Mallorn Door", "protector_lott:door_mallorn", "lottblocks:door_mallorn", "wood",
	"lottblocks_door_mallorn.png",
	"lottblocks_door_mallorn_inv.png"
)

-- from castle mod
reg_prot_door(
	"Protected Oak Door", "protector_lott:oak_door", "castle:oak_door", "wood",
	"castle_oak_door.png",
	"castle_oak_door_inv.png"
)

reg_prot_door(
	"Protected Jail Door", "protector_lott:jail_door", "castle:jail_door", "steel",
	"castle_jail_door.png",
	"castle_jail_door_inv.png"
)
