local S = minetest.get_translator("castle")

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

local function update_jailbars(pos)
	if minetest.get_node(pos).name:find("castle:jailbars") == nil then
		return
	end
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
	minetest.add_node(pos, { name = "castle:jailbars_" .. sum })
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
	local texture = "castle_jailbars.png"
	if cnt == 1 then
		texture = "castle_jailbars.png"
	end
	minetest.register_node("castle:jailbars_" .. i, {
		drawtype          = "nodebox",
		tiles             = { "castle_grey.png", "castle_grey.png", texture },
		use_texture_alpha = "clip",
		paramtype         = "light",
		groups            = { cracky = 2 },
		sounds            = default.node_sound_metal_defaults(),
		drop              = "castle:jailbars",
		node_box          = {
			type  = "fixed",
			fixed = take
		},
		selection_box = {
			type  = "fixed",
			fixed = take
		}
	})
end

minetest.register_node("castle:jailbars", {
	description               = S("Jailbars"),
	tiles                     = { "castle_space.png" },
	inventory_image           = "castle_jailbars.png",
	wield_image               = "castle_jailbars.png",
	groups                    = { steel_item = 1 },
	sounds                    = default.node_sound_metal_defaults(),
	node_placement_prediction = "",
	on_construct              = update_jailbars
})

minetest.register_on_placenode(update_nearby)
minetest.register_on_dignode(update_nearby)

minetest.register_craft({
	output = "castle:jailbars 12",
	recipe = {
		{ "default:steel_ingot", "", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "", "default:steel_ingot" },
	}
})
