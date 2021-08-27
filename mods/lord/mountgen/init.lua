local ANGLE=60*3.141/180
local HEAD_ANGLE = 120*3.141/180

local TOP_H = 0.3

local Y0 = 0
local USE_DIAMOND_SQUARE = true

local SNOW_LINE = 50
local SNOW_LINE_RAND = 4

local GRASS_PERCENT = 10

local FLOWERS_LINE = 35
local FLOWERS_PERCENT = 10

local TREE_LINE = 20
local TREE_PROMILLE = 4

local RAND_K = 2

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

local function get_value(map, z, x)
	local h = table.getn(map)
	local w = table.getn(map[1])

	if x < 0 or z < 0 or x >= w or z >= h then
		return 0
	end

	return map[z+1][x+1]
end

local function set_value(map, z, x, val)
	local h = table.getn(map)
	local w = table.getn(map[1])
	print(x, z, w, h)
	if x < 0 or z < 0 or x >= w or z >= h then
		return
	end
	map[z+1][x+1] = val
end


local function cone(W, H, rk_big, rk_small, n_size_thr)
        local angle = math.atan(W/2/H)
  
	local map = {}
	for i = 1, W do
		map[i] = {}
		for j = 1, W do
			map[i][j] = 0
		end
	end

	local l0 = math.sqrt(W/2*W/2 + W/2*W/2)

	for z = 0,W-1 do
	for x = 0,W-1 do
		local px = x - W/2
		local pz = z - W/2
		local l = math.sqrt(px*px+pz*pz)
		local h = H*(1-l/l0)
		set_value(map, z, x, h)
	end
	end
	return map, W, math.floor(W/2)+1
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



local function cut_peak(map, z, x)
	local v1 = get_value(map, z-1, x)
	local v2 = get_value(map, z+1, x)
	local v3 = get_value(map, z, x-1)
	local v4 = get_value(map, z, x+1)
	set_value(map, z, x, (v1+v2+v3+v4)/4)
end

local function diamond_square(W, H, rk_big, rk_small, n_size_thr)
	local n = math.ceil(math.log(W) / math.log(2))
	local r = math.pow(2, n-1)
	local w = 2*r + 1

	local map = {}
	for i = 1, w do
		map[i] = {}
		for j = 1, w do
			map[i][j] = 0
		end
	end

	local i = n
	while i >= 1 do
		local step = math.pow(2, i)
		local step2 = math.pow(2, i-1)

		local num = math.pow(2, n-i)
		local rk = RAND_K

		local rand

		if i < n_size_thr then
			rk = rk_small
		else
			rk = rk_big
		end

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
					rand = math.random(-step2/rk, step2/rk)
					local val = (val1 + val2 + val3 + val4)/4 + rand
					set_value(map, z+step2, x+step2, val)
					x = x + step
				end
				z = z + step
			end
		else
			set_value(map, step2, step2, H)
		end

		-- square
		local z = 0
		for _ = 1, num+1 do
			local x = 0
			for _ = 1, num+1 do
				local val1, val2, val3, val4
				local val

				rand = math.random(-step2/rk, step2/rk)
				val1 = get_value(map, z-step2, x+step2)
				val2 = get_value(map, z+step2, x+step2)
				val3 = get_value(map, z, x)
				val4 = get_value(map, z, x+step)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z, x+step2, val)

				rand = math.random(-step2/rk, step2/rk)
				val1 = get_value(map, z+step2, x-step2)
				val2 = get_value(map, z+step2, x+step2)
				val3 = get_value(map, z, x)
				val4 = get_value(map, z+step, x)
				val = (val1 + val2 + val3 + val4)/4 + rand
				set_value(map, z+step2, x, val)

				x = x + step
			end
			z = z + step
		end

		i = i - 1
	end

	cut_peak(map, r, r)

	return map, w, r+1
end

local function mountgen(top, fun)
	top.x = math.floor(top.x+0.5)
	top.y = math.floor(top.y+0.5)
	top.z = math.floor(top.z+0.5)

	local y1 = Y0
	local y2 = top.y
	local H = y2 - y1
	local coneH = (H * 1.4)/(1-TOP_H)
	local yb = H*(1-1.4)

	local W = 2*coneH*math.tan(ANGLE/2)

	if top.y <= Y0 then
		minetest.log("Trying to build negative mountain")
		return
	end

	local main_map, w, c = fun(W, coneH, RAND_K, RAND_K*3, 3)

	local head_coneH = (w/2)/math.tan(HEAD_ANGLE/2)
	local head_map, _, _ = fun(W, head_coneH, RAND_K, RAND_K*3, 3)


	for z = 1, w do
	for x = 1, w do
		local px = top.x + x-c
		local pz = top.z + z-c

		local height_main = main_map[z][x]
		local height_top  = head_map[z][x]+(coneH - head_coneH)-coneH*TOP_H
		local height = math.min(height_main, height_top)+yb

		for y=0,height do
			local py = y1 + y
			local pos = {x=px, y=py, z=pz}
			minetest.set_node(pos, {name="default:stone"})
		end

		local y = height
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
			mountgen(top, diamond_square)
		else
			mountgen(top, cone)
		end

		return itemstack
	end,
	group = {},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

