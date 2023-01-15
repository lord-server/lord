local S = minetest.get_translator("lottplants")

dofile(minetest.get_modpath("lottplants").."/nodes.lua")
dofile(minetest.get_modpath("lottplants").."/wild_food.lua")
dofile(minetest.get_modpath("lottplants").."/flowers.lua")

-- ===== GROWING TIME =====
-- 67 11
-- ольха
ALDINT = 67
ALDCHA = 11

-- яблоня
APPINT = 67
APPCHA = 11

-- берёза
BIRINT = 67
BIRCHA = 11

-- бук
BEEINT = 67
BEECHA = 11

-- кулумальда
CULINT = 67
CULCHA = 11

-- вяз
ELMINT = 67
ELMCHA = 11

-- ель
FIRINT = 67
FIRCHA = 11

-- лебетрон
LEBINT = 67
LEBCHA = 11

-- малорн
MALINT = 67
MALCHA = 11

-- лихолесье
MIRINT = 67
MIRCHA = 11

-- сосна
PININT = 67
PINCHA = 11

-- слива
PLUINT = 67
PLUCHA = 11

-- рябина
ROWINT = 67
ROWCHA = 11

-- белое дерево
WHIINT = 67
WHICHA = 11

-- йаванамирэ
YAVINT = 67
YAVCHA = 11

dofile(minetest.get_modpath("lottplants").."/functions.lua")

minetest.register_node("lottplants:brambles_of_mordor", {
	description = S("Brambles Of Mordor"),
	drawtype = "plantlike",
	tiles = { "lottplants_brambles_of_mordor.png" },
	inventory_image = "lottplants_brambles_of_mordor.png",
	wield_image = "lottplants_brambles_of_mordor.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 42,
	walkable = false,
	waving = 1,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_grey=1, grass=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:pilinehtar", {
	description = S("Pilinehtar"),
	drawtype = "plantlike",
	tiles = { "lottplants_pilinehtar.png" },
	inventory_image = "lottplants_pilinehtar.png",
	wield_image = "lottplants_pilinehtar.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 2,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_green=1, grass=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_abm({
	nodenames = {"group:flora"},
	neighbors = {"default:dirt_with_grass", "default:desert_sand"},
	interval = 50,
	chance = 25,
	action = function(pos, node)
		pos.y = pos.y - 1
		local under = minetest.get_node(pos)
		pos.y = pos.y + 1
		if under.name == "default:desert_sand" then
			minetest.set_node(pos, {name="lottplants:brambles_of_mordor"})
		elseif under.name ~= "default:dirt_with_grass" then
			return
		end

		local light = minetest.get_node_light(pos)
		if not light or light < 13 then
			return
		end

		local pos0 = {x=pos.x-4,y=pos.y-4,z=pos.z-4}
		local pos1 = {x=pos.x+4,y=pos.y+4,z=pos.z+4}
		if #minetest.find_nodes_in_area(pos0, pos1, "group:flora_block") > 0 then
			return
		end

		local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flora")
		if #flowers > 3 then
			return
		end

		local seedling = minetest.find_nodes_in_area(pos0, pos1, "default:dirt_with_grass")
		if #seedling > 0 then
			seedling = seedling[math.random(#seedling)]
			seedling.y = seedling.y + 1
			light = minetest.get_node_light(seedling)
			if not light or light < 13 then
				return
			end
			if minetest.get_node(seedling).name == "air" then
				minetest.set_node(seedling, {name=node.name})
			end
		end
	end,
})

minetest.register_craftitem("lottplants:honey", {
	description = S("Honey"),
	inventory_image = "lottplants_honey.png",
	on_use = minetest.item_eat(1),
})
