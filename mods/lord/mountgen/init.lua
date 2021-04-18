local ANGLE=45*3.141/180
local Y0 = 0

minetest.register_tool("mountgen:mount_tool", {
        description = "Горный посох",
        inventory_image = "ghost_tool.png",
        on_use = function(itemstack, user, pointed_thing)
		local pos = user:get_pos()
		minetest.log("use mount stick at "..pos.x.." "..pos.y.." "..pos.z)

		local H = pos.y - Y0
		local W = H * math.tan(ANGLE)

		local x1 = pos.x - W
		local x2 = pos.x + W

		local z1 = pos.z - W
		local z2 = pos.z + W

		local y1 = Y0
		local y2 = pos.y

		for y = y1,y2+1 do
		for x = x1,x2+1 do
		for z = z1,z2+1 do
			local dx = x - pos.x
			local dz = z - pos.z
			local d = math.sqrt(dx*dx+dz*dz)
			local h = y2-y
			if d <= h*math.tan(ANGLE) then
				minetest.set_node({x=x,y=y,z=z}, {name="default:stone"})
			end
		end
		end
		end

		return itemstack
	end
})

