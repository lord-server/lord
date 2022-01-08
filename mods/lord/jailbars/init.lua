local SL = minetest.get_translator("jailbars")

-- xjailbarss mod by xyz

local function rshift(x, by)
	return math.floor(x / 2 ^ by)
end

local directions = {
	{ x = 1, y = 0, z = 0 },
	{ x = 0, y = 0, z = 1 },
	{ x = -1, y = 0, z = 0 },
	{ x = 0, y = 0, z = -1 },
}

local function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

local function update_jailbars(pos)
	local name = minetest.get_node(pos).name
	local parts = mysplit(name, '_')

	if parts[1] ~= "jailbars:jailbars" then
		return
	end

	if table.getn(parts) < 2 then
		return
	end

	local material = parts[2]

	local sum = 0
	for i = 1, 4 do
		local node = minetest.get_node({
			x = pos.x + directions[i].x,
			y = pos.y + directions[i].y,
			z = pos.z + directions[i].z
		})
		if minetest.registered_nodes[node.name].walkable ~= false then
			sum = sum + 2 ^ (i - 1)
		end
	end
	if sum == 0 then
		sum = 15
	end
	minetest.add_node(pos, { name = "jailbars:jailbars_" .. material.."_"..sum })
end

local function update_nearby(pos)
	for i = 1, 4 do
		update_jailbars({ x = pos.x + directions[i].x, y = pos.y + directions[i].y, z = pos.z + directions[i].z })
	end
end

local half_blocks = {
	{ 0, -0.5, -0.06, 0.5, 0.5, 0.06 },
	{ -0.06, -0.5, 0, 0.06, 0.5, 0.5 },
	{ -0.5, -0.5, -0.06, 0, 0.5, 0.06 },
	{ -0.06, -0.5, -0.5, 0.06, 0.5, 0 }
}

local full_blocks = {
	{ -0.5, -0.5, -0.06, 0.5, 0.5, 0.06 },
	{ -0.06, -0.5, -0.5, 0.06, 0.5, 0.5 }
}

local function register_jailbars(material, groups)
	for i = 1, 15 do
		local need = {}
		local cnt  = 0
		for j = 1, 4 do
			if rshift(i, j - 1) % 2 == 1 then
				need[j] = true
				cnt     = cnt + 1
			end
		end
		local take = {}
		if need[1] == true and need[3] == true then
			need[1] = nil
			need[3] = nil
			table.insert(take, full_blocks[1])
		end
		if need[2] == true and need[4] == true then
			need[2] = nil
			need[4] = nil
			table.insert(take, full_blocks[2])
		end
		for k in pairs(need) do
			table.insert(take, half_blocks[k])
		end
		local texture = "castle_jailbars_"..material..".png"
		if cnt == 1 then
			texture = "castle_jailbars_"..material..".png"
		end
		minetest.register_node("jailbars:jailbars_"..material.."_".. i, {
			drawtype      = "nodebox",
			tiles         = { "castle_grey.png", "castle_grey.png", texture },
			paramtype     = "light",
			groups        = groups,
			drop          = "jailbars:jailbars_"..material,
			node_box      = {
				type  = "fixed",
				fixed = take
			},
			selection_box = {
				type  = "fixed",
				fixed = take
			}
		})
	end

	minetest.register_node("jailbars:jailbars_"..material, {
		description               = SL(material.." jailbars"),
		tiles                     = { "castle_space.png" },
		inventory_image           = "castle_jailbars_"..material..".png",
		wield_image               = "castle_jailbars_"..material..".png",
		groups                    = { steel_item = 1 },
		node_placement_prediction = "",
		on_construct              = update_jailbars
	})

	minetest.register_craft({
		output = "jailbars:jailbars_"..material.." 12",
		recipe = {
			{ "default:"..material.."_ingot", "", "default:"..material.."_ingot" },
			{ "default:"..material.."_ingot", "default:"..material.."_ingot", "default:"..material.."_ingot" },
			{ "default:"..material.."_ingot", "", "default:"..material.."_ingot" },
		}
	})
end

register_jailbars("steel", { cracky = 2})
register_jailbars("tilkal", { forbidden = 1})

minetest.register_on_placenode(update_nearby)
minetest.register_on_dignode(update_nearby)


