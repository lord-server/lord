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

dofile(minetest.get_modpath("lottmapgen").."/nodes.lua")
dofile(minetest.get_modpath("lottmapgen").."/functions.lua")


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

-- On generated function
minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y < (water_level-1000) or minp.y > 5000 then
		return
	end

	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z

	--print ("[lottmapgen_checking] chunk minp ("..x0.." "..y0.." "..z0..")")

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()

	local c_air = minetest.get_content_id("air")
	local c_sand = minetest.get_content_id("default:sand")
	local c_mordor_sand = minetest.get_content_id("lottmapgen:mordor_sand")
	local c_desert_sand = minetest.get_content_id("default:desert_sand")
	local c_silver_sand = minetest.get_content_id("default:silver_sand")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	local c_snow = minetest.get_content_id("default:snow")
	local c_ice = minetest.get_content_id("default:ice")
	local c_dirt_w_snow = minetest.get_content_id("default:dirt_with_snow")
	local c_dirtgrass = minetest.get_content_id("default:dirt_with_grass")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_dryshrub = minetest.get_content_id("default:dry_shrub")
	local c_clay = minetest.get_content_id("default:clay")
	local c_stone = minetest.get_content_id("default:stone")
	local c_desertstone = minetest.get_content_id("default:desert_stone")
	local c_stonecopper = minetest.get_content_id("default:stone_with_copper")
	local c_stoneiron = minetest.get_content_id("default:stone_with_iron")
	local c_stonecoal = minetest.get_content_id("default:stone_with_coal")
	local c_water = minetest.get_content_id("default:water_source")
	local c_river_water = minetest.get_content_id("default:river_water_source")
	local c_morwat = minetest.get_content_id("lottmapgen:blacksource")
	local c_morrivwat = minetest.get_content_id("lottmapgen:black_river_source")

	local c_morstone = minetest.get_content_id("lottmapgen:mordor_stone")
	local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
	local c_dungrass = minetest.get_content_id("lottmapgen:dunland_grass")
	local c_gondorgrass = minetest.get_content_id("lottmapgen:gondor_grass")
	local c_loriengrass = minetest.get_content_id("lottmapgen:lorien_grass")
	local c_fangorngrass = minetest.get_content_id("lottmapgen:fangorn_grass")
	local c_mirkwoodgrass = minetest.get_content_id("lottmapgen:mirkwood_grass")
	local c_rohangrass = minetest.get_content_id("lottmapgen:rohan_grass")
	local c_shiregrass = minetest.get_content_id("lottmapgen:shire_grass")
	local c_ironhillgrass = minetest.get_content_id("lottmapgen:ironhill_grass")
	local c_salt = minetest.get_content_id("lottores:mineral_salt")
	local c_pearl = minetest.get_content_id("lottores:mineral_pearl")
	local c_mallorngen = minetest.get_content_id("lottmapgen:mallorngen")
	local c_beechgen = minetest.get_content_id("lottmapgen:beechgen")
	local c_mirktreegen = minetest.get_content_id("lottmapgen:mirktreegen")
	local c_angsnowblock = minetest.get_content_id("lottmapgen:angsnowblock")
	local c_mallos = minetest.get_content_id("lottplants:mallos")
	local c_seregon = minetest.get_content_id("lottplants:seregon")
	local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")
	local c_pilinehtar = minetest.get_content_id("lottplants:pilinehtar")
	local c_ithilgrass = minetest.get_content_id("lottmapgen:ithilien_grass")
	local c_melon = minetest.get_content_id("lottplants:melon_wild")
	local c_angfort = minetest.get_content_id("lottmapgen:angmarfort")
	local c_gonfort = minetest.get_content_id("lottmapgen:gondorfort")
	local c_hobhole = minetest.get_content_id("lottmapgen:hobbithole")
	local c_orcfort = minetest.get_content_id("lottmapgen:orcfort")
	local c_malltre = minetest.get_content_id("lottmapgen:mallornhouse")
	local c_lorhous = minetest.get_content_id("lottmapgen:lorienhouse")
	local c_mirktre = minetest.get_content_id("lottmapgen:mirkhouse")
	local c_rohfort = minetest.get_content_id("lottmapgen:rohanfort")

	local biome_grass = {
		[BIOME_ANGMAR] = function()
			local block_id = c_angsnowblock
			if math.random(121) == 2 then
				block_id = c_ice
			elseif math.random(25) == 2 then
				block_id = c_frozenstone
			end
			return block_id
		end,
		[BIOME_SNOWPLAINS] = c_dirt_w_snow,
		[BIOME_TROLLSHAWS] = c_dirt_w_snow,
		[BIOME_DUNLANDS] = c_dungrass,
		[BIOME_GONDOR] = c_gondorgrass,
		[BIOME_ITHILIEN] = c_ithilgrass,
		[BIOME_LORIEN] = c_loriengrass,
		[BIOME_MORDOR] = c_morstone,
		[BIOME_FANGORN] = c_fangorngrass,
		[BIOME_MIRKWOOD] = c_mirkwoodgrass,
		[BIOME_HILLS] = c_ironhillgrass,
		[BIOME_ROHAN] = c_rohangrass,
		[BIOME_SHIRE] = c_shiregrass,
	}


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

			local sandy = (water_level+2) + math.random(-1, 1) -- sandline
			local sandmin = (water_level-15) + math.random(-5, 0) -- lowest sand
			local open = true -- open to sky?
			local solid = true -- solid node above?
			local water = false -- water node above?
			local surfy = y1 + 80 -- y of last surface detected
			for y = y1, y0, -1 do -- working down each column for each node do
				local fimadep = math.floor(6 - y / 512) + math.random(0, 1)
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
							if math.random(3) == 1 then
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
									if open and water and y == (water_level-1) and biome > 4 and math.random(PAPCHA) == 2 then -- papyrus
										lottmapgen_papyrus(x, (water_level+1), z, area, data)
										data[vi] = c_dirt
									elseif math.abs(n_temp) < 0.05 and y == (water_level-1) then -- clay
										data[vi] = c_clay
									elseif math.abs(n_temp) < 0.05 and y == (water_level-5) then -- salt
										data[vi] = c_salt
									elseif math.abs(n_temp) < 0.05 and y == (water_level-20) then -- pearl
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
								if open and y > (water_level + 4) + math.random(0, 1) and math.random(DUGCHA) == 2 and biome ~= BIOME_MORDOR and biome ~= BIOME_LORIEN then -- dune grass
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
									local above_surf_y = surfy + 1
									local surf_vi      = area:index(x, above_surf_y, z)
									if biome == BIOME_ANGMAR then
										if math.random(PLANT3) == 2 then
											data[surf_vi] = c_dryshrub
										elseif math.random(TREE10) == 2 then
											data[surf_vi] = c_beechgen
										elseif math.random(TREE7) == 3 then
											lottmapgen_pinetree(x, above_surf_y, z, area, data)
										elseif math.random(TREE8) == 4 then
											lottmapgen_firtree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT6) == 2 then
											data[surf_vi] = c_seregon
										elseif math.random(PLANT13) == 13 then
											data[surf_vi] = c_angfort
										end
									elseif biome == BIOME_SNOWPLAINS then
										data[surf_vi] = c_snowblock
									elseif biome == BIOME_TROLLSHAWS then
										if math.random(PLANT3) == 2 then
											data[surf_vi] = c_dryshrub
										elseif math.random(TREE10) == 2 then
											data[surf_vi] = c_beechgen
										elseif math.random(TREE4) == 3 then
											lottmapgen_pinetree(x, above_surf_y, z, area, data)
										elseif math.random(TREE3) == 4 then
											lottmapgen_firtree(x, above_surf_y, z, area, data)
										end
									elseif biome == BIOME_DUNLANDS then
										if math.random(TREE5) == 2 then
											lottmapgen_defaulttree(x, above_surf_y, z, area, data)
										elseif math.random(TREE7) == 3 then
											lottmapgen_appletree(x, above_surf_y, z, area, data)
										elseif math.random (PLANT3) == 4 then
											lottmapgen_grass(data, surf_vi)
										end
									elseif biome == BIOME_GONDOR then
										if math.random(TREE7) == 2 then
											lottmapgen_defaulttree(x, above_surf_y, z, area, data)
										elseif math.random(TREE8) == 6 then
											lottmapgen_aldertree(x, above_surf_y, z, area, data)
										elseif math.random(TREE9) == 3 then
											lottmapgen_appletree(x, above_surf_y, z, area, data)
										elseif math.random(TREE8) == 4 then
											lottmapgen_plumtree(x, above_surf_y, z, area, data)
										elseif math.random(TREE10) == 9 then
											lottmapgen_elmtree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT13) == 10 then
											lottmapgen_whitetree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT3) == 5 then
											lottmapgen_grass(data, surf_vi)
										elseif math.random(PLANT8) == 7 then
											lottmapgen_farmingplants(data, surf_vi)
										elseif math.random(PLANT13) == 8 then
											lottmapgen_farmingrareplants(data, surf_vi)
										elseif math.random(PLANT6) == 2 then
											data[surf_vi] = c_mallos
										elseif math.random(PLANT13) == 13 then
											data[surf_vi] = c_gonfort
										end
									elseif biome == BIOME_ITHILIEN then
										if math.random(TREE3) == 2 then
											lottmapgen_defaulttree(x, above_surf_y, z, area, data)
										elseif math.random(TREE6) == 6 then
											lottmapgen_lebethrontree(x, above_surf_y, z, area, data)
										elseif math.random(TREE3) == 3 then
											lottmapgen_appletree(x, above_surf_y, z, area, data)
										elseif math.random(TREE5) == 10 then
											lottmapgen_culumaldatree(x, above_surf_y, z, area, data)
										elseif math.random(TREE5) == 4 then
											lottmapgen_plumtree(x, above_surf_y, z, area, data)
										elseif math.random(TREE9) == 9 then
											lottmapgen_elmtree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT8) == 7 then
											lottmapgen_farmingplants(data, surf_vi)
										elseif math.random(PLANT13) == 8 then
											data[surf_vi] = c_melon
										elseif math.random(PLANT5) == 11 then
											lottmapgen_ithildinplants(data, surf_vi)
										end
									elseif biome == BIOME_LORIEN then
										if math.random(TREE3) == 2 then
											lottmapgen_mallornsmalltree(x, above_surf_y, z, area, data)
										elseif math.random(TREE2) == 2 then
											lottmapgen_young_mallorn(x, above_surf_y, z, area, data)
										elseif math.random(PLANT1) == 2 then
											lottmapgen_lorien_grass(data, surf_vi)
										elseif math.random(TREE5) == 3 then
											data[surf_vi] = c_mallorngen
										elseif math.random(PLANT4) == 11 then
											lottmapgen_lorienplants(data, surf_vi)
										elseif math.random(PLANT13) == 13 then
											if math.random(1, 2) == 1 then
												data[surf_vi] = c_malltre
											else
												data[surf_vi] = c_lorhous
											end
										end
									elseif biome == BIOME_MORDOR then
										if math.random(TREE10) == 2 then
											lottmapgen_burnedtree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT4) == 2 then
											data[surf_vi] = c_bomordor
										elseif math.random(PLANT13) == 13 then
											data[surf_vi] = c_orcfort
										end
									elseif biome == BIOME_FANGORN then
										if math.random(TREE3) == 2 then
											lottmapgen_defaulttree(x, above_surf_y, z, area, data)
										elseif math.random(TREE4) == 6 then
											lottmapgen_rowantree(x, above_surf_y, z, area, data)
										elseif math.random(TREE4) == 3 then
											lottmapgen_appletree(x, above_surf_y, z, area, data)
										elseif math.random(TREE5) == 10 then
											lottmapgen_birchtree(x, above_surf_y, z, area, data)
										elseif math.random(TREE5) == 4 then
											lottmapgen_plumtree(x, above_surf_y, z, area, data)
										elseif math.random(TREE7) == 9 then
											lottmapgen_elmtree(x, above_surf_y, z, area, data)
										elseif math.random(TREE6) == 11 then
											lottmapgen_oaktree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT4) == 7 then
											lottmapgen_farmingplants(data, surf_vi)
										elseif math.random(PLANT9) == 8 then
											data[surf_vi] = c_melon
										end
									elseif biome == BIOME_MIRKWOOD then
										if math.random(TREE2) == 2 then
											data[surf_vi] = c_mirktreegen
										elseif math.random(TREE4) == 3 then
											lottmapgen_jungletree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT13) == 13 then
											data[surf_vi] = c_mirktre
										end
									elseif biome == BIOME_HILLS then
										if math.random(TREE10) == 2 then
											data[surf_vi] = c_beechgen
										elseif math.random(TREE4) == 3 then
											lottmapgen_pinetree(x, above_surf_y, z, area, data)
										elseif math.random(TREE6) == 4 then
											lottmapgen_firtree(x, above_surf_y, z, area, data)
										end
									elseif biome == BIOME_ROHAN then
										if math.random(TREE7) == 2 then
											lottmapgen_defaulttree(x, above_surf_y, z, area, data)
										elseif math.random(TREE7) == 3 then
											lottmapgen_appletree(x, above_surf_y, z, area, data)
										elseif math.random(TREE8) == 4 then
											lottmapgen_plumtree(x, above_surf_y, z, area, data)
										elseif math.random(TREE10) == 9 then
											lottmapgen_elmtree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT2) == 5 then
											lottmapgen_grass(data, surf_vi)
										elseif math.random(PLANT8) == 6 then
											lottmapgen_farmingplants(data, surf_vi)
										elseif math.random(PLANT13) == 7 then
											data[surf_vi] = c_melon
										elseif math.random(PLANT6) == 2 then
											data[surf_vi] = c_pilinehtar
										elseif math.random(PLANT13) == 13 then
											data[surf_vi] = c_rohfort
										end
									elseif biome == BIOME_SHIRE then
										if math.random(TREE7) == 2 then
											lottmapgen_defaulttree(x, above_surf_y, z, area, data)
										elseif math.random(TREE7) == 3 then
											lottmapgen_appletree(x, above_surf_y, z, area, data)
										elseif math.random(TREE7) == 4 then
											lottmapgen_plumtree(x, above_surf_y, z, area, data)
										elseif math.random(TREE7) == 9 then
											lottmapgen_oaktree(x, above_surf_y, z, area, data)
										elseif math.random(PLANT7) == 7 then
											lottmapgen_farmingplants(data, surf_vi)
										elseif math.random(PLANT9) == 8 then
											data[surf_vi] = c_melon
										elseif math.random(PLANT13) == 13 then
											data[surf_vi] = c_hobhole
										end
									end
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
						if n_temp < ICETET and y >= water_level - math.floor((ICETET - n_temp) * 10) then --ice
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
	local chugent = math.ceil((os.clock() - t1) * 1000)
end)

dofile(minetest.get_modpath("lottmapgen").."/schematics.lua")
dofile(minetest.get_modpath("lottmapgen").."/deco.lua")
dofile(minetest.get_modpath("lottmapgen").."/chests.lua")
