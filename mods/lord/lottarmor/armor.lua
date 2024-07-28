local math_random, math_floor, string_match, ipairs
    = math.random, math.floor, string.match, ipairs


local ARMOR_UPDATE_TIME = 1

--- @type table<number,string>|string[]
local PHYSICS_TYPES = { "jump", "speed", "gravity" }
--- @type table<number,string>|string[]
local ARMOR_PURPOSE = { "head", "torso", "legs", "feet", "shield" }

-- Armor API

armor = {
	player_hp = {},
	def       = {},
}


equipment.on_change(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
	armor:set_player_armor(player)
end)

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

local function collect_armor_data(player)
	local armor_level = 0
	local armor_heal  = 0
	local armor_fire  = 0
	local armor_wear  = 0
	local armor_count = 0
	local material    = { type = nil, count = 1 } -- detection of same material armor-set

	for slot, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			armor_level = armor_level + (item_groups["armor_" .. ARMOR_PURPOSE[slot]] or 0)
			armor_wear  = armor_wear + stack:get_wear()
			armor_count = armor_count + 1
			armor_heal  = armor_heal + (item_groups["armor_heal"] or 0)
			armor_fire = armor_fire + (item_groups["armor_fire"] or 0)
			local mat = string_match(stack:get_name(), "%:.+_(.+)$")
			if material.type then
				if material.type == mat then
					material.count = material.count + 1
				end
			else
				material.type = mat
			end
		end
	end

	return armor_level, armor_heal, armor_fire, armor_wear, armor_count,
		(material.type and material.count == #ARMOR_PURPOSE)
end

local function rebuild_armor_groups(player, armor_level)
	local armor_groups = {fleshy=100}
	local immortal = player:get_armor_groups().immortal
	if immortal and immortal ~= 0 then
		armor_groups.immortal = 1
	end
	if armor_level > 0 then
		armor_groups.level = math_floor(armor_level / 20)
		armor_groups.fleshy = 100 - armor_level
	end
	if player:get_meta():get("lott:immunity") ~= nil and (not immortal or immortal == 0) then
		return {fleshy = 1}
	end

	return armor_groups
end

--- @param player Player
function armor:set_player_armor(player)
	local name = player:get_player_name()
	if not name then
		return
	end

	local armor_level, armor_heal, armor_fire, armor_wear, armor_count, same_material_set = collect_armor_data(player)

	if same_material_set then
		armor_level = armor_level * 1.1
	end

	player:set_armor_groups(rebuild_armor_groups(player, armor_level))

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

--- @param player Player
local function get_armor_healing_chance(player)
	local armor_healing_chance = 0
	for _, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() > 0 then
			armor_healing_chance = armor_healing_chance + (stack:get_definition().groups["armor_heal"] or 0)
		end
	end
end

local handle_armor_heal = function(player)
	local name = player:get_player_name()
	if not name then
		return
	end

	local hp = player:get_hp() or 0
	if hp <= 0 or hp == armor.player_hp[name] then
		return
	end
	if armor.player_hp[name] > hp then -- only on punch


		local armor_healing_chance = get_armor_healing_chance(player)
		if math_random(100) < armor_healing_chance then
			player:set_hp(armor.player_hp[name])
			return
		end


	end
	armor.player_hp[name] = hp
end


-- Register Callbacks
equipment.on_load(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
	local name = player:get_player_name()
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

	armor:set_player_armor(player)
end)


minetest.foreach_player_every(ARMOR_UPDATE_TIME, handle_armor_heal)
