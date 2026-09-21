local math_random, math_floor, math_abs, math_ceil, math_min, math_max, os_clock, pairs, type, id
	= math.random, math.floor, math.abs, math.ceil, math.min, math.max, os.clock, pairs, type, core.get_content_id

local Logger = core.get_mod_logger()

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

-- Gravel generation parameters
local GRAVEL_PERCENT = 10


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
local water_level = tonumber(core.get_mapgen_setting("water_level")) or 1

local measure = core.settings:get_bool("mapgen_measure_chunk_gene_time", false)
local chunk_pos_log = core.settings:get_bool("mapgen_chunk_pos_log", false)
local chunk_gen_count = 0
local chunk_gen_avg = 0

dofile(core.get_modpath("lottmapgen").."/nodes.lua")
dofile(core.get_modpath("lottmapgen").."/functions.lua")
dofile(core.get_modpath("lottmapgen").."/schematics.lua")

--- @param value number
--- @param low   number
--- @param high  number
--- @return string `low`, `mid` or `high`
local function get_band(value, low, high)
	if value < low then
		return 'low'
	elseif value > high then
		return 'high'
	end

	return 'mid'
end

-- Biomes by the temperature (rows), by the humidity (columns) and (for the middle humidity) by the random (nested):
--- @type table<string, table<string, number|table<string, number>>>
local BIOMES_BY_CLIMATE = {
	-- cold
	low  = {
		low = BIOME_ANGMAR, mid = BIOME_SNOWPLAINS, high = BIOME_TROLLSHAWS,
	},
	-- hot
	high = {
		low = BIOME_LORIEN, high = BIOME_FANGORN,
		mid = { low = BIOME_MIRKWOOD, mid = BIOME_DUNLANDS, high = BIOME_HILLS },
	},
	-- moderate
	mid  = {
		low = BIOME_MORDOR, high = BIOME_ITHILIEN,
		mid = { low = BIOME_SHIRE, mid = BIOME_GONDOR, high = BIOME_ROHAN },
	},
}

local function detect_current_biome(n_temp, n_humid, n_ran)
	local temperature_band = get_band(n_temp, LO_TEMPERATURE_THRESHOLD, HI_TEMPERATURE_THRESHOLD)
	local humidity_band    = get_band(n_humid, LO_HUMIDITY_THRESHOLD, HI_HUMIDITY_THRESHOLD)

	local biome = BIOMES_BY_CLIMATE[temperature_band][humidity_band]
	if type(biome) == "table" then
		biome = biome[get_band(n_ran, LO_RANDOM, HI_RANDOM)]
	end

	return biome
end

--- @param air table above ground config to filling biome airspace with flora/buildings/...
--- @param vm_area VoxelArea voxel map part manipulator
--- @param vm_data table array of node's content IDs
--- @param index integer node position index in `vm_data`
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

local id_air = id("air")

local id_sand = id("default:sand")
local id_mordor_sand = id("lord_ground:mordor_sand")
local id_desert_sand = id("default:desert_sand")
local id_silver_sand = id("default:silver_sand")

local id_ice = id("default:ice")
local id_dirt = id("default:dirt")
local id_clay = id("default:clay")
local id_mordor_clay = id("clay_types:mordor_clay_block_raw")

local id_stone          = id("default:stone")
local id_stone_w_copper = id("default:stone_with_copper")
local id_stone_w_iron   = id("default:stone_with_iron")
local id_stone_w_coal   = id("default:stone_with_coal")

local stones_ids = { id_stone, id_stone_w_copper, id_stone_w_iron, id_stone_w_coal }

local id_water       = id("default:water_source")
local id_river_water = id("default:river_water_source")
local id_mordor_water       = id("lottmapgen:blacksource")
local id_mordor_river_water = id("lottmapgen:black_river_source")

local id_desert_stone = id("default:desert_stone")
local id_mordor_stone = id("lord_rocks:mordor_stone")

local id_gravel        = id("default:gravel")
local id_desert_gravel = id("default:desert_gravel")

local id_salt = id("lottores:mineral_salt")
local id_pearl = id("lottores:mineral_pearl")
local id_waterlily = id("flowers:waterlily_waving")

local config = dofile(core.get_modpath("lottmapgen").."/config.lua")
--- @type table<number, number|fun():number>
local biome_grass = config.biome_grass
--- @type table<number, table> above ground config of each biome (see `biome_fill_airspace()`)
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
		return id_mordor_sand
	elseif biome == BIOME_SNOWPLAINS or biome == BIOME_ANGMAR then
		return id_silver_sand
	elseif biome == BIOME_DUNLANDS or biome == BIOME_ROHAN then
		return id_desert_sand
	end

	return id_sand
end

