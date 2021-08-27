local function place_grass(pos)
	local id = math.random(2,5)
	local name = "default:grass_"..tostring(id)
	minetest.set_node(pos, {name=name})
end

local function place_flower(pos)
	local names = {	"flowers:dandelion_white",
			"flowers:dandelion_yellow",
			"flowers:geranium",
			"flowers:rose",
			"flowers:tulip",
			"flowers:viola"
			}
	local id = math.random(1,#names)
	local name = names[id]
	minetest.set_node(pos, {name=name})
end

local function place_sapling(pos)
	local name = "default:sapling"
	minetest.set_node(pos, {name=name})
	--default.grow_tree({x=pos.x, y=pos.y-1,z=pos.z}, math.random(1, 4) == 1)
end


mountgen.place_top = function(x, y, z, config)
	local pos = {x=x,y=y,z=z}

	local place_snow = false
	local sl = config.SNOW_LINE - math.random(0, config.SNOW_LINE_RAND)
	if y >= sl then
		place_snow = true
	end

	if place_snow then
		minetest.set_node(pos, {name="default:snowblock"})
	else
		local upper = {x=x,y=y+1,z=z}
		minetest.set_node(pos, {name="lottmapgen:dunland_grass"})
		if math.random(0,100) < config.GRASS_PERCENT then
			place_grass(upper)
		end

		if y <= config.FLOWERS_LINE then
			if math.random(0,100) < config.FLOWERS_PERCENT then
				place_flower(upper)
			end
		end

		if y <= config.TREE_LINE then
			if math.random(0,1000) < config.TREE_PROMILLE then
				place_sapling(upper)
			end
		end

	end

end

