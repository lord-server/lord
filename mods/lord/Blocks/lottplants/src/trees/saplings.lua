local S = minetest.get_translator("lottplants")


local function register_sapling(node_name, title)
	title         = title:first_to_upper()
	local texture = node_name:replace(":", "_") .. ".png"

	minetest.register_node(node_name, {
		description     = S(title),
		drawtype        = "plantlike",
		visual_scale    = 1.0,
		tiles           = { texture },
		inventory_image = texture,
		wield_image     = texture,
		paramtype       = "light",
		waving          = 1,
		walkable        = false,
		selection_box     = {
			type  = "fixed",
			fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
		},
		groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
		sounds          = default.node_sound_defaults(),
	})

end

register_sapling("lottplants:aldersapling", "Alder Sapling")
register_sapling("lottplants:applesapling", "Apple Tree Sapling")
register_sapling("lottplants:birchsapling", "Birch Sapling")
register_sapling("lottplants:beechsapling", "Beech Sapling")
register_sapling("lottplants:culumaldasapling", "Culumalda Sapling")
register_sapling("lottplants:elmsapling", "Elm Sapling")
register_sapling("lottplants:firsapling", "Fir Sapling")
register_sapling("lottplants:lebethronsapling", "Lebethron Sapling")
register_sapling("lottplants:mallornsapling", "Mallorn Sapling")
register_sapling("lottplants:pinesapling", "Pine Sapling")
register_sapling("lottplants:plumsapling", "Plum Tree Sapling")
register_sapling("lottplants:rowansapling", "Rowan Sapling")
register_sapling("lottplants:whitesapling", "White Tree Sapling")
register_sapling("lottplants:yavannamiresapling", "Yavannamire Sapling")
register_sapling("lottplants:mirksapling", "Mirkwood Sapling")