--- @param biome number biome number (biome id)
--- @return number|nil
local function get_biome_stone(biome)
	if biome == BIOME_DUNLANDS or biome == BIOME_ROHAN then
		return id_desert_stone
	elseif biome == BIOME_MORDOR then
		return id_mordor_stone
	elseif biome == BIOME_HILLS then
		if math_random(3) == 1 then
			return id_stone_w_iron
		end
	end

	return nil
end

--- @param biome number biome number (biome id)
--- @return number
local function get_biome_gravel(biome)
	if biome == BIOME_DUNLANDS or biome == BIOME_ROHAN then
		return id_desert_gravel
	end

    return id_gravel
end


--- @param cur_water_id number current node content ID
--- @param biome        number biome number (biome id)
--- @param data         table  loaded piece of map data: array of node's content IDs
--- @param index        number linear index in `data` of current position
local function biome_replace_water(cur_water_id, biome, data, index)
	if biome == BIOME_MORDOR then
		if cur_water_id == id_river_water then
			data[index] = id_mordor_river_water
		else
			data[index] = id_mordor_water
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
		data[index] = id_ice
	end
end

--- @param temperature number temperature in current coordinates (in x,z)
--- @param y           number current height
--- @param data        table  loaded piece of map data: array of node's content IDs
--- @param index       number linear index in `data` of current position
local function biome_place_water_bottom(biome, temperature, y, data, index)
	if biome == BIOME_MORDOR then
		if math_abs(temperature) < 0.05 and y == (water_level - 1) then -- mordor clay
			data[index] = id_mordor_clay
		end
	else
		if math_abs(temperature) < 0.05 and y == (water_level - 1) then -- clay
			data[index] = id_clay
		elseif math_abs(temperature) < 0.05 and y == (water_level - 5) then -- salt
			data[index] = id_salt
		elseif math_abs(temperature) < 0.05 and y == (water_level - 20) then -- pearl
			data[index] = id_pearl
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


--- State of the column which is being processed (from the top to the bottom).
--- @class lottmapgen.Column
--- @field x              number
--- @field z              number
--- @field biome          number
--- @field temperature    number
--- @field sand_y         number sandline
--- @field sand_min_y     number lowest sand
--- @field is_open        boolean open to sky?
--- @field is_solid       boolean solid node above?
--- @field is_water_above boolean water node above?
--- @field surface_y      number y of last surface detected

--- Replaces the stone by the stone (and the gravel) of the biome.
local function replace_stone_by_biome(biome, data, vi)
	local biome_gravel = get_biome_gravel(biome)
	local biome_stone = get_biome_stone(biome)
	if not biome_stone then
		return
	end

	if biome_gravel and math_random(100) <= GRAVEL_PERCENT then
		data[vi] = biome_gravel
	else
		data[vi] = biome_stone
	end
end

--- Papyrus and waterlily in the shallow water.
--- @param col lottmapgen.Column
local function place_water_plants(col, y, vi, area, data)
	local is_shallow_water = y >= (water_level - SHALLOW_WATER_DEPTH) and col.is_open
	if not is_shallow_water or col.biome <= 4 or col.biome == BIOME_MORDOR then
		return
	end

	if math_random(PAPYRUS_CHANCE) == 1 then
		-- papyrus
		lottmapgen_papyrus(col.x, (water_level + 1), col.z, area, data)
		data[vi] = id_dirt
	elseif math_random(20) == 1 then
		-- waterlily
		local water_level_vi = area:index(col.x, water_level + 1, col.z)
		data[water_level_vi] = id_waterlily
		data[vi] = id_dirt
	end
end

--- The surface in the sand bounds.
--- @param col lottmapgen.Column
local function place_sand_surface(col, y, vi, area, data)
	data[vi] = get_biome_sand(col.biome)

	local is_beach = y >= water_level and y < (water_level + BEACH_LAYERS_COUNT)
	local is_water_space = y < water_level and col.is_water_above

	-- TODO: place beach stuff (`is_beach`)
	if not is_beach and is_water_space then
		place_water_plants(col, y, vi, area, data)
		biome_place_water_bottom(col.biome, col.temperature, y, data, vi) -- bottom of river or sea
	end
end

--- The surface which is supported by 2 stone nodes.
--- @param col lottmapgen.Column
local function place_surface(col, y, vi, area, data)
	if y <= col.sand_y and y >= col.sand_min_y then -- surface in the sand bounds
		place_sand_surface(col, y, vi, area, data)
	elseif y > col.sand_y then -- above sandline
		data[vi] = get_biome_grass(col.biome)
		if col.is_open then -- if open to sky then flora & buildings
			local surf_vi = area:index(col.x, col.surface_y + 1, col.z)
			biome_fill_airspace(biome_airspace[col.biome], area, data, surf_vi)
		end
	end
end

