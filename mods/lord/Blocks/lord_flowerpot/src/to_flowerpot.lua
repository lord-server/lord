
local to_flowerpot = {
	-- lottplants flower
	'lottplants:anemones',
	'lottplants:seregon',
	'lottplants:asphodel',
	'lottplants:eglantive',
	'lottplants:elanor',
	'lottplants:iris',
	'lottplants:lissuin',
	'lottplants:mallos',
	'lottplants:niphredil',
	'lottplants:brambles_of_mordor',
	'lottplants:lorien_grass_4',
	'lottplants:pilinehtar',
	'lottplants:barley_wild',
	'lottplants:berries_wild',
	'lottplants:corn_wild',
	'lottplants:cabbage_wild',
	'lottplants:melon_wild',
	'lottplants:mushroom_wild',
	'lottplants:pipeweed_wild',
	'lottplants:potato_wild',
	'lottplants:tomatoes_wild',
	'lottplants:turnips_wild',
	-- lord_trees sapling
	'lord_trees:alder_sapling',
	'lord_trees:apple_sapling',
	'lord_trees:birch_sapling',
	'lord_trees:beech_sapling',
	'lord_trees:cherry_sapling',
	'lord_trees:culumalda_sapling',
	'lord_trees:elm_sapling',
	'lord_trees:fir_sapling',
	'lord_trees:lebethron_sapling',
	'lord_trees:mallorn_sapling',
	'lord_trees:pine_sapling',
	'lord_trees:plum_sapling',
	'lord_trees:rowan_sapling',
	'lord_trees:white_sapling',
	'lord_trees:yavannamire_sapling',
	'lord_trees:mirk_sapling',
	}

for _, node in pairs(to_flowerpot) do
	if minetest.registered_nodes[node] then
		flowerpot.register_node(node)
	end
end
