local S = minetest.get_translator(minetest.get_current_modname())

ARMOR_INIT_DELAY = 1
ARMOR_INIT_TIMES = 1

lord_armor.inv = {}
lord_armor.inv.forms = {}
lord_armor.inv.textures = {}

local armor_gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
local armor_gui_slots = "listcolors[#606060AA;#606060;#141318;#30434C;#FFF]"

lord_armor.inv.forms["main"] = {
	player_hp = {},
	elements = {"head", "torso", "legs", "feet"},
	physics = {"jump","speed","gravity"},
	formspec = "size[8,8.5]"
		..armor_gui_bg_img
		..armor_gui_slots
		.."image[0,0;1,1;lottarmor_helmet.png]"
		.."image[0,1;1,1;lottarmor_chestplate.png]"
		.."image[0,2;1,1;lottarmor_leggings.png]"
		.."image[0,3;1,1;lottarmor_boots.png]"
		.."image[3,0;1,1;lottarmor_helmet.png]"
		.."image[3,1;1,1;lottarmor_shirt.png]"
		.."image[3,2;1,1;lottarmor_trousers.png]"
		.."image[3,3;1,1;lottarmor_shoes.png]"
		.."image[4,0;1,1;lottarmor_cloak.png]"
		.."list[detached:player_name_armor;armor;0,0;1,4;]"
		.."list[detached:player_name_armor;armor;2,2;1,1;4]"
		.."list[detached:player_name_clothing;clothing;3,0;1,4;]"
		.."list[detached:player_name_clothing;clothing;4,0;1,1;4]"
		--.."image[1.16,0.25;2,4;armor_preview]"
		.."image[2,2;1,1;lottarmor_shield.png]"
		.."list[current_player;main;0,4.25;8,1;]"
		.."list[current_player;main;0,5.5;8,3;8]"
		.."image[5.05,0;3.5,1;lottarmor_crafting.png]"
		.."list[current_player;craft;4,1;3,3;]"
		.."list[current_player;craftpreview;7,2;1,1;]"
		.."listring[current_player;main]"
		.."listring[current_player;craft]"
		.."image[7,3;1,1;lottarmor_trash.png]"
		.."list[detached:armor_trash;main;7,3;1,1;]"
		.."image_button[7,1;1,1;bags.png;bags;]",
	textures = {},
	def = {state = 0, count = 0},
	version = "0.4.4",
}

lord_armor.inv.forms["bags"] = {
	formspec = "size[8,7.5]"
	.."list[current_player;main;0,3.5;8,4;]"
	.."button[0,0;2,0.5;main;"..S("Back").."]"
	.."button[0,2;2,0.5;bag1;"..S("Bag").." 1]"
	.."button[2,2;2,0.5;bag2;"..S("Bag").." 2]"
	.."button[4,2;2,0.5;bag3;"..S("Bag").." 3]"
	.."button[6,2;2,0.5;bag4;"..S("Bag").." 4]"
	.."list[detached:player_name_bags;bag1;0.5,1;1,1;]"
	.."list[detached:player_name_bags;bag2;2.5,1;1,1;]"
	.."list[detached:player_name_bags;bag3;4.5,1;1,1;]"
	.."list[detached:player_name_bags;bag4;6.5,1;1,1;]"
	.."background[5,5;1,1;gui_formbg.png;true]"
}

if minetest.is_creative_enabled() then
	lord_armor.inv.forms["main"].formspec = lord_armor.inv.forms["main"].formspec ..
	"tabheader[-0.12,-0.12;creative_tabs;Main,Creative;1;true;false"
end

local get_bags_formspec = function(player, page)
	if page == "bags" then
		local formspec = lord_armor.inv.forms["bags"].formspec:gsub("player_name", player:get_player_name())
		return formspec
	end
	for i = 1, 4 do
		if page == "bag"..i then
			local image = player:get_inventory():get_stack("bag"..i, 1):get_definition().inventory_image
			return "size[8,8.5]"
				.."list[current_player;main;0,4.5;8,4;]"
				.."button[0,0;2,0.5;main;"..S("Main").."]"
				.."button[2,0;2,0.5;bags;"..S("Bags").."]"
				.."image[7,0;1,1;"..image.."]"
				.."list[current_player;bag"..i.."contents;0,1;8,3;]"
				.."listring[current_player;bag"..i.."contents]"
				.."listring[current_player;main]"
				.."background[5,5;1,1;gui_formbg.png;true]"
		end
	end
end

--- Bags
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.bags then
		inventory_plus.set_inventory_formspec(player, get_bags_formspec(player,"bags"))
		return
	end

	for i = 1, 4 do
		local page = "bag"..i
		if fields[page] then
			if player:get_inventory():get_stack(page, 1):get_definition().groups.bagslots == nil then
				page = "bags"
			end
			inventory_plus.set_inventory_formspec(player, get_bags_formspec(player, page))
			return
		end
	end
end)