--- @param col                   lottmapgen.Column
--- @param node_uu_is_not_space  boolean
local function process_stone_node(col, y, vi, area, data, node_uu_is_not_space)
	if y > water_level - 32 then
		replace_stone_by_biome(col.biome, data, vi)
	end

	if not col.is_solid then -- if surface
		col.surface_y = y

		if node_uu_is_not_space then -- if supported by 2 stone nodes
			place_surface(col, y, vi, area, data)
		end
	elseif node_uu_is_not_space and is_sand_layer(y, col.sand_min_y, col.surface_y) then -- underground
		data[vi] = get_biome_sand(col.biome)
	end

	col.is_open  = false
	col.is_solid = true
end

--- @param col lottmapgen.Column
local function process_space_node(col, node_id, y, vi, data)
	col.is_solid = false

	if node_id == id_water or node_id == id_river_water then
		col.is_water_above = true
		biome_replace_water(node_id, col.biome, data, vi)
		place_ice_crust(col.temperature, y, data, vi) -- if it's frosty & not so deep
	end
end

--- Working down the column for each node do.
local function process_column(area, data, x, z, y0, y1, temperature, biome)
	--- @type lottmapgen.Column
	local col = {
		x              = x,
		z              = z,
		biome          = biome,
		temperature    = temperature,
		sand_y         = (water_level + BEACH_LAYERS_COUNT) + math_random(-1, 1), -- sandline
		sand_min_y     = (water_level - 15) + math_random(-5, 0), -- lowest sand
		is_open        = true, -- open to sky?
		is_solid       = true, -- solid node above?
		is_water_above = false, -- water node above?
		surface_y      = y1 + 80, -- y of last surface detected
	}

	for y = y1, y0, -1 do
		local vi         = area:index(x, y, z)
		local node_id    = data[vi]
		local vi_uu      = area:index(x, y - 2, z)
		local node_id_uu = data[vi_uu] -- under-under

		local node_is_stone = table.contains(stones_ids, node_id)
		local node_is_space = node_id == id_air or node_id == id_water or node_id == id_river_water
		local node_uu_is_not_space = node_id_uu ~= id_air and node_id_uu ~= id_water

		if node_is_stone then
			process_stone_node(col, y, vi, area, data, node_uu_is_not_space)
		elseif node_is_space then
			process_space_node(col, node_id, y, vi, data)
		end
	end
end

--- @param min_pos Position
--- @param max_pos Position
--- @param stage   string `start` or `end`
local function log_chunk_generation(min_pos, max_pos, stage)
	if chunk_pos_log then
		Logger.action("chunk # from_" .. min_pos.x .. "_" .. min_pos.y .. "_" .. min_pos.z .. "_to_"
			.. max_pos.x .. "_" .. max_pos.y .. "_" .. max_pos.z .. " generation " .. stage)
	end
end

--- On generated function
--- @param min_pos MapVector
--- @param max_pos MapVector
--- @param _seed   number
local function on_generated(min_pos, max_pos, _seed)
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

	local side_len   = x1 - x0 + 1
	local chunk_lens = { x = side_len, y = side_len, z = side_len }
	local xz_min_pos = { x = x0, y = z0 }

	local nvals_temp   = core.get_perlin_map(np_temperature, chunk_lens):get_2d_map_flat(xz_min_pos)
	local nvals_humid  = core.get_perlin_map(np_humidity, chunk_lens):get_2d_map_flat(xz_min_pos)
	local nvals_random = core.get_perlin_map(np_random, chunk_lens):get_2d_map_flat(xz_min_pos)

	local lua_gen_time = 0

	log_chunk_generation(min_pos, max_pos, "start")

	core.with_map_part_do(min_pos, max_pos, function(area, data)


		local lua_t1 = os_clock()

		local xz_noise_index = 1
		for z = z0, z1 do
			for x = x0, x1 do -- for each column do
				local temperature = nvals_temp[xz_noise_index] -- select biome
				local humidity    = nvals_humid[xz_noise_index]
				local random      = nvals_random[xz_noise_index]
				local biome       = detect_current_biome(temperature, humidity, random)

				process_column(area, data, x, z, y0, y1, temperature, biome)

				xz_noise_index = xz_noise_index + 1
			end
		end

		if measure then
			lua_gen_time = math_ceil((os_clock() - lua_t1) * 1000)
		end

	end, true)

	if measure then
		local chunk_gen_time = math_ceil((os_clock() - t1) * 1000)
		chunk_gen_avg = math_ceil((chunk_gen_avg * chunk_gen_count + chunk_gen_time) / (chunk_gen_count + 1))
		print("map-gen: " .. chunk_gen_time .. ", ".. lua_gen_time ..", avg: " .. chunk_gen_avg)
		chunk_gen_count = chunk_gen_count + 1
	end

	log_chunk_generation(min_pos, max_pos, "end")
end

core.register_on_generated(on_generated)

dofile(core.get_modpath("lottmapgen").."/deco.lua")
dofile(core.get_modpath("lottmapgen").."/chests.lua")
