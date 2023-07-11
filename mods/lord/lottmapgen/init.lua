local math_random, math_floor, math_abs, math_ceil, os_clock, pairs, type, id
	= math.random, math.floor, math.abs, math.ceil, os.clock, pairs, type, minetest.get_content_id

-- paragenv7 0.3.1 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default
-- Licenses: code WTFPL, textures CC BY-SA

-- new in 0.3.1:
-- ice varies thickness with temp
-- dirt as papyrus bed, check for water below papyrus
-- clay at mid-temp
-- 'is ground content' false for leaves only

-- Parameters

local HITET = 0.4 -- High temperature threshold
local LOTET = -0.4 -- Low ..
local ICETET = -0.8 -- Ice ..
local HIHUT = 0.4 -- High humidity threshold
local LOHUT = -0.4 -- Low ..
local HIRAN = 0.4
local LORAN = -0.4

local PAPCHA = 3 -- Papyrus
local DUGCHA = 5 -- Dune grass

--Rarity for Trees

local TREE1 = 30
local TREE2 = 50
local TREE3 = 100
local TREE4 = 200
local TREE5 = 300
local TREE6 = 500
local TREE7 = 750
local TREE8 = 1000
local TREE9 = 2000
local TREE10 = 5000

--Rarity for Plants

local PLANT1 = 3
local PLANT2 = 5
local PLANT3 = 10
local PLANT4 = 20
local PLANT5 = 50
local PLANT6 = 100
local PLANT7 = 200
local PLANT8 = 500
local PLANT9 = 750
local PLANT10 = 1000
local PLANT11 = 2000
local PLANT12 = 5000
local PLANT13 = 10000

-- Biomes:
local BIOME_ANGMAR     = 1  -- (Angmar)
local BIOME_SNOWPLAINS = 2  -- (Snow-plains)
local BIOME_TROLLSHAWS = 3  -- (Trollshaws)
local BIOME_DUNLANDS   = 4  -- (Dunlands)
local BIOME_GONDOR     = 5  -- (Gondor)
local BIOME_ITHILIEN   = 6  -- (Ithilien)
local BIOME_LORIEN     = 7  -- (Lorien)
local BIOME_MORDOR     = 8  -- (Mordor)
local BIOME_FANGORN    = 9  -- (Fangorn)
local BIOME_MIRKWOOD   = 10 -- (Mirkwood)
local BIOME_HILLS      = 11 -- (Iron Hills)
local BIOME_ROHAN      = 12 -- (Rohan)
local BIOME_SHIRE      = 13 -- (Shire)


-- 2D noise for temperature

local np_temp = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 9130,
	octaves = 3,
	persist = 0.5
}

-- 2D noise for humidity

local np_humid = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = -5500,
	octaves = 3,
	persist = 0.5
}

local np_random = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 4510,
	octaves = 3,
	persist = 0.5
}

-- Stuff
lottmapgen = {}
local water_level = minetest.get_mapgen_setting("water_level")

local measure = minetest.settings:get_bool("mapgen_measure_chunk_gene_time", false)
local chunk_gen_count = 0
local chunk_gen_avg = 0

dofile(minetest.get_modpath("lottmapgen").."/nodes.lua")
dofile(minetest.get_modpath("lottmapgen").."/functions.lua")
dofile(minetest.get_modpath("lottmapgen").."/schematics.lua")


local function detect_current_biome(n_temp, n_humid, n_ran)
	local biome = 0
	if n_temp < LOTET then
		if n_humid < LOHUT then
			biome = 1 -- (Angmar)
		elseif n_humid > HIHUT then
			biome = 3 -- (Trollshaws)
		else
			biome = 2 -- (Snowplains)
		end
	elseif n_temp > HITET then
		if n_humid < LOHUT then
			biome = 7 -- (Lorien)
		elseif n_humid > HIHUT then
			biome = 9 -- (Fangorn)
		elseif n_ran < LORAN then
			biome = 10 -- (Mirkwood)
		elseif n_ran > HIRAN then
			biome = 11 -- (Iron Hills)
		else
			biome = 4 -- (Dunlands)
		end
	else
		if n_humid < LOHUT then
			biome = 8 -- (Mordor)
		elseif n_humid > HIHUT then
			biome = 6 -- (Ithilien)
		elseif n_ran < LORAN then
			biome = 13 -- (Shire)
		elseif n_ran > HIRAN then
			biome = 12 -- (Rohan)
		else
			biome = 5 -- (Gondor)
		end
	end

	return biome
