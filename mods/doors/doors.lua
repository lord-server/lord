local SL = lord.require_intllib()

doors.register_door("doors:door_wood", {
	description = SL("Wooden Door"),
	inventory_image = "doors_wood.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1,wooden=1},
	tiles_bottom = {"doors_wood_b.png", "doors_brown.png"},
	tiles_top = {"doors_wood_a.png", "doors_brown.png"},
	sounds = default.node_sound_wood_defaults(),
	sunlight = true,
})

minetest.register_craft({
	output = "doors:door_wood",
	recipe = {
		{"default:wood", "default:wood"},
		{"default:wood", "default:wood"},
		{"default:wood", "default:wood"}
	}
})

doors.register_door("doors:door_wood_lock", {
	description = SL("Wooden Door With Lock"),
	inventory_image = "doors_wood.png^doors_lock.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1,wooden=1},
	tiles_bottom = {"doors_wood_b.png", "doors_brown.png"},
	tiles_top = {"doors_wood_a.png", "doors_brown.png"},
	sounds = default.node_sound_wood_defaults(),
	sunlight = true,
	only_placer_can_open = true,
})

minetest.register_craft({
	output = "doors:door_wood_lock",
	recipe = {
		{"doors:door_wood", "default:steel_ingot"}
	}
})


doors.register_door("doors:door_steel", {
	description = SL("Steel Door"),
	inventory_image = "doors_steel.png",
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2,door=1, steel_item=1},
	tiles_bottom = {"doors_steel_b.png", "doors_grey.png"},
	tiles_top = {"doors_steel_a.png", "doors_grey.png"},
	sounds = default.node_sound_wood_defaults(),
	sunlight = true,
})

minetest.register_craft({
	output = "doors:door_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot"}
	}
})

doors.register_door("doors:door_steel_lock", {
	description = SL("Steel Door With Lock"),
	inventory_image = "doors_steel.png^doors_lock.png",
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2,door=1, steel_item=1},
	tiles_bottom = {"doors_steel_b.png", "doors_grey.png"},
	tiles_top = {"doors_steel_a.png", "doors_grey.png"},
	sounds = default.node_sound_wood_defaults(),
	sunlight = true,
	only_placer_can_open = true,
})

minetest.register_craft({
	output = "doors:door_steel_lock",
	recipe = {
		{"doors:door_steel", "default:steel_ingot"}
	}
})


doors.register_door("doors:door_glass", {
	description = SL("Glass Door"),
	inventory_image = "doors_glass.png",
	groups = {snappy=1,cracky=1,oddly_breakable_by_hand=3,door=1},
	tiles_bottom = {"doors_glass_b.png", "doors_glass_side.png"},
	tiles_top = {"doors_glass_a.png", "doors_glass_side.png"},
	sounds = default.node_sound_glass_defaults(),
	sunlight = true,
})

minetest.register_craft({
	output = "doors:door_glass",
	recipe = {
		{"default:glass", "default:glass"},
		{"default:glass", "default:glass"},
		{"default:glass", "default:glass"}
	}
})

doors.register_door("doors:door_glass_lock", {
	description = SL("Glass Door With Lock"),
	inventory_image = "doors_glass.png^doors_lock.png",
	groups = {snappy=1,cracky=1,oddly_breakable_by_hand=3,door=1},
	tiles_bottom = {"doors_glass_b.png", "doors_glass_side.png"},
	tiles_top = {"doors_glass_a.png", "doors_glass_side.png"},
	sounds = default.node_sound_glass_defaults(),
	sunlight = true,
	only_placer_can_open = true,
})

minetest.register_craft({
	output = "doors:door_glass_lock",
	recipe = {
		{"doors:door_glass", "default:steel_ingot"}
	}
})


doors.register_door("doors:door_obsidian_glass", {
	description = SL("Obsidian Glass Door"),
	inventory_image = "doors_obsidian_glass.png",
	groups = {snappy=1,cracky=1,oddly_breakable_by_hand=3,door=1},
	tiles_bottom = {"doors_obsidian_glass_b.png", "doors_obsidian_glass_side.png"},
	tiles_top = {"doors_obsidian_glass_a.png", "doors_obsidian_glass_side.png"},
	sounds = default.node_sound_glass_defaults(),
	sunlight = true,
})

minetest.register_craft({
	output = "doors:door_obsidian_glass",
	recipe = {
		{"default:obsidian_glass", "default:obsidian_glass"},
		{"default:obsidian_glass", "default:obsidian_glass"},
		{"default:obsidian_glass", "default:obsidian_glass"}
	}
})

doors.register_door("doors:door_obsidian_glass_lock", {
	description = SL("Obsidian Glass Door With Lock"),
	inventory_image = "doors_obsidian_glass.png^doors_lock.png",
	groups = {snappy=1,cracky=1,oddly_breakable_by_hand=3,door=1},
	tiles_bottom = {"doors_obsidian_glass_b.png", "doors_obsidian_glass_side.png"},
	tiles_top = {"doors_obsidian_glass_a.png", "doors_obsidian_glass_side.png"},
	sounds = default.node_sound_glass_defaults(),
	sunlight = true,
	only_placer_can_open = true,
})

minetest.register_craft({
	output = "doors:door_obsidian_glass_lock",
	recipe = {
		{"doors:door_obsidian_glass", "default:steel_ingot"}
	}
})
