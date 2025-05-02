local mod_settings  = minetest.get_mod_settings()

--- @class lord_spawns.Config.halls.HallDefinition
--- @field position    Position
--- @field description string

--- @alias lord_spawns.Config.spawns table<string,Position>
--- @alias lord_spawns.Config.halls  table<string,lord_spawns.Config.halls.HallDefinition>

--- @class lord_spawns.Config
local Config = {
	--- Loaded from settings with prefix `lord_spawns.racial.`, has the following struct:
	--- ```
	--- {
	---     [lord_races.Name.ELF] = racial_spawns:get_position(lord_races.Name.ELF)   -- { x=.., y=.., z=.. }
	---     ...
	--- ```
	---
	--- @type lord_spawns.Config.spawns
	spawns = {},
	--- Loaded from settings with prefix `lord_spawns.halls.`, has the following struct:
	--- ```
	--- {
	---     ['center'] = {
	---         position    = halls:get_position('center'),     -- { x=.., y=.., z=.. }
	---         description = '...',
	---     ...
	--- ```
	---
	--- @type lord_spawns.Config.halls
	halls  = {},

	--- @type boolean
	dynamic_spawns = not minetest.is_singleplayer() and mod_settings:get_bool('dynamic_spawns', false),

	--- @type Position
	common_spawn_pos = mod_settings:get_position('common_spawn_pos'),
}

--- @private
--- @static
--- @param to_config              table<string,Position>
--- @param settings_group         Voxrame.SettingsGroup
--- @return lord_spawns.Config
function Config.load_to(to_config, settings_group)
	for key, value in pairs(settings_group:all()) do
		if key == 'position' then
			to_config['position'] = settings_group:get_position(key)
		elseif key:ends_with('_pos') then
			to_config[key:replace('_pos$', '')] = settings_group:get_position(key)
		elseif key:contains('.') then
			local sub_key = key:split('.', false, 1)[1]
			if not to_config[sub_key] then
				to_config[sub_key] = {}
				Config.load_to(to_config[sub_key], settings_group:group(sub_key))
			end
		else
			to_config[key] = value
		end
	end

	return Config
end

--- @private
--- @static
--- @return lord_spawns.Config
function Config.load()
	return Config
		.load_to(Config.spawns, mod_settings:group('racial'))
		.load_to(Config.halls,  mod_settings:group('halls'))
end


return Config.load()
