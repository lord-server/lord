local ipairs
    = ipairs


--- @type table<number,string>|string[]
local PHYSICS_TYPES = { "jump", "speed", "gravity" }

--- @type table<string,{jump:number,speed:number,gravity:number}>
local player_physics = {}

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
local function set_player_physics(player)
	local name = player:get_player_name()
	if not name then
		return
	end

	local physics_o = collect_physics(player)
	player:set_physics_override(physics_o)
	player_physics[name].jump    = physics_o.jump
	player_physics[name].speed   = physics_o.speed
	player_physics[name].gravity = physics_o.gravity
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		equipment.on_load(equipment.Kind.ARMOR, function(player)
			player_physics[player:get_player_name()] = {
				jump      = 1,
				speed     = 1,
				gravity   = 1,
			}

			set_player_physics(player)
		end)
		equipment.on_change(equipment.Kind.ARMOR, function(player)
			set_player_physics(player)
		end)
		minetest.register_on_leaveplayer(function(player)
			player_physics[player:get_player_name()] = nil
		end)
	end,
}

