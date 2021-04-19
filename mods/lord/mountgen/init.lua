local ANGLE=60*3.141/180
local Y0 = 0
local USE_DIAMOND_SQUARE = true

local SNOW_LINE = 50
local SNOW_LINE_RAND = 4

local GRASS_PERCENT = 10

local FLOWERS_LINE = 35
local FLOWERS_PERCENT = 10

local TREE_LINE = 20
local TREE_PROMILLE = 4

local function is_inside(pos, top, angle)
	local dx = pos.x - top.x
	local dz = pos.z - top.z
	local d = math.sqrt(dx*dx+dz*dz)
	local h = top.y-pos.y
	return d <= h*math.tan(ANGLE)
end

local function is_top(pos, top, angle)
	return is_inside(pos, top, angle) and not is_inside({x=pos.x, y=pos.y+1, z=pos.z}, top, angle)
end

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


local function place_top(x, y, z)
	local pos = {x=x,y=y,z=z}
	local place_snow = false
	if SNOW_LINE ~= nil then
		local sl = SNOW_LINE - math.random(0, SNOW_LINE_RAND)
		if y >= sl then
			place_snow = true
		end
	end

	if place_snow then
		minetest.set_node(pos, {name="default:snowblock"})
	else
		local upper = {x=x,y=y+1,z=z}
		minetest.set_node(pos, {name="lottmapgen:dunland_grass"})
		if math.random(0,100) < GRASS_PERCENT then
			place_grass(upper)
		end

		if y <= FLOWERS_LINE then
			if math.random(0,100) < FLOWERS_PERCENT then
				place_flower(upper)
			end
		end

		if y <= TREE_LINE then
			if math.random(0,1000) < TREE_PROMILLE then
				place_sapling(upper)
			end
		end

	end

end

local function cone_mountgen(top)
	local H = top.y - Y0
	local W = H * math.tan(ANGLE)

	local x1 = top.x - W
	local x2 = top.x + W

	local z1 = top.z - W
	local z2 = top.z + W

	local y1 = Y0
	local y2 = top.y

	for y = y1,y2+1 do
	for x = x1,x2+1 do
	for z = z1,z2+1 do
		local pos = {x=x,y=y,z=z}
		local inside = is_inside(pos, top, ANGLE)
		local istop    = is_top(pos, top, ANGLE)

		if inside then
			if istop then
				place_top(x, y, z)
			else
				minetest.set_node(pos, {name="default:stone"})
			end
		end
	end
	end
	end
end

local function get_value(map, z, x)
	local h = table.getn(map)
	local w = table.getn(map[1])


--	if x < 0 or z < 0 or x >= w or z >= h then
--		return Y0
--	end
	while z < 0 do
		z = z + h
	end

	while z >= h do
		z = z - h
	end

	while x < 0 do
		x = x + w
	end

	while x >= w do
		x = x - w
	end

	return map[z+1][x+1]
end

local function set_value(map, z, x, val)
	map[z+1][x+1] = val
end

local function diamond_square(top)
	local W = (top.y - Y0)*math.tan(ANGLE)
	local n = math.ceil(math.log(W) / math.log(2))


--	local n = 7
	local r = math.pow(2, n-1)
	local w = 2*r + 1

	minetest.log("n = "..tostring(n).." w = "..w)

	local map = {}
	for i = 1, w+1 do
		map[i] = {}
		for j = 1, w+1 do
			map[i][j] = 0
		end
	end
--	init
	set_value(map, 0, 0, Y0)
	set_value(map, 0, w-1, Y0)
	set_value(map, w-1, 0, Y0)
	set_value(map, w-1, w-1, Y0)

	local rnd = 2

	local i = n
	while i >= 1 do
		local step = math.pow(2, i)
		local step2 = math.pow(2, i-1)

		local num = math.pow(2, n-i)

		-- diamond
		if i < n then
			local z = 0
			for _ = 1, num do
				local x = 0
				for _ = 1, num do
					local val1 = get_value(map, z, x)
					local val2 = get_value(map, z+step, x)
					local val3 = get_value(map, z, x+step)
					local val4 = get_value(map, z+step, x+step)
					local val = (val1 + val2 + val3 + val4)/4 + math.random(-step2/rnd, step2/rnd)
					set_value(map, z+step2, x+step2, val)
					x = x + step
				end
				z = z + step
			end
		else
			set_value(map, step2, step2, top.y)
		end

		-- square
		local z = 0
		for _ = 1, num do
			local x = 0
			for _ = 1, num do
				local val1, val2, val3, val4
				local val
				local rand

				rand = math.random(-step2/rnd, step2/rnd)
				val1 = get_value(map, z-step2, x+step2)
				val2 = get_value(map, z+step2, x+step2)
				val3 = get_value(map, z, x)
				val4 = get_value(map, z, x+step)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z, x+step2, val)

				rand = math.random(-step2/rnd, step2/rnd)
				val1 = get_value(map, z+step-step2, x+step2)
				val2 = get_value(map, z+step+step2, x+step2)
				val3 = get_value(map, z+step, x)
				val4 = get_value(map, z+step, x+step)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z+step, x+step2, val)

				rand = math.random(-step2/rnd, step2/rnd)
				val1 = get_value(map, z+step2, x-step2)
				val2 = get_value(map, z+step2, x+step2)
				val3 = get_value(map, z, x)
				val4 = get_value(map, z+step, x)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z+step2, x, val)

				rand = math.random(-step2/rnd, step2/rnd)
				val1 = get_value(map, z+step2, x+step2)
				val2 = get_value(map, z+step2, x+step+step2)
				val3 = get_value(map, z, x+step)
				val4 = get_value(map, z+step, x+step)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z+step2, x+step, val)

				x = x + step
			end
			z = z + step
		end

		i = i - 1
--		break
	end

	-- fix center of mountain
	local avc = (get_value(map, r-1, r) + get_value(map, r+1, r) + get_value(map, r, r+1) + get_value(map, r, r-1))/4
	set_value(map, r, r, avc)

	for z = 1, w do
	for x = 1, w do
		local px = top.x+x-r-1
		local pz = top.z+z-r-1

		for y=0,map[z][x] do
			local py = Y0 + y
			local pos = {x=px, y=py, z=pz}
			minetest.set_node(pos, {name="default:stone"})
		end
		local y = map[z][x]

		local py = Y0 + y
		place_top(px, py, pz)
	end
	end
end

minetest.register_tool("mountgen:mount_tool", {
        description = "Горный посох",
        inventory_image = "ghost_tool.png",
        on_use = function(itemstack, user, pointed_thing)
		local top = user:get_pos()
		minetest.log("use mount stick at "..top.x.." "..top.y.." "..top.z)

		if USE_DIAMOND_SQUARE then
			diamond_square(top)
		else
			cone_mountgen()
		end

		return itemstack
	end
})

