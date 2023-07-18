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

-- /!\ Warning /!\ : duplicated in config.lua (TODO)
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
			biome = BIOME_ANGMAR -- (Angmar)
		elseif n_humid > HIHUT then
			biome = BIOME_TROLLSHAWS -- (Trollshaws)
		else
			biome = BIOME_SNOWPLAINS -- (Snowplains)
		end
	elseif n_temp > HITET then
		if n_humid < LOHUT then
			biome = BIOME_LORIEN -- (Lorien)
		elseif n_humid > HIHUT then
			biome = BIOME_FANGORN -- (Fangorn)
		elseif n_ran < LORAN then
			biome = BIOME_MIRKWOOD -- (Mirkwood)
		elseif n_ran > HIRAN then
			biome = BIOME_HILLS -- (Iron Hills)
		else
			biome = BIOME_DUNLANDS -- (Dunlands)
		end
	else
		if n_humid < LOHUT then
			biome = BIOME_MORDOR -- (Mordor)
		elseif n_humid > HIHUT then
			biome = BIOME_ITHILIEN -- (Ithilien)
		elseif n_ran < LORAN then
			biome = BIOME_SHIRE -- (Shire)
		elseif n_ran > HIRAN then
			biome = BIOME_ROHAN -- (Rohan)
		else
			biome = BIOME_GONDOR -- (Gondor)
		end
	end

	return biome
end

--- @param air table above ground config to filling biome airspace with flora/buildings/...
--- @param vm_area VoxelArea voxel map part manipulator
--- @param vm_data table array of node's content IDs
--- @param index number node position index in `vm_data`
--- @return boolean whether it was filled or not
local function biome_fill_airspace(air, vm_area, vm_data, index)
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
local c_clay = id("default:clay")
local c_stone = id("default:stone")
local c_desertstone = id("default:desert_stone")
local c_stonecopper = id("default:stone_with_copper")
local c_stoneiron = id("default:stone_with_iron")
local c_stonecoal = id("default:stone_with_coal")

local c_water       = id("default:water_source")
local c_river_water = id("default:river_water_source")
local c_mordor_water       = id("lottmapgen:blacksource")
local c_mordor_river_water = id("lottmapgen:black_river_source")

local c_morstone = id("lottmapgen:mordor_stone")

local c_salt = id("lottores:mineral_salt")
local c_pearl = id("lottores:mineral_pearl")

local config = dofile(minetest.get_modpath("lottmapgen").."/config.lua")
local biome_grass = config.biome_grass
local biome_airspace = config.biome_airspace

--- @param biome number biome number (biome id)
--- @return number node content ID
local function get_biome_grass(biome)
	--- @type number|fun():number
	local grass = biome_grass[biome]
	if type(grass) == "function" then
		grass = grass()
	end
	return grass
end

--- @param biome number biome number (biome id)
--- @return number
local function get_biome_sand(biome)
	if biome == BIOME_MORDOR then
		return c_mordor_sand
	elseif biome == BIOME_SNOWPLAINS or biome == BIOME_ANGMAR then
		return c_silver_sand
	elseif biome == BIOME_DUNLANDS or biome == BIOME_ROHAN then
		return c_desert_sand
	end

	return c_sand
end

--- @param biome number biome number (biome id)
--- @return number|nil
local function get_biome_stone(biome)
	if biome == BIOME_DUNLANDS or biome == BIOME_ROHAN then
		return c_desertstone
	elseif biome == BIOME_MORDOR then
		return c_morstone
	elseif biome == BIOME_HILLS then
		if math_random(3) == 1 then
			return c_stoneiron
		end
	end

	return nil
end

--- @param cur_water_id number current node content ID
--- @param biome        number biome number (biome id)
--- @param data         table  loaded piece of map data: array of node's content IDs
--- @param index        number linear index in `data` of current position
local function biome_replace_water(cur_water_id, biome, data, index)
	if biome == BIOME_MORDOR then
		if cur_water_id == c_river_water then
			data[index] = c_mordor_river_water
		else
			data[index] = c_mordor_water
		end
	end
