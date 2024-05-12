local mordor_from = minetest.settings:get("lord_ground.mordor_lands.from"):split(",")
local mordor_to   = minetest.settings:get("lord_ground.mordor_lands.to"):split(",")


--- @class ground.Config
local config = {
	dirts = {
		biome = {
			-- name                         = {softness [= 3], title, definition [= {}] },
			["lord_ground:dirt_dunland"]    = { softness = 3, },
			["lord_ground:dirt_fangorn"]    = { softness = 3, },
			["lord_ground:dirt_gondor"]     = { softness = 3, },
			["lord_ground:dirt_iron_hills"] = { softness = 3, },
			["lord_ground:dirt_ithilien"]   = { softness = 3, },
			["lord_ground:dirt_lorien"]     = { softness = 3, },
			["lord_ground:dirt_mirkwood"]   = { softness = 3, },
			["lord_ground:dirt_rohan"]      = { softness = 3, },
			["lord_ground:dirt_shire"]      = { softness = 3, },
		},
		mixed = {
			-- name                     = { craft_from = "<mod>:<node>",   softness = n, definition [= {}] },
			["lord_ground:coarse_dirt"] = { craft_from = "default:gravel", softness = 2, definition = {
				groups = { soil = 1 },
				soil  = { wet = "<fake>", dry = "default:dirt" }
			} },
			["lord_ground:stony_dirt"]  = { craft_from = "default:cobble", softness = 1, definition = {
				groups = { soil = 1 },
				soil  = { wet = "<fake>", dry = "lord_ground:coarse_dirt" }
			} },
		},
	},
	--sand = {
		-- mordor
	--},
	mordor_lands = {
		from          = { x = tonumber(mordor_from[1]), z = tonumber(mordor_from[2]) },
		to            = { x = tonumber(mordor_to[1]), z = tonumber(mordor_to[2]) },
		exclude_dirts = { "lord_ground:dirt_dunland", "lord_ground:dirt_mirkwood" },
		covers_with   = { "lord_rocks:mordor_stone", "lord_ground:coarse_dirt", "lord_ground:stony_dirt" },
	},
}


return config
