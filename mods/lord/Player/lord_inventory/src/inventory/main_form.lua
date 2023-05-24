local detached_inv_equipment_slots = {
	armor    = require("inventory.main.armor_slots"),
	clothing = require("inventory.main.clothing_slots"),
}

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

Form.get_spec = function(player_name, preview)
	local formspec = formspec_template:gsub("player_name", player_name)
	formspec       = formspec:gsub("armor_preview", preview)

	return formspec
end

-- When *any* equipment (armor and clothing) loaded (when player joined),
-- we need to:
--   - create detached inventories for each equipment (armor&clothing)
--       to use it on form of main player inventory
--   - fill each inventory with equipment items
equipment.on_load(function(player, kind, event)
	local player_name = player:get_player_name()
	local equip_inv   = minetest.create_detached_inventory(
		player_name .. "_" .. kind, detached_inv_equipment_slots[kind], player_name
	)
	equip_inv:set_size(kind, equipment.Kind.get_size(kind))
	for slot, item in equipment.for_player(player):items(kind) do
		equip_inv:set_stack(kind, slot, item)
	end
end)


return Form
