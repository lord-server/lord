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

local function get_height(z, x, r, y1, y2, zbase, xbase)
	local py = y1
	local px = xbase + x - r - 1
	local pz = zbase + z - r - 1
	while py <= y2 do
		local pos = {x=px, y=py, z=pz}
		local node = minetest.get_node(pos)
		if node.name == "ignore" then
			minetest.get_voxel_manip():read_from_map(pos, pos)
			node = minetest.get_node(pos)
		end
		minetest.log("x = "..px.." y = "..py.." z = "..pz.." node = "..node.name)
		if node.name == "air" then
			return math.max(py-1, y1)
		end
		py = py + 1
	end
	minetest.log("end at top!!!!")
	return y2
end


local function get_value(map, z, x, r, y1, y2, zbase, xbase)
	local h = table.getn(map)
	local w = table.getn(map[1])

	if x < 0 or z < 0 or x >= w or z >= h then
		return get_height(z, x, r, y1, y2, zbase, xbase)
	end

	return map[z+1][x+1]
end

local function set_value(map, z, x, val)
	local h = table.getn(map)
	local w = table.getn(map[1])
	if x < 0 or z < 0 or x >= w or z >= h then
		return
	end
	map[z+1][x+1] = val
end


local function cut_peak(map, z, x, r, y1, y2, zbase, xbase)
	local v1 = get_value(map, z-1, x, r, y1, y2, zbase, xbase)
	local v2 = get_value(map, z+1, x, r, y1, y2, zbase, xbase)
	local v3 = get_value(map, z, x-1, r, y1, y2, zbase, xbase)
	local v4 = get_value(map, z, x+1, r, y1, y2, zbase, xbase)
	set_value(map, z, x, (v1+v2+v3+v4)/4)
end

local function diamond_square(top)
	top.x = math.floor(top.x+0.5)
	top.y = math.floor(top.y+0.5)
	top.z = math.floor(top.z+0.5)


	local W = (top.y - Y0)*math.tan(ANGLE)
	local n = math.ceil(math.log(W) / math.log(2))


--	local n = 7
	local r = math.pow(2, n-1)
	local w = 2*r + 1

	minetest.log("n = "..tostring(n).." w = "..w)

	if top.y <= Y0 then
		minetest.log("Trying to build negative mountain")
		return
	end

	local map = {}
	for i = 1, w do
		map[i] = {}
		for j = 1, w do
			map[i][j] = 0
		end
	end
--	init

	local y1 = Y0
	local y2 = top.y

	local h1 = get_height(0, 0, r,   y1, y2, top.z, top.x)
	local h2 = get_height(0, w-1, r, y1, y2, top.z, top.x)
	local h3 = get_height(w-1,0,r,   y1, y2, top.z, top.x)
	local h4 = get_height(w-1,w-1,r, y1, y2, top.z, top.x)

	minetest.log("initial "..h1.." "..h2.." "..h3.." "..h4)
	set_value(map, 0, 0,     (y1+h1)/2)
	set_value(map, 0, w-1,   (y1+h2)/2)
	set_value(map, w-1, 0,   (y1+h3)/2)
	set_value(map, w-1, w-1, (y1+h4)/2)

	local rnd = 2

	local i = n
	while i >= 1 do
		local step = math.pow(2, i)
		local step2 = math.pow(2, i-1)

		local num = math.pow(2, n-i)
		local rand

--		minetest.log("----------")
--		minetest.log("step = "..step.." step2 = "..step2)
		-- diamond
--		minetest.log("diamond")
		if i < n then
			local z = 0
			for _ = 1, num do
				local x = 0
				for _ = 1, num do
					local val1 = get_value(map, z, x, r, y1, y2, top.z, top.x)
					local val2 = get_value(map, z+step, x, r, y1, y2, top.z, top.x)
					local val3 = get_value(map, z, x+step, r, y1, y2, top.z, top.x)
					local val4 = get_value(map, z+step, x+step, r, y1, y2, top.z, top.x)
					rand = math.random(-step2/rnd, step2/rnd)
					local val = (val1 + val2 + val3 + val4)/4 + rand
					set_value(map, z+step2, x+step2, val)
					x = x + step
				end
				z = z + step
			end
		else
			set_value(map, step2, step2, y2)
		end

		-- square
--		minetest.log("square")
		local z = 0
		for _ = 1, num+1 do
			local x = 0
			for _ = 1, num+1 do
				local val1, val2, val3, val4
				local val

				rand = math.random(-step2/rnd, step2/rnd)
				val1 = get_value(map, z-step2, x+step2, r, y1, y2, top.z, top.x)
				val2 = get_value(map, z+step2, x+step2, r, y1, y2, top.z, top.x)
				val3 = get_value(map, z, x, r, y1, y2, top.z, top.x)
				val4 = get_value(map, z, x+step, r, y1, y2, top.z, top.x)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z, x+step2, val)

				rand = math.random(-step2/rnd, step2/rnd)
				val1 = get_value(map, z+step2, x-step2, r, y1, y2, top.z, top.x)
				val2 = get_value(map, z+step2, x+step2, r, y1, y2, top.z, top.x)
				val3 = get_value(map, z, x, r, y1, y2, top.z, top.x)
				val4 = get_value(map, z+step, x, r, y1, y2, top.z, top.x)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z+step2, x, val)

				x = x + step
			end
			z = z + step
		end

		i = i - 1
--		break
	end

	-- fix center of mountain
--	minetest.log("cut peaks")
	cut_peak(map, r, r, r, y1, y2, top.z, top.x)
	cut_peak(map, 0, r, r, y1, y2, top.z, top.x)
	cut_peak(map, r, 0, r, y1, y2, top.z, top.x)
	cut_peak(map, r, 2*r, r, y1, y2, top.z, top.x)
	cut_peak(map, 2*r, r, r, y1, y2, top.z, top.x)

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
		if y >= 0 then
			place_top(px, py, pz)
		end
	end
	end
end

minetest.register_tool("mountgen:mount_tool", {
	description = "Горный посох",
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, user, pointed_thing)
		local user_name = user:get_player_name()
		local can_access = minetest.get_player_privs(user_name).admin_pick
		if not can_access then
			return
		end
		local top = user:get_pos()
		minetest.log("use mount stick at "..top.x.." "..top.y.." "..top.z)

		if USE_DIAMOND_SQUARE then
			diamond_square(top)
		else
			cone_mountgen()
		end

		return itemstack
	end,
	group = {},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

