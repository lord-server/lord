local SL = lord.require_intllib()

-- FLOWERS

minetest.register_node("lottplants:athelas", {
	description = SL("Athelas"),
	drawtype = "plantlike",
	tiles = { "lottplants_athelas.png" },
	inventory_image = "lottplants_athelas.png",
	wield_image = "lottplants_athelas.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:athelas'} },
			{ items = {'lottfarming:athelas'}, rarity = 5},
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:anemones", {
	description = SL("Anemones"),
	drawtype = "plantlike",
	tiles = { "lottplants_anemones.png" },
	inventory_image = "lottplants_anemones.png",
	wield_image = "lottplants_anemones.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:anemones_fake'} },
			{ items = {'lottplants:anemones'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:asphodel", {
	drawtype = "plantlike",
	tiles = { "lottplants_asphodel.png" },
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:asphodel_fake'} },
			{ items = {'lottplants:asphodel'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:eglantive", {
	description = SL("Eglantive"),
	drawtype = "plantlike",
	tiles = { "lottplants_eglantive.png" },
	inventory_image = "lottplants_eglantive.png",
	wield_image = "lottplants_eglantive.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {

		max_items = 2,
		items = {
			{ items = {'lottplants:eglantive_fake'} },
			{ items = {'lottplants:eglantive'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:elanor", {
	drawtype = "plantlike",
	tiles = { "lottplants_elanor.png" },
	inventory_image = "lottplants_elanor.png",
	wield_image = "lottplants_elanor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:elanor_fake'} },
			{ items = {'lottplants:elanor'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:iris", {
	description = SL("Iris"),
	drawtype = "plantlike",
	tiles = { "lottplants_iris.png" },
	inventory_image = "lottplants_iris.png",
	wield_image = "lottplants_iris.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:iris_fake'} },
			{ items = {'lottplants:iris'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:lissuin", {
	description = SL("Lissuin"),
	drawtype = "plantlike",
	tiles = { "lottplants_lissuin.png" },
	inventory_image = "lottplants_lissuin.png",
	wield_image = "lottplants_lissuin.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:lissuin_fake'} },
			{ items = {'lottplants:lissuin'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:mallos", {
	description = SL("Mallos"),
	drawtype = "plantlike",
	tiles = { "lottplants_mallos.png" },
	inventory_image = "lottplants_mallos.png",
	wield_image = "lottplants_mallos.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:mallos_fake'} },
			{ items = {'lottplants:mallos'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:niphredil", {
	description = SL("Niphredil"),
	drawtype = "plantlike",
	tiles = { "lottplants_niphredil.png" },
	inventory_image = "lottplants_niphredil.png",
	wield_image = "lottplants_niphredil.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:niphredil_fake'} },
			{ items = {'lottplants:niphredil'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_brown=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:seregon", {
	description = SL("Seregon"),
	drawtype = "plantlike",
	tiles = { "lottplants_seregon.png" },
	inventory_image = "lottplants_seregon.png",
	wield_image = "lottplants_seregon.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:seregon_fake'} },
			{ items = {'lottplants:seregon'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- FAKE

minetest.register_node("lottplants:anemones_fake", {
	description = SL("Anemones"),
	drawtype = "plantlike",
	tiles = { "lottplants_anemones.png" },
	inventory_image = "lottplants_anemones.png",
	wield_image = "lottplants_anemones.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:asphodel_fake", {
	description = SL("Asphodel"),
	drawtype = "plantlike",
	tiles = { "lottplants_asphodel.png" },
	inventory_image = "lottplants_asphodel.png",
	wield_image = "lottplants_asphodel.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:eglantive_fake", {
	description = SL("Eglantive"),
	drawtype = "plantlike",
	tiles = { "lottplants_eglantive.png" },
	inventory_image = "lottplants_eglantive.png",
	wield_image = "lottplants_eglantive.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:elanor_fake", {
	description = SL("Elanor"),
	drawtype = "plantlike",
	tiles = { "lottplants_elanor.png" },
	inventory_image = "lottplants_elanor.png",
	wield_image = "lottplants_elanor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:iris_fake", {
	description = SL("Iris"),
	drawtype = "plantlike",
	tiles = { "lottplants_iris.png" },
	inventory_image = "lottplants_iris.png",
	wield_image = "lottplants_iris.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),

	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:lissuin_fake", {
	description = SL("Lissuin"),
	drawtype = "plantlike",
	tiles = { "lottplants_lissuin.png" },
	inventory_image = "lottplants_lissuin.png",
	wield_image = "lottplants_lissuin.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:mallos_fake", {
	description = SL("Mallos"),
	drawtype = "plantlike",
	tiles = { "lottplants_mallos.png" },
	inventory_image = "lottplants_mallos.png",
	wield_image = "lottplants_mallos.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:niphredil_fake", {
	description = SL("Niphredil"),
	drawtype = "plantlike",
	tiles = { "lottplants_niphredil.png" },
	inventory_image = "lottplants_niphredil.png",
	wield_image = "lottplants_niphredil.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_brown=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:seregon_fake", {
	description = SL("Seregon"),
	drawtype = "plantlike",
	tiles = { "lottplants_seregon.png" },
	inventory_image = "lottplants_seregon.png",
	wield_image = "lottplants_seregon.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
