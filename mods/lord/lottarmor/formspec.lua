local SL = minetest.get_translator("lottarmor")

local gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
local gui_slots = "listcolors[#606060AA;#606060;#141318;#30434C;#FFF]"

local main_formspec = gui_bg_img
..gui_slots
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
.."image[1.16,0.25;2,4;armor_preview]"
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
.."image_button[7,1;1,1;bags.png;bags;]"

local function get_bags_formspec(player)
	return "list[current_player;main;0,3.5;8,4;]"
			.."button[0,0;2,0.5;main;"..SL("Back").."]"
			.."button[0,2;2,0.5;bag1;"..SL("Bag").." 1]"
			.."button[2,2;2,0.5;bag2;"..SL("Bag").." 2]"
			.."button[4,2;2,0.5;bag3;"..SL("Bag").." 3]"
			.."button[6,2;2,0.5;bag4;"..SL("Bag").." 4]"
			.."list[detached:"..player:get_player_name().."_bags;bag1;0.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag2;2.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag3;4.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag4;6.5,1;1,1;]"
            .."background[5,5;1,1;gui_formbg.png;true]"
end

local function get_bag_formspec(player, i)
	local image = player:get_inventory():get_stack("bag"..i, 1):get_definition().inventory_image
	return "list[current_player;main;0,4.5;8,4;]"
				.."button[0,0;2,0.5;main;"..SL("Main").."]"
				.."button[2,0;2,0.5;bags;"..SL("Bags").."]"
				.."image[7,0;1,1;"..image.."]"
				.."list[current_player;bag"..i.."contents;0,1;8,3;]"
				.."listring[current_player;bag"..i.."contents]"
				.."listring[current_player;main]"
				.."background[5,5;1,1;gui_formbg.png;true]"
end

local function get_main_formspec(name)
	if not armor.textures[name] then
		minetest.log("error", "lottarmor: Player texture["..name.."] is nil [get_armor_formspec]")
		return ""
	end
	if not armor.def[name] then
		minetest.log("error", "lottarmor: Armor def["..name.."] is nil [get_armor_formspec]")
		return ""
	end
	local formspec = main_formspec:gsub("player_name", name)
	formspec = formspec:gsub("armor_preview", armor.textures[name].preview)
	formspec = formspec:gsub("armor_level", armor.def[name].level)
	formspec = formspec:gsub("armor_heal", armor.def[name].heal)
	formspec = formspec:gsub("armor_fire", armor.def[name].fire)
	return formspec
end

--- Bags
minetest.register_on_player_receive_fields(function(player, formname, fields)
    local name = armor:get_valid_player(player, "[on_player_receive_fields]")
	if not name then
		minetest.log("error", "Can not get inventory for player "..player:get_player_name())
		return ""
	end

	if fields.bags then
		armor.def[name].page = "bags"
		armor:update_inventory(player)
        return
	end

	for i=1,4 do
		local page = "bag"..i
		if fields[page] then
			if player:get_inventory():get_stack(page, 1):get_definition().groups.bagslots==nil then
				armor.def[name].page = "bags"
            else
                armor.def[name].page = i
			end
			armor:update_inventory(player)
            return
		end
	end

	if fields.main then
		armor.def[name].page = "main"
		armor:update_inventory(player)
        return
	end
end)

armor.update_inventory = function(self, player)
	local name = armor:get_valid_player(player, "[set_player_armor]")
	if not name then
		return
	end

	sfinv.update_player(player)
end

sfinv.register_page("lottarmor:inventory", {
	title=SL("Inventory"),
	is_in_nav = function(self, player, context)
		return true
	end,
	get = function(self, player, context)
		local name = armor:get_valid_player(player, "[get_main_formspec]")
	    if not name then
		    minetest.log("error", "Can not get inventory for player "..player:get_player_name())
		    return ""
	    end

        if armor.def[name].page == "main" then
		    return get_main_formspec(name)
		elseif armor.def[name].page == "bags" then
            return get_bags_formspec(player)
        else
            return get_bag_formspec(player, armor.def[name].page)
        end
	end,
})
