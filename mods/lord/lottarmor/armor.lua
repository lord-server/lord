local SL = minetest.get_translator("lottarmor")

-- Global Defaults - use armor.conf to override these

ARMOR_INIT_DELAY = 1
ARMOR_INIT_TIMES = 1
-- ARMOR_BONES_DELAY = 1
ARMOR_UPDATE_TIME = 1
ARMOR_DROP = minetest.get_modpath("bones") ~= nil
ARMOR_DESTROY = false
ARMOR_LEVEL_MULTIPLIER = 1
ARMOR_HEAL_MULTIPLIER = 1
ARMOR_MATERIALS = {
	wood = "group:wood",
	cactus = "default:cactus",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	diamond = "default:diamond",
	gold = "default:gold_ingot",
	mithril = "moreores:mithril_ingot",
	crystal = "ethereal:crystal_ingot",
}
ARMOR_FIRE_PROTECT = minetest.get_modpath("ethereal") ~= nil
ARMOR_FIRE_NODES = {
	{"default:lava_source",     5, 4},
	{"default:lava_flowing",    5, 4},
	{"fire:basic_flame",        3, 4},
	{"ethereal:crystal_spike",  2, 1},
	{"bakedclay:safe_fire",     2, 1},
	{"default:torch",           1, 1},
}

-- Load Armor Configs

--- @param path string
local function load_config(path)
	local function file_exists(name)
		local f = io.open(name,"r")
		if f~=nil then f:close() return true else return false end
	end

	local config = path .. "/armor.conf"
	if not file_exists(config) then return end

	dofile(config)
end

load_config(minetest.get_modpath("lottarmor"))
load_config(minetest.get_worldpath())


if not minetest.get_modpath("moreores") then
	ARMOR_MATERIALS.mithril = nil
end
if not minetest.get_modpath("ethereal") then
	ARMOR_MATERIALS.crystal = nil
end

-- override hot nodes so they do not hurt player anywhere but mod
if ARMOR_FIRE_PROTECT == true then
	for _, row in ipairs(ARMOR_FIRE_NODES) do
		if minetest.registered_nodes[row[1]] then
			minetest.override_item(row[1], {damage_per_second = 0})
		end
	end
end

-- Armor API

local inv_mod = nil
local time = 0

armor = {
	player_hp = {},
	elements = {"head", "torso", "legs", "feet"},
	physics = {"jump","speed","gravity"},
	textures = {},
	def = {state=0, count = 0},
	version = "0.4.4",
}


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

armor.update_player_visuals = function(self, player)
	multiskin:update_player_visuals(player)
end

armor.set_player_armor = function(self, player)
	local name, player_inv = armor:get_valid_player(player, "[set_player_armor]")
	if not name then
		return
	end
	local armor_texture = "lottarmor_trans.png"
	local armor_level = 0
	local armor_heal = 0
	local armor_fire = 0
	local state = 0
	local items = 0
	local elements = {}
	local textures = {}
	local physics_o = {speed=1,gravity=1,jump=1}
	local material = {type=nil, count=1}
	local preview = multiskin:get_preview(name) or "character_preview.png"
	for _,v in ipairs(self.elements) do
		elements[v] = false
	end
	for i = 1, 5 do
		local stack = player_inv:get_stack("armor", i)
		local item = stack:get_name()
		if stack:get_count() == 1 then
			local def = stack:get_definition()
			for k, v in pairs(elements) do
				if v == false then
					local level = def.groups["armor_"..k]
					if level and not def.groups["clothes"] then
						local texture = item:gsub("%:", "_")
						table.insert(textures, texture..".png")
						preview = preview.."^"..texture.."_preview.png"
						armor_level = armor_level + level
						state = state + stack:get_wear()
						items = items + 1
						local heal = def.groups["armor_heal"] or 0
						armor_heal = armor_heal + heal
						local fire = def.groups["armor_fire"] or 0
						armor_fire = armor_fire + fire
						for kk,vv in ipairs(self.physics) do
							local o_value = def.groups["physics_"..vv]
							if o_value then
								physics_o[vv] = physics_o[vv] + o_value
							end
						end
						local mat = string.match(item, "%:.+_(.+)$")
						if material.type then
							if material.type == mat then
								material.count = material.count + 1
							end
						else
							material.type = mat
						end
						elements[k] = true
					end
				end
			end
		end
	end
	if minetest.get_modpath("shields") then
		armor_level = armor_level * 0.9
	end
	if material.type and material.count == #self.elements then
		armor_level = armor_level * 1.1
	end
	armor_level = armor_level * ARMOR_LEVEL_MULTIPLIER
	armor_heal = armor_heal * ARMOR_HEAL_MULTIPLIER
	if #textures > 0 then
		armor_texture = table.concat(textures, "^")
	end
	local armor_groups = {fleshy=100}
	local immortal = player:get_armor_groups().immortal
	if immortal and immortal ~= 0 then
		armor_groups.immortal = 1
	end
	if armor_level > 0 then
		armor_groups.level = math.floor(armor_level / 20)
		armor_groups.fleshy = 100 - armor_level
	end
	if player:get_meta():get("lott:immunity") ~= nil and (not immortal or immortal == 0) then
		player:set_armor_groups({fleshy = 1})
	else
		player:set_armor_groups(armor_groups)
	end
	player:set_physics_override(physics_o)
	self.textures[name].armor = armor_texture
	self.textures[name].preview = preview
	self.def[name].state = state
	self.def[name].count = items
	self.def[name].level = armor_level
	self.def[name].heal = armor_heal
	self.def[name].jump = physics_o.jump
	self.def[name].speed = physics_o.speed
	self.def[name].gravity = physics_o.gravity
	self.def[name].fire = armor_fire
	multiskin[name].armor = armor_texture
	multiskin:update_player_visuals(player)
