local math_floor, string_match, ipairs
    = math.floor, string.match, ipairs


--- @type table<number,string>|string[]
local PHYSICS_TYPES = { "jump", "speed", "gravity" }
--- @type table<number,string>|string[]
local ARMOR_PURPOSE = { "head", "torso", "legs", "feet", "shield" }

-- Armor API

armor = {
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
	local armor_level     = 0
	local armor_dmg_avoid = 0
	local armor_fire      = 0
	local armor_wear      = 0
	local armor_count     = 0

	local material = { type = nil, count = 1 } -- detection of same material armor-set

	for slot, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			armor_level     = armor_level + (item_groups["armor_" .. ARMOR_PURPOSE[slot]] or 0)
			armor_wear      = armor_wear + stack:get_wear()
			armor_count     = armor_count + 1
			armor_dmg_avoid = armor_dmg_avoid + (item_groups["damage_avoid_chance"] or 0)
			armor_fire      = armor_fire + (item_groups["armor_fire"] or 0)
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

	return armor_level, armor_dmg_avoid, armor_fire, armor_wear, armor_count,
		(material.type and material.count == #ARMOR_PURPOSE)
end

local function rebuild_armor_groups(player, armor_level)
	local immortal = player:get_armor_groups().immortal
	if player:get_meta():get("lott:immunity") ~= nil and (not immortal or immortal == 0) then
		return {fleshy = 1}
	end

	local armor_groups = {fleshy=100}
	if immortal and immortal ~= 0 then
		armor_groups.immortal = 1
	end
	if armor_level > 0 then
		armor_groups.level = math_floor(armor_level / 20)
		armor_groups.fleshy = 100 - armor_level
	end

	return armor_groups
end

--- @param player Player
function armor:set_player_armor(player)
	local name = player:get_player_name()
	if not name then
		return
	end

	local armor_level, armor_dmg_avoid, armor_fire, armor_wear, armor_count, same_material_set = collect_armor_data(player)

	if same_material_set then
		armor_level = armor_level * 1.1
	end

	player:set_armor_groups(rebuild_armor_groups(player, armor_level))

	self.def[name].state     = armor_wear
	self.def[name].count     = armor_count
	self.def[name].level     = armor_level
	self.def[name].dmg_avoid = armor_dmg_avoid
	self.def[name].fire      = armor_fire

	local physics_o = collect_physics(player)
	player:set_physics_override(physics_o)
	self.def[name].jump    = physics_o.jump
	self.def[name].speed   = physics_o.speed
	self.def[name].gravity = physics_o.gravity
end


-- Register Callbacks
equipment.on_load(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
	local name = player:get_player_name()
	armor.def[name] = {
		state     = 0,
		count     = 0,
		level     = 0,
		dmg_avoid = 0,
		jump      = 1,
		speed     = 1,
		gravity   = 1,
		fire      = 0,
	}

	armor:set_player_armor(player)
end)

