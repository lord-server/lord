local SL = minetest.get_translator("lottarmor")

local ARMOR_INIT_DELAY = 1
local ARMOR_UPDATE_TIME = 1

-- Armor API

armor = {
	player_hp = {},
	elements  = { "head", "torso", "legs", "feet", "shield" },
	def       = { state = 0, count = 0 },
}


equipment.on_change(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
	armor:set_player_armor(player)
end)

--- @type table<number,string>|string[]
local PHYSICS_TYPES = { "jump", "speed", "gravity" }
--- @param player        Player
local function collect_physics(player)
	local physics = { speed = 1, gravity = 1, jump = 1 }
	for _, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			for _, type in ipairs(PHYSICS_TYPES) do
				local value = item_groups["physics_" .. type]
				if value then
					physics[type] = physics[type] + value
				end
			end
		end
	end

	return physics
end

--- @param player Player
function armor:set_player_armor(player)
	local name = player:get_player_name()
	if not name then
		return
	end
	local armor_level = 0
	local armor_heal  = 0
	local armor_fire  = 0
	local armor_wear  = 0
	local armor_count = 0
	local material    = { type = nil, count = 1 } -- detection of same material armor-set

	for slot, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			armor_level = armor_level + item_groups["armor_" .. self.elements[slot]]
			armor_wear  = armor_wear + stack:get_wear()
			armor_count = armor_count + 1
			armor_heal  = armor_heal + (item_groups["armor_heal"] or 0)
			armor_fire = armor_fire + (item_groups["armor_fire"] or 0)
			local mat = string.match(stack:get_name(), "%:.+_(.+)$")
			if material.type then
				if material.type == mat then
					material.count = material.count + 1
				end
			else
				material.type = mat
			end
		end
	end
	if material.type and material.count == #self.elements then
		armor_level = armor_level * 1.1
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

	self.def[name].state = armor_wear
	self.def[name].count = armor_count
	self.def[name].level = armor_level
	self.def[name].heal = armor_heal
	self.def[name].fire = armor_fire

	local physics_o = collect_physics(player)
	player:set_physics_override(physics_o)
	self.def[name].jump = physics_o.jump
	self.def[name].speed = physics_o.speed
	self.def[name].gravity = physics_o.gravity
end

local handle_armor_wear = function(player)
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	local armor_inv = minetest.get_inventory({type="detached", name=name.."_armor"})
	if not name then
		return
	end
	local hp = player:get_hp() or 0
	if hp <= 0 or hp == armor.player_hp[name] then
		return
	end
	if armor.player_hp[name] > hp then
		local heal_max = 0
		local wear     = 0
		local items    = 0
		for slot, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
			if stack:get_count() > 0 then
				local clothes = stack:get_definition().groups["clothes"] or 0
				local use = stack:get_definition().groups["armor_use"] or 0
				local heal = stack:get_definition().groups["armor_heal"] or 0
				local item = stack:get_name()
				stack:add_wear(use)
				armor_inv:set_stack("armor", slot, stack)
				player_inv:set_stack("armor", slot, stack)
				wear = wear + stack:get_wear()
				if clothes ~= 1 then
					items = items + 1
				end
				if stack:get_count() == 0 then
					local desc = minetest.registered_items[item].description
					if desc then
						minetest.chat_send_player(name, desc.." "..SL("got destroyed!"))
					end
					-- TODO remove item by `equipment.for_player(player):delete()` to trigger all callbacks
					armor:set_player_armor(player)
					--inventory.update(player) -- see to-do (now inventory preview on wear not updated)
				end
				heal_max = heal_max + heal
			end
		end
		armor.def[name].state = wear
		armor.def[name].count = items
		if heal_max > math.random(100) then
			player:set_hp(armor.player_hp[name])
			return
		end
	end
	armor.player_hp[name] = hp
end


-- Register Callbacks

races.register_init_callback(function(name, race, gender, skin, texture, face)
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
	}

	local joined_player = minetest.get_player_by_name(name)
	minetest.after(ARMOR_INIT_DELAY, function(player)
		armor:set_player_armor(player)
	end, joined_player)
end)

local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > ARMOR_UPDATE_TIME then
		for _,player in ipairs(minetest.get_connected_players()) do
			handle_armor_wear(player)
		end
		time = 0
	end
end)
