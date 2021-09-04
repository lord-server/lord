mountgen.mountgen = function(top, fun, config)
	top.x = math.floor(top.x+0.5)
	top.y = math.floor(top.y+0.5)
	top.z = math.floor(top.z+0.5)

	if top.y <= config.Y0 then
		minetest.log("Trying to build negative mountain")
		return
	end

	local y1 = config.Y0
	local y2 = top.y
	local H = y2 - y1
	local coneH = (H * 1.4)/(1-config.TOP_H)
	local yb = H*(1-1.4)
	local W = math.ceil(2*coneH*math.tan(config.ANGLE*3.141/180/2))+3

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
			mountgen.place_top(px, py, pz, config)
		end
	end
	end
end


