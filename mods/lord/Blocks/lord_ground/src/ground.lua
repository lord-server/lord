local spreading = require("ground.spreading")
local api       = require("ground.api")
local config    = require("ground.config")


ground = {} -- luacheck: ignore unused global variable ground

local function register_api()
	_G.ground = api
end

local function register_dirts()
	--- Also we use:
	---  - Simple dirt from MTG (`default:dirt`)
	---  - ... from MTG (`default:...`)
	api.dirt.add_existing("default:dirt")
	api.dirt.add_existing("default:dirt_with_grass")
	api.dirt.add_existing("default:dirt_with_grass_footsteps")
	api.dirt.add_existing("default:dirt_with_dry_grass")
	api.dirt.add_existing("default:dirt_with_snow")
	api.dirt.add_existing("default:dirt_with_rainforest_litter")
	api.dirt.add_existing("default:dirt_with_coniferous_litter")
	api.dirt.add_existing("default:dry_dirt")
	api.dirt.add_existing("default:dry_dirt_with_dry_grass")
	--- This nodes we remove in `mods/lord/_overwrites/MTG/default`:
	--api.dirt.add_existing("default:permafrost")
	--api.dirt.add_existing("default:permafrost_with_stones")
	--api.dirt.add_existing("default:permafrost_with_moss")

	for name, dirt in pairs(config.dirts.biome) do
		dirt.softness   = dirt.softness or 3
		dirt.title      = dirt.title or nil
		dirt.definition = dirt.definition or {}
		api.dirt.register_biome_dirt(name, dirt.softness, dirt.title, dirt.definition)
	end
end

local function register_additional_dirts()
	for name, dirt in pairs(config.dirts.mixed) do
		dirt.definition = dirt.definition or {}
		api.dirt.register_mixed_dirt(name, dirt.craft_from, dirt.softness, dirt.title, dirt.definition)
	end
end

local function register_lord_sands()
	api.sand.add_existing("default:sand")
	api.sand.add_existing("default:desert_sand")
	api.sand.add_existing("default:silver_sand")

	api.sand.register_sand("lord_ground:mordor_sand", 3)
end

local function deferred_register_spreading_abms()
	--- At this time, when this mod loaded & first executed,
	--- not all nodes registered yet, because some mods can be loaded later
	--- and will register theirs ground nodes later, than this code executed.
	--- So we need deferred registration of ABMs, when all mods already loaded.
	spreading.deferred_register_mordor_lands_abm(api, config)
end


return {
	init = function()
		register_api()
		register_dirts()
		register_additional_dirts()
		register_lord_sands()
		deferred_register_spreading_abms()
	end,
}
