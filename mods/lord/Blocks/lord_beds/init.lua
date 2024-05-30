local S = minetest.get_translator("lord_beds")

beds.register_bed("lord_beds:straw_bed", {
	description = S("Straw Bed"),
	inventory_image = "straw_bed.png",
	wield_image = "straw_bed.png",
	tiles = {
		bottom = {
            "lord_beds_straw_bed_top_bottom.png^[transformR90",
			"lord_beds_straw_bed_under.png",
			"lord_beds_straw_bed_side_bottom_r.png",
			"lord_beds_straw_bed_side_bottom_r.png^[transformFX",
			"beds_transparent.png",
			"lord_beds_straw_bed_side_bottom.png"
		},
		top = {
            "lord_beds_straw_bed_top_top.png^[transformR90",
			"lord_beds_straw_bed_under.png",
			"lord_beds_straw_bed_side_top_r.png",
			"lord_beds_straw_bed_side_top_r.png^[transformFX",
			"lord_beds_straw_bed_side_top.png",
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