end

--- @param air table above ground config to filling biome airspace with flora/buildings/...
--- @param vm_area VoxelArea voxel map part manipulator
--- @param vm_data table array of node content IDs
--- @param index number node position index in `vm_data`
--- @return boolean whether it was filled or not
local function biome_fill_air(air, vm_area, vm_data, index)
	if type(air) == "number" then
		vm_data[index] = air
		return true
	end

	for node_id, rarity in pairs(air.flora.plants) do
		if math_random(rarity) == 1 then
			if type(node_id) == "function" then
				node_id(vm_data, index)
			else
				vm_data[index] = node_id
			end
			return true
		end
	end

	for tree, rarity in pairs(air.flora.trees) do
		if math_random(rarity) == 1 then
			if type(tree) == "function" then
				local pos = vm_area:position(index)
				tree(pos.x, pos.y, pos.z, vm_area, vm_data)
			else
				vm_data[index] = tree -- tree generation node id ()
			end
			return true
		end
	end

	for node_id, rarity in pairs(air.buildings) do
		if math_random(rarity) == 1 then
			vm_data[index] = node_id
			return true
		end
	end

	return false
end

local c_air = id("air")

local c_sand = id("default:sand")
local c_mordor_sand = id("lottmapgen:mordor_sand")
local c_desert_sand = id("default:desert_sand")
local c_silver_sand = id("default:silver_sand")

local c_ice = id("default:ice")
local c_dirt = id("default:dirt")
local c_dryshrub = id("default:dry_shrub")
local c_clay = id("default:clay")
local c_stone = id("default:stone")
local c_desertstone = id("default:desert_stone")
local c_stonecopper = id("default:stone_with_copper")
local c_stoneiron = id("default:stone_with_iron")
local c_stonecoal = id("default:stone_with_coal")
local c_water = id("default:water_source")
local c_river_water = id("default:river_water_source")
local c_morwat = id("lottmapgen:blacksource")
local c_morrivwat = id("lottmapgen:black_river_source")

local c_morstone = id("lottmapgen:mordor_stone")

local c_salt = id("lottores:mineral_salt")
local c_pearl = id("lottores:mineral_pearl")


