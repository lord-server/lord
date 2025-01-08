local math_random, id
    = math.random, minetest.get_content_id


--- @type number[]
local FLOWERS_IDS = {
	id('flowers:dandelion_white'),
	id('flowers:dandelion_yellow'),
	id('flowers:geranium'),
	id('flowers:rose'),
	id('flowers:tulip'),
	id('flowers:viola'),
}
--- @type number[]
local GRASS_IDS  = {
	id('default:grass_1'),
	id('default:grass_2'),
	id('default:grass_3'),
	id('default:grass_4'),
	id('default:grass_5'),
}
local ID_STONE      = id('default:stone')
local ID_SAPLING    = id('default:sapling')
local ID_SNOW_BLOCK = id('default:snowblock')


--- @param ids number[]
--- @return number
local function get_random_id(ids)
	return ids[math_random(1, #ids)]
end


--- @class mountgen.generator.Node
local Node = {}

--- @static
--- @param pos    Position
--- @param config table
--- @return number
function Node.get_rock(pos, config)
	return ID_STONE
end

--- @static
--- @param pos    Position
--- @param config table
--- @return number
function Node.get_coverage(pos, config)
	local place_snow = false
	local sl = config.SNOW_LINE - math_random(0, config.SNOW_LINE_RAND)
	if pos.y >= sl then
		place_snow = true
	end

	if place_snow then
		return ID_SNOW_BLOCK
	else
		-- TODO dont call `id()` everytime in cycle
		-- TODO for ex., replace with id right in `config` on save or apply
		return id(config.top_cover)
	end
end

--- @static
--- @param pos    Position
--- @param config table
--- @return number|nil
function Node.get_plant(pos, config)
	if pos.y >= config.SNOW_LINE - config.SNOW_LINE_RAND then
		return nil
	end
	if math_random(0, 100) < config.GRASS_PERCENT then
		return get_random_id(GRASS_IDS)
	end

	if pos.y <= config.FLOWERS_LINE and math_random(0, 100) < config.FLOWERS_PERCENT then
		return get_random_id(FLOWERS_IDS)
	end

	if pos.y <= config.TREE_LINE and math_random(0, 1000) < config.TREE_PROMILLE then
		return ID_SAPLING
	end

	return nil
end


return Node
