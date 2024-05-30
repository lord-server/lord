local S = minetest.get_translator("lord_beds")

beds.register_bed("lord_beds:straw_bed", {
	description = S("Straw Bed"),
	inventory_image = "straw_bed.png",
	wield_image = "straw_bed.png",
	tiles = {
		bottom = {
            "castle_straw.png^[transformR90",
			"castle_straw.png^[transformR90",
			"castle_straw.png",
			"castle_straw.png^[transformFX",
			"beds_transparent.png",
			"castle_straw.png"
		},
		top = {
            "castle_straw.png^[transformR90",
			"castle_straw.png^[transformR90",
			"castle_straw.png",
			"castle_straw.png^[transformFX",
			"castle_straw.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
        bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5}
	},
    selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
	recipe = {
		{"stairs:slab_straw", "stairs:slab_straw"}
	},
})