local c_angsnowblock = id("lottmapgen:angsnowblock")
local c_frozenstone  = id("lottmapgen:frozen_stone")
local biome_grass    = {
	[BIOME_ANGMAR] = function()
		local block_id = c_angsnowblock
		if math_random(121) == 2 then
			block_id = c_ice
		elseif math_random(25) == 2 then
			block_id = c_frozenstone
		end
		return block_id
	end,
	[BIOME_SNOWPLAINS] = id("default:dirt_with_snow"), -- additionally covers with "default:snowblock" (see below)
	[BIOME_TROLLSHAWS] = id("default:dirt_with_snow"),
	[BIOME_DUNLANDS] = id("lottmapgen:dunland_grass"),
	[BIOME_GONDOR] = id("lottmapgen:gondor_grass"),
	[BIOME_ITHILIEN] = id("lottmapgen:ithilien_grass"),
	[BIOME_LORIEN] = id("lottmapgen:lorien_grass"),
	[BIOME_MORDOR] = id("lottmapgen:mordor_stone"),
	[BIOME_FANGORN] = id("lottmapgen:fangorn_grass"),
	[BIOME_MIRKWOOD] = id("lottmapgen:mirkwood_grass"),
	[BIOME_HILLS] = id("lottmapgen:ironhill_grass"),
	[BIOME_ROHAN] = id("lottmapgen:rohan_grass"),
	[BIOME_SHIRE] = id("lottmapgen:shire_grass"),
}
local biome_airspace = {
	[BIOME_ANGMAR] = {
		flora = {
			plants = {
				[id("default:dry_shrub")] = PLANT3,
				[id("lottplants:seregon")] = PLANT6,
			},
			trees = {
				[lottmapgen_pinetree] = TREE7,
				[lottmapgen_firtree]  = TREE8,
				[id("lottmapgen:beechgen")] = TREE10,
			},
		},
		buildings = {
			[id("lottmapgen:angmarfort")] = PLANT13,
		}
	},
	[BIOME_SNOWPLAINS] = id("default:snowblock"),
	[BIOME_TROLLSHAWS] = {
		flora = {
			plants = {
				[id("default:dry_shrub")] = PLANT3,
			},
			trees = {
				[lottmapgen_pinetree] = TREE4,
				[lottmapgen_firtree]  = TREE3,
				[id("lottmapgen:beechgen")] = TREE10,
			},
		},
		buildings = {},
	},
	[BIOME_DUNLANDS] = {
		flora = {
			plants = {
				[lottmapgen_grass] = PLANT3,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE5,
				[lottmapgen_appletree]   = TREE7,
			},
		},
		buildings = {},
	},
	[BIOME_GONDOR] = {
		flora = {
			plants = {
				[lottmapgen_grass] = PLANT3,
				[lottmapgen_farmingplants] = PLANT8,
				[lottmapgen_farmingrareplants] = PLANT13,
				[id("lottplants:mallos")] = PLANT6,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE7,
				[lottmapgen_aldertree] = TREE8,
				[lottmapgen_appletree] = TREE9,
				[lottmapgen_plumtree] = TREE8,
				[lottmapgen_elmtree] = TREE10,
				[lottmapgen_whitetree] = PLANT13,
			},
		},
		buildings = {
			[id("lottmapgen:gondorfort")] = PLANT13,
		},
	},
	[BIOME_ITHILIEN] = {
		flora = {
			plants = {
				[lottmapgen_farmingplants] = PLANT8,
				[id("lottplants:melon_wild")] = PLANT13,
				[lottmapgen_ithildinplants] = PLANT5,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE3,
				[lottmapgen_lebethrontree] = TREE6,
				[lottmapgen_appletree] = TREE3,
				[lottmapgen_culumaldatree] = TREE5,
				[lottmapgen_plumtree] = TREE5,
				[lottmapgen_elmtree] = PLANT9,
			},
		},
		buildings = {},
	},
	[BIOME_LORIEN] = {
		flora = {
			plants = {
				[lottmapgen_lorien_grass] = PLANT1,
				[lottmapgen_lorienplants] = PLANT4,
			},
			trees = {
				[lottmapgen_mallornsmalltree] = TREE3,
				[lottmapgen_young_mallorn] = TREE2,
				[id("lottmapgen:mallorngen")] = TREE5,
			},
		},
		buildings = {
			[id("lottmapgen:mallornhouse")] = PLANT13 * 2,
			[id("lottmapgen:lorienhouse")] = PLANT13 * 2,
		},
	},
	[BIOME_MORDOR] = {
		flora = {
			plants = {
				[id("lottplants:brambles_of_mordor")] = PLANT4,
			},
			trees = {
				[lottmapgen_burnedtree] = TREE9,
			},
		},
		buildings = {
			[id("lottmapgen:orcfort")] = PLANT13,
		},
	},
	[BIOME_FANGORN] = {
		flora = {
			plants = {
				[lottmapgen_farmingplants] = PLANT4,
				[id("lottplants:melon_wild")] = PLANT9,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE3,
				[lottmapgen_rowantree] = TREE4,
				[lottmapgen_appletree] = TREE4,
				[lottmapgen_birchtree] = TREE5,
				[lottmapgen_plumtree] = TREE5,
				[lottmapgen_elmtree] = TREE7,
				[lottmapgen_oaktree] = TREE6,
			},
		},
		buildings = {},
	},
	[BIOME_MIRKWOOD] = {
		flora = {
			plants = {},
			trees = {
				[id("lottmapgen:mirktreegen")] = TREE2,
				[lottmapgen_jungletree] = TREE4,
			},
		},
		buildings = {
			[id("lottmapgen:mirkhouse")] = PLANT13,
		},
	},
	[BIOME_HILLS] = {
		flora = {
			plants = {},
			trees = {
				[id("lottmapgen:beechgen")] = TREE10,
				[lottmapgen_pinetree] = TREE4,
				[lottmapgen_firtree] = TREE6,
			},
		},
		buildings = {},
	},
	[BIOME_ROHAN] = {
		flora = {
			plants = {
				[lottmapgen_grass] = PLANT2,
				[lottmapgen_farmingplants] = PLANT8,
				[id("lottplants:melon_wild")] = PLANT13,
				[id("lottplants:pilinehtar")] = PLANT6,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE7,
				[lottmapgen_appletree] = TREE7,
				[lottmapgen_plumtree] = TREE8,
				[lottmapgen_elmtree] = TREE10,
			},
		},
		buildings = {
			[id("lottmapgen:rohanfort")] = PLANT13,
		},
	},
	[BIOME_SHIRE] = {
		flora = {
			plants = {
				[lottmapgen_farmingplants] = PLANT7,
				[id("lottplants:melon_wild")] = PLANT9,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE7,
				[lottmapgen_appletree] = TREE7,
				[lottmapgen_plumtree] = TREE7,
				[lottmapgen_oaktree] = TREE7,
			},
		},
		buildings = {
			[id("lottmapgen:hobbithole")] = PLANT13,
		},
	},
}


