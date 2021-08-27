local config = {
	ANGLE=60,
	HEAD_ANGLE = 120,
	TOP_H = 0.3,
	Y0 = 0,
	USE_DIAMOND_SQUARE = true,
	SNOW_LINE = 50,
	SNOW_LINE_RAND = 4,
	GRASS_PERCENT = 10,
	FLOWERS_LINE = 35,
	FLOWERS_PERCENT = 10,
	TREE_LINE = 20,
	TREE_PROMILLE = 4,

	rk_big = 2,
	rk_small = 6,
	rk_thr = 4,
}

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


local function place_top(x, y, z, config)
	local pos = {x=x,y=y,z=z}
	local place_snow = false
	if SNOW_LINE ~= nil then
		local sl = config.SNOW_LINE - math.random(0, config.SNOW_LINE_RAND)
		if y >= sl then
			place_snow = true
		end
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


local function cone(W, H, config)
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

local function cut_peak(map, z, x)
	local v1 = get_value(map, z-1, x)
	local v2 = get_value(map, z+1, x)
	local v3 = get_value(map, z, x-1)
	local v4 = get_value(map, z, x+1)
	set_value(map, z, x, (v1+v2+v3+v4)/4)
end

local function diamond_square(W, H, config)
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

		if i < config.rk_thr then
			rk = config.rk_small
		else
			rk = config.rk_big
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

local function mountgen(top, fun, config)
	top.x = math.floor(top.x+0.5)
	top.y = math.floor(top.y+0.5)
	top.z = math.floor(top.z+0.5)

	local y1 = config.Y0
	local y2 = top.y
	local H = y2 - y1
	local coneH = (H * 1.4)/(1-config.TOP_H)
	local yb = H*(1-1.4)

	local W = 2*coneH*math.tan(config.ANGLE*3.141/180/2)

	if top.y <= config.Y0 then
		minetest.log("Trying to build negative mountain")
		return
	end

	local main_map, w, c = fun(W, coneH, config)
	local head_coneH = (w/2)/math.tan(config.HEAD_ANGLE*3.141/180/2)
	local head_map, _, _ = fun(W, head_coneH, config)


	for z = 1, w do
	for x = 1, w do
		local px = top.x + x-c
		local pz = top.z + z-c

		local height_main = main_map[z][x]
		local height_top  = head_map[z][x]+(coneH - head_coneH)-coneH*config.TOP_H
		local height = math.min(height_main, height_top)+yb

		for y=0,height do
			local py = y1 + y
			local pos = {x=px, y=py, z=pz}
			minetest.set_node(pos, {name="default:stone"})
		end

		local y = height
		local py = y1 + y
		if y >= 0 then
			place_top(px, py, pz, config)
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
 
		if config.USE_DIAMOND_SQUARE then
			mountgen(top, diamond_square, config)
		else
			mountgen(top, cone, config)
		end

		return itemstack
	end,
	group = {},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

