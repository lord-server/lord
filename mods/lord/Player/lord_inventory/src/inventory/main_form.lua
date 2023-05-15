local detached_inv_armor_slots = require("inventory.main.armor_slots")
local detached_inv_clothing_slots = require("inventory.main.clothing_slots")
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
	.. "list[detached:player_name_armor;armor;0,0;1,4;]"
	-- Clothes slots
	.. "image[3,0;1,1;lottarmor_helmet.png]"
	.. "image[3,1;1,1;lottarmor_shirt.png]"
	.. "image[3,2;1,1;lottarmor_trousers.png]"
	.. "image[3,3;1,1;lottarmor_shoes.png]"
	.. "list[detached:player_name_clothing;clothing;3,0;1,4;]"
	.. "image[4,0;1,1;lottarmor_cloak.png]"
	.. "list[detached:player_name_clothing;clothing;4,0;1,1;4]"
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

Form.get_spec = function(player_name)
	if not armor.textures[player_name] then
		minetest.log("error", "lottarmor: Player texture[" .. player_name .. "] is nil [get_armor_formspec]")
		return ""
	end
	if not armor.def[player_name] then
		minetest.log("error", "lottarmor: Armor def[" .. player_name .. "] is nil [get_armor_formspec]")
		return ""
	end
	local formspec = formspec_template:gsub("player_name", player_name)
	formspec       = formspec:gsub("armor_preview", armor.textures[player_name].preview)

	return formspec
end


--- @param joined_player Player
minetest.register_on_joinplayer(function(joined_player, last_login)
	local name = joined_player:get_player_name()
	local player_inv = joined_player:get_inventory()

	local armor_inv  = minetest.create_detached_inventory(name .. "_armor", detached_inv_armor_slots, name)
	armor_inv:set_size("armor", 5)
	for i = 1, 5 do
		local stack = player_inv:get_stack("armor", i)
		armor_inv:set_stack("armor", i, stack)
	end

	local clothing_inv = minetest.create_detached_inventory(name.."_clothing", detached_inv_clothing_slots, name)
	clothing_inv:set_size("clothing", 5)
	for i=1, 5 do
		local stack = player_inv:get_stack("clothing", i)
		clothing_inv:set_stack("clothing", i, stack)
	end
end)

return Form
