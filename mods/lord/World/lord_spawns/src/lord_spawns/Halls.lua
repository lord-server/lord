local S = minetest.get_mod_translator()


--- @class lord_spawns.Halls
local Halls = {
	--- @private
	--- @type lord_spawns.Config.halls
	config = nil,
}

--- @private
--- @param config lord_spawns.Config.halls
function Halls.validate(config)
	for name, hall in pairs(config) do
		assert(
			table.is_position(hall.position),
			'Invalid `.position` for Hall ' .. name .. '. Expected `{ x:number, y:number, z:number }`.'
		)
		assert(
			hall.description and type(hall.description) == 'string',
			'Invalid `.description` for Hall ' .. name .. '. It must be configured as any string.'
		)
	end
end

--- @param config lord_spawns.Config.halls.HallDefinition
--- @return lord_spawns.Halls
function Halls.configure(config)
	Halls.validate(config)
	Halls.config = config

	return Halls
end

--- @overload fun(hall:string, definition:lord_spawns.Config.halls.HallDefinition)
--- @param name       string
--- @param definition lord_spawns.Config.halls.HallDefinition
--- @param remember   boolean
--- @return lord_spawns.Halls
function Halls.register(name, definition, remember)
	if remember and not Halls.config[name] then
		Halls.config[name] = definition
	end

	minetest.register_chatcommand(name, {
		description = S('Teleport to the @1', S(definition.description)),
		func = function(player_name, _)
			local teleported = Halls.teleport_to(minetest.get_player_by_name(player_name), name)
			if teleported then
				return true, S('Teleporting to the @1 ...', S(definition.description))
			end
			return false, S('Teleport failed')
		end
	})

	return Halls
end

--- @return lord_spawns.Halls
function Halls.register_configured()
	for name, hall in pairs(Halls.config) do
		Halls.register(name, hall)
	end

	return Halls
end

--- @param hall string
--- @return Position
function Halls.position_of(hall)
	return Halls.config[hall].position
end

--- Moves the `player` to hall named `hall` & returns actual teleportation location.
--- @param player Player player to teleport to hall.
--- @param hall   string name of the hall.
--- @return boolean,Position @`false,nil` if `hall` not found; `true` & actual tp Position
function Halls.teleport_to(player, hall)
	local position = Halls.position_of(hall)
	if not position then
		return false, nil
	end

	player:set_pos(position)

	return true, position
end


return Halls