end

armor.update_armor = function(self, player)
	local name, player_inv, armor_inv, pos = armor:get_valid_player(player, "[update_armor]")
	if not name then
		return
	end
	local hp = player:get_hp() or 0
	if ARMOR_FIRE_PROTECT == true then
		pos.y = pos.y + 1.4 -- head level
		local node_head = minetest.get_node(pos).name
		pos.y = pos.y - 1.2 -- feet level
		local node_feet = minetest.get_node(pos).name
		-- is player inside a hot node?
		for _, row in ipairs(ARMOR_FIRE_NODES) do
			-- check for fire protection, if not enough then get hurt
			if row[1] == node_head or row[1] == node_feet then
				if hp > 0 and armor.def[name].fire < row[2] then
					hp = hp - row[3] * ARMOR_UPDATE_TIME
					player:set_hp(hp)
					break
				end
			end
		end
	end
	if hp <= 0 or hp == self.player_hp[name] then
		return
	end
	if self.player_hp[name] > hp then
		local heal_max = 0
		local state = 0
		local items = 0
		for i = 1, 5 do
			local stack = player_inv:get_stack("armor", i)
			if stack:get_count() > 0 then
				local clothes = stack:get_definition().groups["clothes"] or 0
				local use = stack:get_definition().groups["armor_use"] or 0
				local heal = stack:get_definition().groups["armor_heal"] or 0
				local item = stack:get_name()
				stack:add_wear(use)
				armor_inv:set_stack("armor", i, stack)
				player_inv:set_stack("armor", i, stack)
				state = state + stack:get_wear()
				if clothes ~= 1 then
					items = items + 1
				end
				if stack:get_count() == 0 then
					local desc = minetest.registered_items[item].description
					if desc then
						minetest.chat_send_player(name, desc.." "..SL("got destroyed!"))
					end
					self:set_player_armor(player)
					armor:update_inventory(player)
				end
				heal_max = heal_max + heal
			end
		end
		self.def[name].state = state
		self.def[name].count = items
		heal_max = heal_max * ARMOR_HEAL_MULTIPLIER
		if heal_max > math.random(100) then
			player:set_hp(self.player_hp[name])
			return
		end
	end
	self.player_hp[name] = hp
end

armor.get_valid_player = function(self, player, msg)
	msg = msg or ""
	if not player then
		minetest.log("error", "lottarmor: Player reference is nil "..msg)
		return
	end
	local name = player:get_player_name()
	if not name then
		minetest.log("error", "lottarmor: Player name is nil "..msg)
		return
	end
	local pos = player:get_pos()
	local player_inv = player:get_inventory()
	local armor_inv = minetest.get_inventory({type="detached", name=name.."_armor"})
	if not pos then
		minetest.log("error", "lottarmor: Player position is nil "..msg)
		return
	elseif not player_inv then
		minetest.log("error", "lottarmor: Player inventory is nil "..msg)
		return
	elseif not armor_inv then
		minetest.log("error", "lottarmor: Detached armor inventory is nil "..msg)
		return
	end
	return name, player_inv, armor_inv, pos
