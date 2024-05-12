local function get_grass(pos)
	local id = math.random(2, 5)
	local name = "default:grass_" .. tostring(id)
	return name
end

local function get_flower(pos)
	local names = { "flowers:dandelion_white",
		"flowers:dandelion_yellow",
		"flowers:geranium",
		"flowers:rose",
		"flowers:tulip",
		"flowers:viola"
	}
	local id = math.random(1, #names)
	local name = names[id]
	return name
end

local function get_sapling(pos)
	local name = "default:sapling"
	return name
end


mountgen.top_node = function(pos, config)
	local place_snow = false
	local sl = config.SNOW_LINE - math.random(0, config.SNOW_LINE_RAND)
	if pos.y >= sl then
		place_snow = true
	end

	if place_snow then
		return "default:snowblock"
	else
		return config.top_cover
	end
end

mountgen.upper_node = function(pos, config)
	if pos.y >= config.SNOW_LINE - config.SNOW_LINE_RAND then
		return nil
	end
	if math.random(0, 100) < config.GRASS_PERCENT then
		return get_grass()
	end

	if pos.y <= config.FLOWERS_LINE and math.random(0, 100) < config.FLOWERS_PERCENT then
		return get_flower()
	end

	if pos.y <= config.TREE_LINE and math.random(0, 1000) < config.TREE_PROMILLE then
		return get_sapling()
	end

	return nil
end