--Trash
local trash = minetest.create_detached_inventory("armor_trash", {
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
trash:set_size("main", 1)

lord_armor.get_armor_formspec = function(name)
	if not lord_armor.inv.textures[name] then
		minetest.log("error", "lottarmor: Player texture["..name.."] is nil [get_armor_formspec]")
		return ""
	end
	if not lord_armor.prot.def[name] then
		minetest.log("error", "lottarmor: Armor def["..name.."] is nil [get_armor_formspec]")
		return ""
	end
	local formspec = lord_armor.inv.forms["main"].formspec:gsub("player_name", name)
	--formspec = formspec:gsub("armor_preview", lord_armor.inv.textures[name].preview)
	formspec = formspec:gsub("armor_level", lord_armor.prot.def[name].level)
	formspec = formspec:gsub("armor_heal", lord_armor.prot.def[name].heal)
	formspec = formspec:gsub("armor_fire", lord_armor.prot.def[name].fire)
	return formspec
end

lord_armor.get_valid_player = function(player, msg)
	msg = msg or ""

	if not player then
		minetest.log("error", "lord_armor: Player reference is nil "..msg)
		return
	end
	local name = player:get_player_name()
	if not name then
		minetest.log("error", "lord_armor: Player name is nil "..msg)
		return
	end

	local pos = player:get_pos()
	local player_inv = player:get_inventory()
	local armor_inv = minetest.get_inventory({type = "detached", name = name.."_armor"})

	if not pos then
		minetest.log("error", "lord_armor: Player position is nil "..msg)
		return
	elseif not player_inv then
		minetest.log("error", "lord_armor: Player inventory is nil "..msg)
		return
	elseif not armor_inv then
		minetest.log("error", "lord_armor: Detached armor inventory is nil "..msg)
		return
	end

	return name, player_inv, armor_inv, pos
end

lord_armor.upd_inv = function(player)
	local name = lord_armor.get_valid_player(player, "[set_player_armor]")
	if not name then
		return
	end
	local formspec = lord_armor.get_armor_formspec(name)
	player:set_inventory_formspec(formspec)
end

races.register_init_callback(function(name, race, gender, skin, texture, face)
	--minetest.log("Join player "..name..": "..race.." "..gender.." "..skin.." "..tostring(texture).." "..tostring(face))
	local joined_player = minetest.get_player_by_name(name)
	lord_armor.skin_init(joined_player, texture)
	local player_inv = joined_player:get_inventory()
	local armor_inv = minetest.create_detached_inventory(name.."_armor", {

		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			lord_armor.set_player_armor(player)
			lord_armor.upd_inv(player)
			lottachievements.equip(stack, player, 1)
		end,

		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			lord_armor.set_player_armor(player)
			lord_armor.upd_inv(player)
			lottachievements.equip(stack, player, -1)
		end,

		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			local p_inv = player:get_inventory()
			local stack = inv:get_stack(to_list, to_index)
			p_inv:set_stack(to_list, to_index, stack)
			p_inv:set_stack(from_list, from_index, nil)
			lord_armor.set_player_armor(player)
			lord_armor.upd_inv(player)
		end,

		allow_put = function(inv, listname, index, stack, player)
			if index == 1 then
				if stack:get_definition().groups.helmet == nil then
					return 0
				else
					return 1
				end
			elseif index == 2 then
				if stack:get_definition().groups.chestplate == nil then
					return 0
				else
					return 1
				end
			elseif index == 3 then
				if stack:get_definition().groups.greeve == nil then
					return 0
				else
					return 1
				end
			elseif index == 4 then
				if stack:get_definition().groups.boots == nil then
					return 0
				else
					return 1
				end
			elseif index == 5 then
				if stack:get_definition().groups.shield == nil then
					return 0
				else
					return 1
				end
			end
		end,

		allow_take = function(inv, listname, index, stack, player)
			return stack:get_count()
		end,

		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return count
		end,
	}, name)

	armor_inv:set_size("armor", 5)
	player_inv:set_size("armor", 5)

	for i = 1, 5 do
		local stack = player_inv:get_stack("armor", i)
		armor_inv:set_stack("armor", i, stack)
	end

	--Bags
	local bags_inv = minetest.create_detached_inventory(name.."_bags", {

		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			player:get_inventory():set_size(listname.."contents", stack:get_definition().groups.bagslots)
		end,

		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
		end,

		allow_put = function(inv, listname, index, stack, player)
			if stack:get_definition().groups.bagslots then
				return 1
			else
				return 0
			end
		end,

		allow_take = function(inv, listname, index, stack, player)
			if player:get_inventory():is_empty(listname.."contents") == true then
				return stack:get_count()
			else
				return 0
			end
		end,

		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,

	}, name)

	for i = 1, 4 do
		local bag = "bag"..i
		player_inv:set_size(bag, 1)
		bags_inv:set_size(bag, 1)
		bags_inv:set_stack(bag,1,player_inv:get_stack(bag,1))
	end

	--[[armor.player_hp[name] = 0]]
	lord_armor.prot.def[name] = {
		state = 0,
		count = 0,
		level = 0,
		heal = 0,
		jump = 1,
		speed = 1,
		gravity = 1,
		fire = 0,
	}

	lord_armor.inv.textures[name] = {
		armor = "lottarmor_trans.png",
		preview = "character_preview.png"
	}
	for i = 1, ARMOR_INIT_TIMES do
		minetest.after(ARMOR_INIT_DELAY * i, function(player)
			lord_armor.set_player_armor(player)
			if not inv_mod and not minetest.settings:get_bool("creative_mode") then
				lord_armor.upd_inv(player)
			end
		end, joined_player)
	end
	races.update_player(name, {race, gender}, skin)
end)