end

--- @param temperature number temperature in current coordinates (in x,z)
--- @param y           number current height
--- @param data        table  loaded piece of map data: array of node's content IDs
--- @param index       number linear index in `data` of current position
local function place_ice_crust(temperature, y, data, index)
	-- if it's frosty & not so deep
	if temperature < ICETET and y >= water_level - math_floor((ICETET - temperature) * 10) then
		data[index] = c_ice
	end
end

--- @param temperature number temperature in current coordinates (in x,z)
--- @param y           number current height
--- @param data        table  loaded piece of map data: array of node's content IDs
--- @param index       number linear index in `data` of current position
local function biome_place_water_bottom(biome, temperature, y, data, index)
	if biome ~= BIOME_MORDOR then
		if math_abs(temperature) < 0.05 and y == (water_level - 1) then -- clay
			data[index] = c_clay
		elseif math_abs(temperature) < 0.05 and y == (water_level - 5) then -- salt
			data[index] = c_salt
		elseif math_abs(temperature) < 0.05 and y == (water_level - 20) then -- pearl
			data[index] = c_pearl
		end
	end
end



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
			local n_temp  = nvals_temp[nixz] -- select biome
			local n_humid = nvals_humid[nixz]
			local n_ran   = nvals_random[nixz]
			local biome   = detect_current_biome(n_temp, n_humid, n_ran)

			local sandy   = (water_level + 2) + math_random(-1, 1) -- sandline
			local sandmin = (water_level - 15) + math_random(-5, 0) -- lowest sand
			local open    = true -- open to sky?
			local solid   = true -- solid node above?
			local water   = false -- water node above?
			local surfy   = y1 + 80 -- y of last surface detected
			for y = y1, y0, -1 do -- working down each column for each node do
				local fimadep = math_floor(6 - y / 512) + math_random(0, 1)
				local vi      = area:index(x, y, z)
				local nodid   = data[vi]
				local viuu    = area:index(x, y - 2, z)
				local nodiduu = data[viuu]

				-- if stone
				if nodid == c_stone or nodid == c_stonecopper or nodid == c_stoneiron or nodid == c_stonecoal then

					if y > water_level-32 then
						local biome_stone = get_biome_stone(biome)
						if biome_stone then
							data[vi] = biome_stone
						end
					end

					if not solid then -- if surface
						surfy = y

						if nodiduu ~= c_air and nodiduu ~= c_water and fimadep >= 1 then -- if supported by 2 stone nodes

							if y <= sandy and y >= sandmin then -- sand
								data[vi] = get_biome_sand(biome)
								if  -- papyrus
									open and water and y == (water_level - 1) and
									biome > 4 and biome ~= BIOME_MORDOR and
									math_random(PAPCHA) == 2
								then
									lottmapgen_papyrus(x, (water_level + 1), z, area, data)
									data[vi] = c_dirt
								end
								biome_place_water_bottom(biome, n_temp, y, data, vi) -- bottom of river or sea
							elseif y > sandy then -- above sandline
								data[vi] = get_biome_grass(biome)
								if open then -- if open to sky then flora & buildings
									local surf_vi = area:index(x, surfy + 1, z)
									biome_fill_airspace(biome_airspace[biome], area, data, surf_vi)
								end
							end
						end

					else -- underground
						if nodiduu ~= c_air and nodiduu ~= c_water and surfy - y + 1 <= fimadep then
							if y <= sandy and y >= sandmin then
								data[vi] = get_biome_sand(biome)
							end
						end
					end

					open  = false
					solid = true

				elseif nodid == c_air or nodid == c_water or nodid == c_river_water then
					solid = false
					if nodid == c_water or nodid == c_river_water then
						water = true
						biome_replace_water(nodid, biome, data, vi)
						place_ice_crust(n_temp, y, data, vi) -- if it's frosty & not so deep
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
