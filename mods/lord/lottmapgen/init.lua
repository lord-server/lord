local math_random, math_floor, math_abs, math_ceil, math_min, math_max, os_clock, pairs, type, id
	= math.random, math.floor, math.abs, math.ceil, math.min, math.max, os.clock, pairs, type, minetest.get_content_id

-- This thresholds used for detection of biome in current map position (in 2D -- only x, z coordinates)
local HI_TEMPERATURE_THRESHOLD =  0.4
local LO_TEMPERATURE_THRESHOLD = -0.4
local HI_HUMIDITY_THRESHOLD    =  0.4
local LO_HUMIDITY_THRESHOLD    = -0.4
local HI_RANDOM                =  0.4
local LO_RANDOM                = -0.4

-- When its too cold and water converts into ice, so we see ice crust on the water
local ICE_TEMPERATURE = -0.8

local SAND_LAYER_THICKNESS = 6
local BEACH_LAYERS_COUNT   = 2
local COAST_LAYERS_COUNT   = 4
local SHALLOW_WATER_DEPTH  = 1

local PAPYRUS_CHANCE = 3 -- Papyrus

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

local np_temperature = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 9130,
	octaves = 3,
	persist = 0.5
}

-- 2D noise for humidity

local np_humidity = {
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
local water_level = tonumber(minetest.get_mapgen_setting("water_level") or 1)

local measure = minetest.settings:get_bool("mapgen_measure_chunk_gene_time", false)
local chunk_gen_count = 0
local chunk_gen_avg = 0

dofile(minetest.get_modpath("lottmapgen").."/nodes.lua")
dofile(minetest.get_modpath("lottmapgen").."/functions.lua")
dofile(minetest.get_modpath("lottmapgen").."/schematics.lua")


local function detect_current_biome(n_temp, n_humid, n_ran)
	local biome = 0
	if n_temp < LO_TEMPERATURE_THRESHOLD then
		if n_humid < LO_HUMIDITY_THRESHOLD then
			biome = BIOME_ANGMAR -- (Angmar)
		elseif n_humid > HI_HUMIDITY_THRESHOLD then
			biome = BIOME_TROLLSHAWS -- (Trollshaws)
		else
			biome = BIOME_SNOWPLAINS -- (Snowplains)
		end
	elseif n_temp > HI_TEMPERATURE_THRESHOLD then
		if n_humid < LO_HUMIDITY_THRESHOLD then
			biome = BIOME_LORIEN -- (Lorien)
		elseif n_humid > HI_HUMIDITY_THRESHOLD then
			biome = BIOME_FANGORN -- (Fangorn)
		elseif n_ran < LO_RANDOM then
			biome = BIOME_MIRKWOOD -- (Mirkwood)
		elseif n_ran > HI_RANDOM then
			biome = BIOME_HILLS -- (Iron Hills)
		else
			biome = BIOME_DUNLANDS -- (Dunlands)
		end
	else
		if n_humid < LO_HUMIDITY_THRESHOLD then
			biome = BIOME_MORDOR -- (Mordor)
		elseif n_humid > HI_HUMIDITY_THRESHOLD then
			biome = BIOME_ITHILIEN -- (Ithilien)
		elseif n_ran < LO_RANDOM then
			biome = BIOME_SHIRE -- (Shire)
		elseif n_ran > HI_RANDOM then
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

local c_stone          = id("default:stone")
local c_stone_w_copper = id("default:stone_with_copper")
local c_stone_w_iron   = id("default:stone_with_iron")
local c_stone_w_coal   = id("default:stone_with_coal")

local c_water       = id("default:water_source")
local c_river_water = id("default:river_water_source")
local c_mordor_water       = id("lottmapgen:blacksource")
local c_mordor_river_water = id("lottmapgen:black_river_source")

local c_desert_stone = id("default:desert_stone")
local c_mordor_stone = id("lottmapgen:mordor_stone")

local c_salt = id("lottores:mineral_salt")
local c_pearl = id("lottores:mineral_pearl")
local c_waterlily = id("flowers:waterlily_waving")

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
		return c_desert_stone
	elseif biome == BIOME_MORDOR then
		return c_mordor_stone
	elseif biome == BIOME_HILLS then
		if math_random(3) == 1 then
			return c_stone_w_iron
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
	if temperature < ICE_TEMPERATURE and y >= water_level - math_floor((ICE_TEMPERATURE - temperature) * 10) then
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


---is_sand_layer
---@param y          number current y height
---@param sand_min_y number lowest height of sand in current vertical column
---@param surface_y  number height of surface in current vertical column
---@return boolean
local function is_sand_layer(y, sand_min_y, surface_y)
	-- The sand layer becomes thinner, if you got closer to the continent.
	-- Thickness (approximately):
	--    [where]                                                     [delta]        [value]
	--  - under the sea/river:              == SAND_LAYER_THICKNESS - 0           == 6
	--  - under the beach line:             == SAND_LAYER_THICKNESS - { 1 or 2 }  == 4|5
	--  - under the area after beach line:  == SAND_LAYER_THICKNESS - { 3 or 4 }  == 2|3
	-- The same "Thickness (approximately)", depending on the `surface_y`:
	--    [`surface_y` value]                                         [delta]        [value]
	--  -      `surface_y` <= 0:            == SAND_LAYER_THICKNESS - 0           == 6
	--  - 1 <= `surface_y` <= 2:            == SAND_LAYER_THICKNESS - { 1 or 2 }  == 4|5
	--  - 3 <= `surface_y` <= 4:            == SAND_LAYER_THICKNESS - { 3 or 4 }  == 2|3
	--  - 4 <  `surface_y`     :            (not handled since `under_the_hill`)  == 0
	local thickness_delta      = math_min(
		SAND_LAYER_THICKNESS,
		math_max(surface_y, -SAND_LAYER_THICKNESS)
	)
	local sand_layer_thickness = SAND_LAYER_THICKNESS - thickness_delta
	local sand_layer_bottom    = (surface_y - sand_layer_thickness) + math_random(-1, 1)
	local under_the_hill       = surface_y > COAST_LAYERS_COUNT

	local s_min_y = math_max(sand_min_y, sand_layer_bottom)

	return y >= s_min_y and y < surface_y and not under_the_hill
end


-- On generated function
minetest.register_on_generated(function(min_pos, max_pos, seed)
	if min_pos.y < (water_level-300) or min_pos.y > 1000 then
		return
	end

	local t1 = os_clock()

	local x0 = min_pos.x
	local y0 = min_pos.y
	local z0 = min_pos.z
	local x1 = max_pos.x
	local y1 = max_pos.y
	local z1 = max_pos.z

	local voxel_manipulator, e_min, e_max = minetest.get_mapgen_object("voxelmanip")
	local area                            = VoxelArea:new{ MinEdge = e_min, MaxEdge = e_max }
	local data                            = voxel_manipulator:get_data()

	local side_len   = x1 - x0 + 1
	local chunk_lens = { x = side_len, y = side_len, z = side_len }
	local xz_min_pos = { x = x0, y = z0 }

	local nvals_temp   = minetest.get_perlin_map(np_temperature, chunk_lens):get_2d_map_flat(xz_min_pos)
	local nvals_humid  = minetest.get_perlin_map(np_humidity, chunk_lens):get_2d_map_flat(xz_min_pos)
	local nvals_random = minetest.get_perlin_map(np_random, chunk_lens):get_2d_map_flat(xz_min_pos)

	local lua_t1 = os_clock()

	local xz_noise_index = 1
	for z = z0, z1 do
		for x = x0, x1 do -- for each column do
			local temperature = nvals_temp[xz_noise_index] -- select biome
			local humidity    = nvals_humid[xz_noise_index]
			local random      = nvals_random[xz_noise_index]
			local biome       = detect_current_biome(temperature, humidity, random)

			local sand_y         = (water_level + BEACH_LAYERS_COUNT) + math_random(-1, 1) -- sandline
			local sand_min_y     = (water_level - 15) + math_random(-5, 0) -- lowest sand
			local is_open        = true -- open to sky?
			local is_solid       = true -- solid node above?
			local is_water_above = false -- water node above?
			local surface_y      = y1 + 80 -- y of last surface detected
			for y = y1, y0, -1 do -- working down each column for each node do
				local vi         = area:index(x, y, z)
				local node_id    = data[vi]
				local vi_uu      = area:index(x, y - 2, z)
				local node_id_uu = data[vi_uu] -- under-under

				local node_is_stone = node_id == c_stone or node_id == c_stone_w_copper or node_id == c_stone_w_iron or node_id == c_stone_w_coal
				local node_is_space = node_id == c_air or node_id == c_water or node_id == c_river_water
				local node_uu_is_not_space = node_id_uu ~= c_air and node_id_uu ~= c_water

				-- if stone
				if node_is_stone then

					if y > water_level - 32 then
						local biome_stone = get_biome_stone(biome)
						if biome_stone then
							data[vi] = biome_stone
						end
					end

					if not is_solid then -- if surface
						surface_y = y

						if node_uu_is_not_space then -- if supported by 2 stone nodes

							if y <= sand_y and y >= sand_min_y then -- surface in the sand bounds
								data[vi] = get_biome_sand(biome)

								local is_beach = y >= water_level and y < (water_level + BEACH_LAYERS_COUNT)
								local is_water_space = y < water_level and is_water_above


								if is_beach then
									-- place beach stuff
								elseif is_water_space then
									local is_shallow_water = y >= (water_level - SHALLOW_WATER_DEPTH) and is_open
									if is_shallow_water then
										if biome > 4 and biome ~= BIOME_MORDOR then
											-- papyrus
											if math_random(PAPYRUS_CHANCE) == 1	then
												lottmapgen_papyrus(x, (water_level + 1), z, area, data)
												data[vi] = c_dirt
											-- waterlily
											elseif math_random(20) == 1 then
												local water_level_vi = area:index(x, water_level + 1, z)
												data[water_level_vi] = c_waterlily
												data[vi] = c_dirt
											end
										end
									end
									biome_place_water_bottom(biome, temperature, y, data, vi) -- bottom of river or sea
								end
							elseif y > sand_y then -- above sandline
								data[vi] = get_biome_grass(biome)
								if is_open then -- if open to sky then flora & buildings
									local surf_vi = area:index(x, surface_y + 1, z)
									biome_fill_airspace(biome_airspace[biome], area, data, surf_vi)
								end
							end

						end

					else -- underground

						if node_uu_is_not_space then

							if is_sand_layer(y, sand_min_y, surface_y) then
								data[vi] = get_biome_sand(biome)
							end

						end
					end

					is_open  = false
					is_solid = true

				elseif node_is_space then

					is_solid = false

					if node_id == c_water or node_id == c_river_water then
						is_water_above = true
						biome_replace_water(node_id, biome, data, vi)
						place_ice_crust(temperature, y, data, vi) -- if it's frosty & not so deep
					end
				end
			end

			xz_noise_index = xz_noise_index + 1
		end
	end

	local lua_gen_time = 0
	if measure then
		lua_gen_time = math_ceil((os_clock() - lua_t1) * 1000)
	end

	voxel_manipulator:set_data(data)
	voxel_manipulator:set_lighting({ day =0, night =0})
	voxel_manipulator:calc_lighting()
	voxel_manipulator:write_to_map(data)

	if measure then
		local chunk_gen_time = math_ceil((os_clock() - t1) * 1000)
		chunk_gen_avg = math_ceil((chunk_gen_avg * chunk_gen_count + chunk_gen_time) / (chunk_gen_count + 1))
		print("map-gen: " .. chunk_gen_time .. ", ".. lua_gen_time ..", avg: " .. chunk_gen_avg)
		chunk_gen_count = chunk_gen_count + 1
	end
end)

dofile(minetest.get_modpath("lottmapgen").."/deco.lua")
dofile(minetest.get_modpath("lottmapgen").."/chests.lua")
