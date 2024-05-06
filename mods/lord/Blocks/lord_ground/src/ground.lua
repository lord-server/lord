local api    = require("ground.api")
local config = require("ground.config")


ground = {} -- luacheck: ignore unused global variable ground

local function register_api()
	_G.ground = api
end

local function register_lord_dirts()
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
	--api.dirt.add_existing("default:permafrost")
	--api.dirt.add_existing("default:permafrost_with_stones")
	--api.dirt.add_existing("default:permafrost_with_moss")

	for name, dirt in pairs(config.dirts) do
		dirt.softness   = dirt.softness or 3
		dirt.definition = dirt.definition or {}
		api.dirt.register_dirt(name, dirt.softness, dirt.definition)
	end
end

local function register_lord_sands()
	api.sand.add_existing("default:sand")
	api.sand.add_existing("default:desert_sand")
	api.sand.add_existing("default:silver_sand")
	--api.sand.register_sand("lottmapgen:mordor_sand")
end


return {
	init = function()
		register_api()
		register_lord_dirts()
		register_lord_sands()
	end,
}