-- On generated function
minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y < (water_level-1000) or minp.y > 5000 then
		return
	end

	local t1 = os_clock()

	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()

	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minposxz = {x=x0, y=z0}

	local nvals_temp = minetest.get_perlin_map(np_temp, chulens):get_2d_map_flat(minposxz)
	local nvals_humid = minetest.get_perlin_map(np_humid, chulens):get_2d_map_flat(minposxz)
	local nvals_random = minetest.get_perlin_map(np_random, chulens):get_2d_map_flat(minposxz)

	local nixz = 1
	for z = z0, z1 do
		for x = x0, x1 do -- for each column do
			local n_temp = nvals_temp[nixz] -- select biome
			local n_humid = nvals_humid[nixz]
			local n_ran = nvals_random[nixz]
			local biome = detect_current_biome(n_temp, n_humid, n_ran)

			local sandy = (water_level+2) + math_random(-1, 1) -- sandline
			local sandmin = (water_level-15) + math_random(-5, 0) -- lowest sand
			local open = true -- open to sky?
			local solid = true -- solid node above?
			local water = false -- water node above?
			local surfy = y1 + 80 -- y of last surface detected
			for y = y1, y0, -1 do -- working down each column for each node do
				local fimadep = math_floor(6 - y / 512) + math_random(0, 1)
				local vi = area:index(x, y, z)
				local nodid = data[vi]
				local viuu = area:index(x, y - 2, z)
				local nodiduu = data[viuu]
				local via = area:index(x, y + 1, z)
				local nodida = data[via]
				if nodid == c_stone -- if stone
				or nodid == c_stonecopper
				or nodid == c_stoneiron
				or nodid == c_stonecoal then
					if y > water_level-32 then
						if biome == BIOME_DUNLANDS or biome == BIOME_ROHAN then
							data[vi] = c_desertstone
						elseif biome == BIOME_MORDOR then
							data[vi] = c_morstone
						elseif biome == BIOME_HILLS then
							if math_random(3) == 1 then
								data[vi] = c_stoneiron
							end
						end
					end
					if not solid then -- if surface
						surfy = y
						if nodiduu ~= c_air and nodiduu ~= c_water and fimadep >= 1 then -- if supported by 2 stone nodes
							if nodida == c_river_water or data[area:index(x + 1, y, z)] == c_river_water
							or data[area:index(x, y, z + 1)] == c_river_water or data[area:index(x - 1, y, z)] == c_river_water
							or data[area:index(x, y, z - 1)] == c_river_water then
								if biome == BIOME_MORDOR then
									data[vi] = c_morstone
								else
									data[vi] = c_sand
								end
							elseif y <= sandy and y >= sandmin then -- sand
								if biome ~= BIOME_MORDOR and biome ~= BIOME_DUNLANDS and biome ~= BIOME_ROHAN and biome ~= BIOME_SNOWPLAINS and biome ~= BIOME_ANGMAR then
									if open and water and y == (water_level-1) and biome > 4 and math_random(PAPCHA) == 2 then -- papyrus
										lottmapgen_papyrus(x, (water_level+1), z, area, data)
										data[vi] = c_dirt
									elseif math_abs(n_temp) < 0.05 and y == (water_level-1) then -- clay
										data[vi] = c_clay
									elseif math_abs(n_temp) < 0.05 and y == (water_level-5) then -- salt
										data[vi] = c_salt
									elseif math_abs(n_temp) < 0.05 and y == (water_level-20) then -- pearl
										data[vi] = c_pearl
									else
										data[vi] = c_sand
									end
								else
									if biome == BIOME_MORDOR then
										data[vi] = c_mordor_sand
									elseif biome == BIOME_SNOWPLAINS or biome == BIOME_ANGMAR then
										data[vi] = c_silver_sand
									elseif biome == BIOME_DUNLANDS or biome == BIOME_ROHAN then
										data[vi] = c_desert_sand
									end
								end
								if open and y > (water_level + 4) + math_random(0, 1) and math_random(DUGCHA) == 2 and biome ~= BIOME_MORDOR and biome ~= BIOME_LORIEN then -- dune grass
									local vi = area:index(x, y + 1, z)
										data[vi] = c_dryshrub
									end
								elseif y <= sandmin then
									data[vi] = c_stone
								else -- above sandline
									local grass = biome_grass[biome]
									if type(grass) == "function" then
										grass = grass()
									end
									data[vi] = grass
								if open then -- if open to sky then flora
									local surf_vi = area:index(x, surfy + 1, z)
									biome_fill_air(biome_airspace[biome], area, data, surf_vi)
								end
							end
						end
					else -- underground
						if nodiduu ~= c_air and nodiduu ~= c_water and surfy - y + 1 <= fimadep then
							if y <= sandy and y >= sandmin then
								if biome ~= BIOME_MORDOR then
									data[vi] = c_sand
								end
							end
						end
					end
				open = false
				solid = true
				elseif nodid == c_air or nodid == c_water or nodid == c_river_water then
					solid = false
					if nodid == c_water or nodid == c_river_water then
						water = true
						if biome == BIOME_MORDOR then
							if nodid == c_river_water then
								data[vi] = c_morrivwat
							else
								data[vi] = c_morwat
							end
						end
						if n_temp < ICETET and y >= water_level - math_floor((ICETET - n_temp) * 10) then --ice
							data[vi] = c_ice
						end
					end
				end
			end
		nixz = nixz + 1
		end
	end
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)

	if measure then
		local chunk_gen_time = math_ceil((os_clock() - t1) * 1000)
		chunk_gen_avg = math_ceil((chunk_gen_avg * chunk_gen_count + chunk_gen_time) / (chunk_gen_count + 1))
		print("map-gen: " .. chunk_gen_time .. ", avg: " .. chunk_gen_avg)
		chunk_gen_count = chunk_gen_count + 1
	end
end)

dofile(minetest.get_modpath("lottmapgen").."/deco.lua")
dofile(minetest.get_modpath("lottmapgen").."/chests.lua")
