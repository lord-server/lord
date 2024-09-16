local ipairs
    = ipairs

--- @type table<number,string>|string[]
local PHYSICS_TYPES = { "jump", "speed", "gravity" }

--- @param player        Player
local function collect_physics_from_armor(player)
	local physics = { speed = 1, gravity = 1, jump = 1 }
	for _, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			for _, type in ipairs(PHYSICS_TYPES) do
				local value = item_groups["physics_" .. type]
				if value then
					physics[type] = (physics[type] or 1) + value
				end
			end
		end
	end

	return physics
end

--- @param player Player
local function set_player_physics(player)
	local physics_o = collect_physics_from_armor(player)

	physics.for_player(player):set(physics_o)
end


return {
	init = function()
		equipment.on_load(equipment.Kind.ARMOR, function(player)
			set_player_physics(player)
		end)
		equipment.on_change(equipment.Kind.ARMOR, function(player)
			set_player_physics(player)
		end)
	end,
}
