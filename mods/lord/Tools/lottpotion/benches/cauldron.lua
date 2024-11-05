local SL = minetest.get_mod_translator()

minetest.register_node("lottpotion:cauldron_full",{
	drawtype="nodebox",
	description= SL("Filled Cauldron"),
	tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	use_texture_alpha = "opaque",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	legacy_facedir_simple = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375},
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375},
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5},
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5},
			{-0.375, -0.375, -0.375, 0.375, -0.3125, 0.375},
			{-0.5, -0.375, -0.375, -0.375, 0.4375, 0.375},
			{0.375, -0.375, -0.375, 0.5, 0.4375, 0.375},
			{-0.375, -0.375, 0.375, 0.375, 0.4375, 0.5},
			{-0.375, -0.375, -0.5, 0.375, 0.4375, -0.375},
			{-0.375, 0.25, -0.375, 0.375, 0.3125, 0.375},
		}
	},
	on_punch = function(pos, node, player)
		local player_inv = player:get_inventory()
		local itemstack = player:get_wielded_item()
		if itemstack:get_name() == "vessels:glass_bottle" then
			minetest.set_node(pos, {name="lottpotion:cauldron_two_third_full"})
			if player_inv:room_for_item("main", 1) then
				itemstack:take_item(1)
				player_inv:add_item("main", "lord_vessels:glass_bottle_water")
			end
			player:set_wielded_item(itemstack)
		end
	end,
})

minetest.register_node("lottpotion:cauldron_two_third_full",{
	drawtype="nodebox",
	description= SL("Two Third Filled Cauldron"),
	tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	use_texture_alpha = "opaque",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375},
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375},
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5},
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5},
			{-0.375, -0.375, -0.375, 0.375, -0.3125, 0.375},
			{-0.5, -0.375, -0.375, -0.375, 0.4375, 0.375},
			{0.375, -0.375, -0.375, 0.5, 0.4375, 0.375},
			{-0.375, -0.375, 0.375, 0.375, 0.4375, 0.5},
			{-0.375, -0.375, -0.5, 0.375, 0.4375, -0.375},
			{-0.375, 0.0625, -0.375, 0.375, 0.125, 0.375},
		}
	},
	on_punch = function(pos, node, player)
		local player_inv = player:get_inventory()
		local itemstack = player:get_wielded_item()
		if itemstack:get_name() == "vessels:glass_bottle" then
			minetest.set_node(pos, {name="lottpotion:cauldron_one_third_full"})
			if player_inv:room_for_item("main", 1) then
				itemstack:take_item(1)
				player_inv:add_item("main", "lord_vessels:glass_bottle_water")
			end
			player:set_wielded_item(itemstack)
		end
	end,
})

minetest.register_node("lottpotion:cauldron_one_third_full",{
	drawtype="nodebox",
	description= SL("One Third Filled Cauldron"),
	tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	use_texture_alpha = "opaque",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375},
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375},
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5},
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5},
			{-0.375, -0.375, -0.375, 0.375, -0.3125, 0.375},
			{-0.5, -0.375, -0.375, -0.375, 0.4375, 0.375},
			{0.375, -0.375, -0.375, 0.5, 0.4375, 0.375},
			{-0.375, -0.375, 0.375, 0.375, 0.4375, 0.5},
			{-0.375, -0.375, -0.5, 0.375, 0.4375, -0.375},
			{-0.375, -0.125, -0.375, 0.375, -0.0625, 0.375},
		}
	},
	on_punch = function(pos, node, player)
		local player_inv = player:get_inventory()
		local itemstack = player:get_wielded_item()
		if itemstack:get_name() == "vessels:glass_bottle" then
			minetest.set_node(pos, {name="lottpotion:cauldron_empty"})
			if player_inv:room_for_item("main", 1) then
				itemstack:take_item(1)
				player_inv:add_item("main", "lord_vessels:glass_bottle_water")
			end
			player:set_wielded_item(itemstack)
		end
	end,
})

minetest.register_node("lottpotion:cauldron_empty",{
	drawtype="nodebox",
	description= SL("Empty Cauldron"),
	tiles = {"lottpotion_cauldron_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1,level=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375},
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375},
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5},
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5},
			{-0.375, -0.375, -0.375, 0.375, -0.3125, 0.375},
			{-0.5, -0.375, -0.375, -0.375, 0.4375, 0.375},
			{0.375, -0.375, -0.375, 0.5, 0.4375, 0.375},
			{-0.375, -0.375, 0.375, 0.375, 0.4375, 0.5},
			{-0.375, -0.375, -0.5, 0.375, 0.4375, -0.375},
			{-0.375, -0.125, -0.375, 0.375, -0.25, 0.375},
		},
	},
	on_rightclick = function(pos, node, clicker, itemstack)
		if itemstack:get_name() == "bucket:bucket_water" then
			minetest.set_node(pos, {name="lottpotion:cauldron_full"})
			return {name="bucket:bucket_empty"}
		end
	end
})

minetest.register_craft({
	output = 'lottpotion:cauldron_empty',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
