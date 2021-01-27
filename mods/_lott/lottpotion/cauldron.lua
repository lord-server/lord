local SL = lord.require_intllib()

minetest.register_node("lottpotion:cauldron_full",{
	drawtype="nodebox",
	description= SL("Filled Cauldron"),
	tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000},
			{0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000},
			{-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000},
			{-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.312500,-0.500000,0.500000,0.312500,0.500000},
			{-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000},
			{0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000},
			{0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000},
		}
	}
})

minetest.register_node("lottpotion:cauldron_two_third_full",{
	drawtype="nodebox",
	description= SL("Two Third Filled Cauldron"),
	tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000},
			{0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000},
			{-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000},
			{-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.312500,-0.500000,0.500000,0.125000,0.500000},
			{-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000},
			{0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000},
			{0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000},
		}
	}
})

minetest.register_node("lottpotion:cauldron_one_third_full",{
	drawtype="nodebox",
	description= SL("One Third Filled Cauldron"),
	tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000},
			{0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000},
			{-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000},
			{-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.312500,-0.500000,0.500000,-0.062500,0.500000},
			{-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000},
			{0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000},
			{0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000},
		}
	}
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
			{-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000},
			{0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000},
			{-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000},
			{-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000},
			{0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000},
			{0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000},
			{-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000},
			{-0.500000,-0.375000,-0.500000,0.500000,-0.312500,0.500000},
		},
	},
	on_rightclick = function(pos, node, clicker, itemstack)
		if itemstack:get_name() == "bucket:bucket_water" then
			minetest.set_node(pos, {name="lottpotion:cauldron_full"})
			return {name="bucket:bucket_empty"}
		end
	end
})

minetest.register_node(":vessels:glass_bottle", {
	description = SL("Glass Bottle (empty)"),
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png"},
	inventory_image = "vessels_glass_bottle_inv.png",
	wield_image = "vessels_glass_bottle.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
	on_use = function(itemstack, user, pointed_thing)
		local res
		local pos = pointed_thing.above
		if pos == nil then return itemstack end
		pos.y = pos.y - 1
		if (minetest.get_node(pos).name == "lottpotion:cauldron_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_two_third_full"})
			itemstack:take_item()
			res = user:get_inventory():add_item("main", "lottpotion:glass_bottle_water")
			if res then
				minetest.item_drop(res, user, pos)
			end
			return itemstack
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_two_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_one_third_full"})
			itemstack:take_item()
			res = user:get_inventory():add_item('main', "lottpotion:glass_bottle_water")
			if res then
				minetest.item_drop(res, user, pos)
			end
			return itemstack
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_one_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_empty"})
			itemstack:take_item()
			res = user:get_inventory():add_item('main', "lottpotion:glass_bottle_water")
			if res then
				minetest.item_drop(res, user, pos)
			end
			return itemstack
		end
	end
})

minetest.register_node("lottpotion:glass_bottle_water", {
	description = SL("Glass Bottle (Water)"),
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^lottpotion_water.png"},
	inventory_image = "vessels_glass_bottle_inv.png^lottpotion_water.png",
	wield_image = "vessels_glass_bottle_inv.png^lottpotion_water.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node(":vessels:drinking_glass", {
	description = SL("Drinking Glass (empty)"),
	drawtype = "plantlike",
	tiles = {"vessels_drinking_glass.png"},
	inventory_image = "vessels_drinking_glass_inv.png",
	wield_image = "vessels_drinking_glass.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
	on_use = function(itemstack, user, pointed_thing)
		local res
		local pos = pointed_thing.above
		if pos == nil then return itemstack end
		pos.y = pos.y - 1
		if (minetest.get_node(pos).name == "lottpotion:cauldron_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_two_third_full"})
			itemstack:take_item()
			res = user:get_inventory():add_item('main', "lottpotion:drinking_glass_water")
			if res then
				minetest.item_drop(res, user, pos)
			end
			return itemstack
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_two_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_one_third_full"})
			itemstack:take_item()
			res = user:get_inventory():add_item('main', "lottpotion:drinking_glass_water")
			if res then
				minetest.item_drop(res, user, pos)
			end
			return itemstack
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_one_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_empty"})
			itemstack:take_item()
			res = user:get_inventory():add_item('main', "lottpotion:drinking_glass_water")
			if res then
				minetest.item_drop(res, user, pos)
			end
			return itemstack
		end
	end
})

minetest.register_node("lottpotion:drinking_glass_water", {
	description = SL("Drinking Glass (Water)"),
	drawtype = "plantlike",
	tiles = {"lottpotion_glass_water.png"},
	inventory_image = "lottpotion_glass_water.png",
	wield_image = "lottpotion_glass_water.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

--[[
minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"group:vessel",
		"group:vessel",
	},
})
]]--
minetest.register_craft({
	output = 'lottpotion:cauldron_empty',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
