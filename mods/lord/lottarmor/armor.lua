local ipairs
    = ipairs


--- @type table<number,string>|string[]
local PHYSICS_TYPES = { "jump", "speed", "gravity" }


armor = {
	def       = {},
}


equipment.on_change(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
	armor:set_player_physics(player)
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



--- @param player Player
function armor:set_player_physics(player)
	local name = player:get_player_name()
	if not name then
		return
	end

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

	armor:set_player_physics(player)
end)

