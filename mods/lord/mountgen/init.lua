local ANGLE=45*3.141/180
local Y0 = 0
local SNOW_LINE = 50
local SNOW_LINE_RAND = 4
local GRASS = true

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
--	minetest.log(name)
	minetest.set_node(pos, {name=name})
end

minetest.register_tool("mountgen:mount_tool", {
        description = "Горный посох",
        inventory_image = "ghost_tool.png",
        on_use = function(itemstack, user, pointed_thing)
		local top = user:get_pos()
		minetest.log("use mount stick at "..top.x.." "..top.y.." "..top.z)

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
			local top    = is_top(pos, top, ANGLE)

			if inside then
				if top then
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
						minetest.set_node(pos, {name="lottmapgen:dunland_grass"})
						if GRASS then
							if math.random(1,10) > 7 then
								place_grass({x=x,y=y+1,z=z})
							end
						end
					end
				else
					minetest.set_node(pos, {name="default:stone"})
				end
			end
		end
		end
		end

		return itemstack
	end
})

