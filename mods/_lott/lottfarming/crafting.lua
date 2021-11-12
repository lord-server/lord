<<<<<<< HEAD
local S = lottfarming.get_translator

=======
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
-- ITEMS and TOOLS

minetest.register_craft({
	output = "lottfarming:bowl",
	recipe = {
<<<<<<< HEAD
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""},
=======
		{"default:wood", "", "default:wood"},
		{"", "default:wood", ""},
		{"", "", ""},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	}
})

minetest.register_craftitem("lottfarming:bowl", {
<<<<<<< HEAD
	description = S("Bowl"),
=======
	description = "Bowl",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	inventory_image = "lottfarming_bowl.png",
})

minetest.register_node("lottfarming:decay_tree", {
<<<<<<< HEAD
	description = S("Decaying Wood"),
=======
	description = "Decaying Wood",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	tiles = {'default_tree_top.png^lottfarming_decay_tree.png', 'default_tree.png', 	'default_tree.png'},
    is_ground_content = true,
	groups = {crumbly = 3, fungi = 3},
	sounds = default.node_sound_dirt_defaults(),
	drop = "default:dirt",
})

<<<<<<< HEAD
local function decaying_wood(pos, _, _)
=======
local function decaying_wood(pos, inv, p)
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	if pos == nil then
		return false
	end
	local node = minetest.get_node(pos)
	local name = node.name
	local above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
<<<<<<< HEAD
	if (name == "default:tree") or (name == "default:jungletree")
	or (name == "default:tree_trunk") or (name == "default:jungletree_trunk") then
=======
	if name == "default:tree" or name == "default:jungletree" then
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
		if above.name == "air" then
			node.name = "lottfarming:decay_tree"
			minetest.set_node(pos, node)
			return true
		end
	end
	return false
end

<<<<<<< HEAD
local function growgen(pos)
	if pos == nil then
		return false
	end
	local name = minetest.get_node(pos).name
	local next_plant = minetest.registered_nodes[name].next_plant
	if next_plant then
		farming.grow_plant(pos)
<<<<<<< HEAD
		return true
	end
	return nil
=======
	end
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
end

minetest.register_tool("lottfarming:bacteria_fertiliser", {
	description = S("Bacteria Fertiliser"),
	inventory_image = "vessels_glass_bottle_inv.png^lottfarming_bacteria_fertiliser.png",
	on_use = function(itemstack, _, pointed_thing)
		if decaying_wood(pointed_thing.under) or growgen(pointed_thing.under) then
<<<<<<< HEAD
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65536/50)
			end
=======
			itemstack:add_wear(65535/80)
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
=======
minetest.register_tool("lottfarming:bacteria_fertiliser", {
	description = "Bacteria Fertiliser",
	inventory_image = "lottfarming_bacteria_fertiliser.png",
	on_use = function(itemstack, user, pointed_thing)
		if decaying_wood(pointed_thing.under, user:get_inventory(), 10) then
			itemstack:add_wear(65535/80)
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
			return itemstack
		end
	end
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:bacteria_fertiliser",
<<<<<<< HEAD
	recipe = {"lottpotion:glass_bottle_water", "bones:bonedust"}
=======
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "bones:bones", "default:glass"},
		{"default:glass", "default:glass", "default:glass"},
	}
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
})

minetest.register_craft({
	output = 'lottfarming:pipe',
	recipe = {
		{'', '', 'group:stick'},
		{'group:wood', 'group:stick', ''},
		{'group:stick', '', ''},
	}
})

-- SOUPS and SALADS

minetest.register_craft({
	output = 'lottfarming:mushroom_soup',
	recipe = {
		{'group:mushroom', 'group:mushroom', 'group:mushroom'},
		{'', 'lottfarming:bowl', ''},
	}
})

minetest.register_craft({
	output = 'lottfarming:salad',
	recipe = {
		{'group:salad', 'group:salad', 'group:salad'},
		{'', 'lottfarming:bowl', ''},
	}
})

minetest.register_craft({
	output = 'lottfarming:tomato_soup',
	recipe = {
		{'lottfarming:tomato_cooked', 'lottfarming:tomato_cooked', 'lottfarming:tomato_cooked'},
		{'', 'lottfarming:bowl', ''},
	}
})

-- SEEDS

minetest.register_craft({
	output = 'lottfarming:athelas_seed 2',
	recipe = {
		{'lottfarming:athelas'},
	}
})

minetest.register_craft({
	output = 'lottfarming:barley_seed 2',
	recipe = {
		{'lottfarming:barley'},
	}
})

minetest.register_craft({
	output = 'lottfarming:berries_seed 2',
	recipe = {
		{'lottfarming:berries'},
	}
})

minetest.register_craft({
	output = 'lottfarming:cabbage_seed 2',
	recipe = {
		{'lottfarming:cabbage'},
	}
})

minetest.register_craft({
<<<<<<< HEAD
	output = 'lottfarming:corn_kernel 2',
=======
	output = 'lottfarming:corn_seed 2',
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	recipe = {
		{'lottfarming:corn'},
	}
})

minetest.register_craft({
	output = 'lottfarming:carrot_seed 2',
	recipe = {
		{'lottfarming:carrot'},
	}
})

minetest.register_craft({
	output = 'lottfarming:tomato_seed 2',
	recipe = {
		{'lottfarming:tomato'},
	}
})

minetest.register_craft({
	output = 'lottfarming:melon_seed 2',
	recipe = {
		{'lottfarming:melon'},
	}
})

minetest.register_craft({
<<<<<<< HEAD
	output = 'lottfarming:half_of_potato 2',
=======
	output = 'lottfarming:potato_seed 2',
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	recipe = {
		{'lottfarming:potato'},
	}
})

minetest.register_craft({
	output = 'lottfarming:pipeweed_seed 2',
	recipe = {
		{'lottfarming:pipeweed'},
	}
})
minetest.register_craft({
	output = 'lottfarming:turnip_seed 2',
	recipe = {
		{'lottfarming:turnip'},
	}
})

-- FOOD

minetest.register_craft({
<<<<<<< HEAD
	output = 'lottfarming:melon 9',
	recipe = {{'lottfarming:melon_3'}},
})

-- ORC

minetest.register_craft({
	output = "lottfarming:orc_food 4",
	recipe = {
		{"default:dirt", "lottfarming:potato_cooked", "default:dirt"},
		{"lottmobs:rotten_meat", "farming:bread", "lottmobs:rotten_meat"},
		{"default:dirt", "default:dirt", "default:dirt"},
	}
})

minetest.register_craft({
	output = "lottfarming:orc_medicine",
	recipe = {
		{"", "lottfarming:berries", ""},
		{"lottfarming:berries", "lottfarming:orc_food", "lottfarming:berries"},
		{"", "vessels:drinking_glass", ""},
	}
})

-- COOKING
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:barley_cooked",
	recipe = "lottfarming:sheaf_barley"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:pipeweed_cooked",
	recipe = "lottfarming:pipeweed"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:potato_cooked",
	recipe = "lottfarming:potato"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:tomato_cooked",
	recipe = "lottfarming:tomato"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:turnip_cooked",
	recipe = "lottfarming:turnip"
=======
	output = 'lottfarming:melon',
	recipe = {
		{'lottfarming:melon_slice', 'lottfarming:melon_slice', 'lottfarming:melon_slice'},
		{'lottfarming:melon_slice', 'lottfarming:melon_slice', 'lottfarming:melon_slice'},
		{'lottfarming:melon_slice', 'lottfarming:melon_slice', 'lottfarming:melon_slice'},
	}
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
})
