local SL = minetest.get_mod_translator()

-- Minetest 0.4 mod: bones
-- See README.txt for licensing and other information.

local publish_after = tonumber(minetest.settings:get("share_bones_time")) or 60*5

local bones_formspec =
	"size[8,9]"..
	"list[current_name;main;0,-0.2;8,5;]"..
	"list[current_player;main;0,5.2;8,4;]"..
	"listring[current_name;main]"..
	"listring[current_player;main]"..
	"background[-0.5,-0.65;9,10.35;gui_bonesbg.png]"

local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name then
		return true
	end
	return false
end

local function register_corpse(race, gender, skin)
	minetest.register_node(string.format("bones:corpse_%s_%s_%d", race, gender, skin), {
		description = SL("Corpse"),
		drawtype = "mesh",
		mesh = "bones.obj",
		tiles = {lord_skins.get_texture_name(race, gender, skin)},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.7, 0.3, -0.2, 0.7},
		},
		paramtype2 = "facedir",
		groups = {dig_immediate=3, corpse = 1},
		can_dig = function(pos, player)
			if player == nil then
				return
			end
			local inv = minetest.get_meta(pos):get_inventory()
			return is_owner(pos, player:get_player_name()) and inv:is_empty("main")
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if is_owner(pos, player:get_player_name()) then return count end
			return 0
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			return 0
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			if is_owner(pos, player:get_player_name()) then return stack:get_count() end
			return 0
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			if meta:get_string("owner") ~= "" and meta:get_inventory():is_empty("main") then
				meta:set_string("infotext", SL("Unknown corpse"))
				meta:set_string("owner", "")
			end
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("main", 8*5)
			meta:set_string("infotext", SL("Unknown corpse"))
			meta:set_string("formspec", bones_formspec)
		end,
		on_timer = function(pos, elapsed)
			if publish_after <= 0 then return false end -- таймер не работает
			local meta = minetest.get_meta(pos)
			local time = meta:get_int("time") + elapsed
			if time >= publish_after then
				meta:set_string("infotext", SL("Unknown corpse"))
				meta:set_string("owner", "")
				return false
			else
				meta:set_int("time", time)
				return true
			end
		end,
		on_punch = function(pos, node, player)
			if(not is_owner(pos, player:get_player_name())) then return end
			local inv = minetest.get_meta(pos):get_inventory()
			local player_inv = player:get_inventory()
			if not player_inv then
				return
			end

			for i=1,inv:get_size("main") do
				local stk = inv:get_stack("main", i)
				if player_inv:room_for_item("main", stk) then
					inv:set_stack("main", i, nil)
					player_inv:add_item("main", stk)
				else
					break
				end
			end
		end
	})
end

for race, _ in pairs(races.list) do
	for _, gender in pairs({"male", "female"}) do
		for skin_no = 1, lord_skins.get_skins_count(race, gender) do
			if not races.list[race].no_corpse then
				register_corpse(race, gender, skin_no)
			end
		end
	end
end
minetest.register_alias("bones:bones", "bones:corpse_man_male")

--- @param player Player
--- @return Position|nil
local function find_position_for_corpse(player)
	local pos = player:get_pos()
	pos.x = math.floor(pos.x + 0.5)
	pos.y = math.floor(pos.y + 0.5)
	pos.z = math.floor(pos.z + 0.5)

	pos = minetest.find_node_near(pos, 20, {
		"air", "default:water_source", "default:water_flowing",
		"lottmapgen:blacksource", "lottmapgen:blackflowing",
		"default:river_water_source", "default:river_water_flowing",
	}, true)

	return pos
end

--- @param inventory InvRef
--- @param list_name string
local function clear_inventory_list(inventory, list_name)
	for i = 1, inventory:get_size(list_name) do
		inventory:set_stack(list_name, i, nil)
	end
end
--- @param inventory1 InvRef
--- @param list_name1 string
--- @param inventory2 InvRef
--- @param list_name2 string
local function exchange_inventories_lists(inventory1, list_name1, inventory2, list_name2)
	list_name2 = list_name2 or list_name1
	-- TODO: при выносе ф-ции в либу, нужно проверять размеры
	local temp_list = inventory1:get_list(list_name1)
	inventory1:set_list(list_name1, inventory2:get_list(list_name2))
	inventory2:set_list(list_name2, temp_list)
end
--- @param from_inventory InvRef
--- @param from_list      string
--- @param to_inventory   InvRef
--- @param to_list        string
local function move_inventory_list(from_inventory, from_list, to_inventory, to_list)
	for i = 1, from_inventory:get_size(from_list) do
		to_inventory:add_item(to_list, from_inventory:get_stack(from_list, i))
		from_inventory:set_stack(from_list, i, nil)
	end
end
--- @param player Player
minetest.register_on_dieplayer(function(player)
	if minetest.is_creative_enabled(player) then
		return
	end

	local race =   races.get_race(player)
	local gender = races.get_gender(player)
	local skin =   races.get_skin_number(player)
	if races.list[race].no_corpse then
		return
	end

	local corpse_pos = find_position_for_corpse(player)
	if corpse_pos == nil then
		return
	end

	local param2 = minetest.dir_to_facedir(player:get_look_dir())
	minetest.set_node(corpse_pos, { name =string.format("bones:corpse_%s_%s_%d", race, gender, skin), param2 =param2})

	local player_name = player:get_player_name()
	local player_inv = player:get_inventory()
	local corpse_meta = minetest.get_meta(corpse_pos)
	local corpse_inv  = corpse_meta:get_inventory()
	local armor_inv = minetest.get_inventory({type="detached", name=player_name.."_armor"})
	corpse_inv:set_size("main", 8*5)
	exchange_inventories_lists(corpse_inv, "main", player_inv, "main")
	move_inventory_list(player_inv, "craft", corpse_inv, "main")
	equipment.for_player(player):move_to(equipment.Kind.ARMOR, corpse_inv, "main")
	if armor_inv then
		clear_inventory_list(armor_inv, "armor")
	end

	corpse_meta:set_string("formspec", bones_formspec)
	if publish_after < 0 then -- все трупы - достояние общественности
		corpse_meta:set_string("infotext", SL("Unknown corpse"))
		corpse_meta:set_string("owner", "")
	elseif publish_after == 0 then -- труп - собственность хозяина - навсегда
		corpse_meta:set_string("infotext", SL("Corpse of").." "..player_name)
		corpse_meta:set_string("owner", player_name)
	else -- труп - собственность хозяина - на время publish_after
		corpse_meta:set_string("infotext", SL("Corpse of").." "..player_name)
		corpse_meta:set_string("owner", player_name)
		corpse_meta:set_int("time", 0)
		minetest.get_node_timer(corpse_pos):start(10)
	end
end)

dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."items.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."skeleton.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."crafting.lua")
