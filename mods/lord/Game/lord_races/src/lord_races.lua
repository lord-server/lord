local Name       = require('lord_races.Name')
local Race       = require('lord_races.Race')
local Collection = require('lord_races.Collection')
local config     = require('lord_races.config')


lord_races = {} -- luacheck: ignore unused global variable lord_races

local function register_api()
	_G.lord_races = {
		--- @type lord_races.Name
		Name = Name,
		--- @type lord_races.Race
		Race = Race,

		register = function(definition)
			Collection.add(Race:new(definition))
		end,

		--- @return lord_races.Race[]
		get_all = function()
			return Collection.all
		end,
		--- @return lord_races.Race[]
		get_player_races = function()
			return Collection.player_races
		end,
		--- @return lord_races.Race[]
		get_mobs_races = function()
			return Collection.mob_races
		end,
		--- @param name string
		--- @return boolean
		has_player_race = function(name)
			return Collection.player_races[name] ~= nil
		end
	}
end

local function register_races()
	for for_whom, races in pairs(config) do
		for _, race_definition in pairs(races) do
			lord_races.register(race_definition)
		end
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
		register_races()
	end,
}