end

-- Register Callbacks

races.register_init_callback(function(name, race, gender, skin, texture, face)
	minetest.log("Join player "..name..": "..race.." "..gender.." "..skin.." "..tostring(texture).." "..tostring(face))
	local joined_player = minetest.get_player_by_name(name)
	multiskin:init(joined_player, texture)
	local player_inv = joined_player:get_inventory()
	local armor_inv = minetest.create_detached_inventory(name.."_armor", {
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			armor:set_player_armor(player)
			armor:update_inventory(player)
			lottachievements.equip(stack, player, 1)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			armor:set_player_armor(player)
			armor:update_inventory(player)
			lottachievements.equip(stack, player, -1)
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			local p_inv = player:get_inventory()
			local stack = inv:get_stack(to_list, to_index)
			p_inv:set_stack(to_list, to_index, stack)
			p_inv:set_stack(from_list, from_index, nil)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end,
		allow_put = function(inv, listname, index, stack, player)
			if index == 1 then
				if stack:get_definition().groups.armor_head == nil then
					return 0
				else
					return 1
				end
			elseif index == 2 then
				if stack:get_definition().groups.armor_torso == nil then
					return 0
				else
					return 1
				end
			elseif index == 3 then
				if stack:get_definition().groups.armor_legs == nil then
					return 0
				else
					return 1
				end
			elseif index == 4 then
				if stack:get_definition().groups.armor_feet == nil then
					return 0
				else
					return 1
				end
			elseif index == 5 then
				if stack:get_definition().groups.armor_shield == nil then
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
	if inv_mod == "inventory_plus" then
		inventory_plus.register_button(joined_player,"armor", "Armor")
	end
	armor_inv:set_size("armor", 5)
	player_inv:set_size("armor", 5)
	for i = 1, 5 do
		local stack = player_inv:get_stack("armor", i)
		armor_inv:set_stack("armor", i, stack)
	end

	--Bags
	local bags_inv = minetest.create_detached_inventory(name.."_bags",{
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
			if player:get_inventory():is_empty(listname.."contents")==true then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	}, name)
	for i=1,4 do
		local bag = "bag"..i
		player_inv:set_size(bag, 1)
		bags_inv:set_size(bag, 1)
		bags_inv:set_stack(bag,1,player_inv:get_stack(bag,1))
	end

	armor.player_hp[name] = 0
	armor.def[name] = {
		state = 0,
		count = 0,
		level = 0,
		heal = 0,
		jump = 1,
		speed = 1,
		gravity = 1,
		fire = 0,
		page = "main",
	}
	armor.textures[name] = {
		armor = "lottarmor_trans.png",
		preview = "character_preview.png"
	}
	for i=1, ARMOR_INIT_TIMES do
		minetest.after(ARMOR_INIT_DELAY * i, function(player)
			armor:set_player_armor(player)
			if not inv_mod and not minetest.settings:get_bool("creative_mode") then
				armor:update_inventory(player)
			end
		end, joined_player)
	end
	races.update_player(name, {race, gender}, skin)
end)

if ARMOR_DROP == true or ARMOR_DESTROY == true then
	armor.drop_armor = function(pos, stack)
		local obj = minetest.add_item(pos, stack)
		if obj then
			obj:setvelocity({x=math.random(-1, 1), y=5, z=math.random(-1, 1)})
		end
	end
end

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > ARMOR_UPDATE_TIME then
		for _,player in ipairs(minetest.get_connected_players()) do
			armor:update_armor(player)
		end
		time = 0
	end
end)

races.register_update_callback(function(name, race, gender, skin, texture, face)
	local player = minetest.get_player_by_name(name)
	minetest.log("Updating player "..name..": "..race.." "..gender.." "..skin.." "..tostring(texture).." "..tostring(face))
	multiskin[name].skin = texture
	armor:set_player_armor(player)
	armor:update_inventory(player)
	multiskin:update_player_visuals(player)
end)
