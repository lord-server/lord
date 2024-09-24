
local detached_inv_trash = minetest.create_detached_inventory("armor_trash", {
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put    = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
detached_inv_trash:set_size("main", 1)


local formspec_template = "size[8,8.5]"
    -- Armor slots
	.. "image[0,0;1,1;lottarmor_helmet.png]"
	.. "image[0,1;1,1;lottarmor_chestplate.png]"
	.. "image[0,2;1,1;lottarmor_leggings.png]"
	.. "image[0,3;1,1;lottarmor_boots.png]"
	.. "list[detached:{{armor_slots}};armor;0,0;1,4;]"
	-- Clothes slots
	.. "image[3,0;1,1;lottarmor_helmet.png]"
	.. "image[3,1;1,1;lottarmor_shirt.png]"
	.. "image[3,2;1,1;lottarmor_trousers.png]"
	.. "image[3,3;1,1;lottarmor_shoes.png]"
	.. "list[detached:{{clothing_slots}};clothing;3,0;1,4;]"
	.. "image[4,0;1,1;lottarmor_cloak.png]"
	.. "list[detached:{{clothing_slots}};clothing;4,0;1,1;4]"
	-- Preview & Shield
	.. "image[1.16,0.25;2,4;armor_preview]"
	.. "image[2,2;1,1;lottarmor_shield.png]"
	.. "list[detached:player_name_armor;armor;2,2;1,1;4]"
	-- Crafting
	.. "image[5.05,0;3.5,1;lottarmor_crafting.png]"
	.. "list[current_player;craft;4,1;3,3;]"
	.. "list[current_player;craftpreview;7,2;1,1;]"
	-- Bags & Trash
	.. "image_button[7,1;1,1;bags.png;bags;]"
	.. "image[7,3;1,1;lottarmor_trash.png]"
	.. "list[detached:armor_trash;main;7,3;1,1;]"
	-- Player inventory content
	.. "list[current_player;main;0,4.25;8,1;]"
	.. "list[current_player;main;0,5.5;8,3;8]"
	-- options
	.. "listring[current_player;main]"
	.. "listring[current_player;craft]"

---
--- @class inventory.main.Form
---
local Form = {

}

Form.get_spec = function(player_name, preview)
	local armor_inv_name = equipment.get_inventory_name(player_name, equipment.Kind.ARMOR)
	local clothing_inv_name = equipment.get_inventory_name(player_name, equipment.Kind.CLOTHING)
	local formspec = formspec_template
	formspec = formspec:replace('{{armor_slots}}', armor_inv_name)
	formspec = formspec:replace('{{clothing_slots}}', clothing_inv_name)
	formspec = formspec:replace('armor_preview', preview)

	return formspec
end


return Form
