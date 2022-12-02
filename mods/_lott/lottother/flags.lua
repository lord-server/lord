local SL       = lord.require_intllib()

local tapestry = {}

minetest.register_node("lottother:tapestry_top", {
	drawtype            = "nodebox",
	description         = SL("Tapestry Top"),
	tiles               = { "default_wood.png" },
	sunlight_propagates = true,
	groups              = { flammable = 3, oddly_breakable_by_hand = 1 },
	sounds              = default.node_sound_defaults(),
	paramtype           = "light",
	paramtype2          = "facedir",
	node_box            = {
		type  = "fixed",
		fixed = {
			{ -0.600000, -0.500000, 0.375000, 0.600000, -0.375000, 0.500000 },
		},
	},
	selection_box       = {
		type  = "fixed",
		fixed = {
			{ -0.600000, -0.500000, 0.375000, 0.600000, -0.375000, 0.500000 },
		},
	},
})

tapestry.colours = {
	{ "angmar", "Angmar", "angmar" },
	{ "dunland", "Dunland", "dunland" },
	{ "dwarf", "Dwarf", "dwarf" },
	{ "gondor", "Gondor", "gondor" },
	{ "lorien", "Lorien", "lorien" },
	{ "mirkwood", "Mirkwood", "mirkwood" },
	{ "mordor", "Mordor", "mordor" },
	{ "rohan", "Rohan", "rohan" },
	{ "urukhai", "Uruk Hai", "urukhai" },
	{ "shire", "Shire", "shire" },
}

for _, row in ipairs(tapestry.colours) do
	local name = row[1]
	local desc = row[2]
	-- Node Definition
	minetest.register_node("lottother:tapestry_" .. name, {
		drawtype      = "nodebox",
		description   = SL(desc .. " Tapestry"),
		tiles         = { "lottother_banner_" .. name .. ".png" },
		groups        = { oddly_breakable_by_hand = 3, flammable = 3 },
		sounds        = default.node_sound_defaults(),
		paramtype     = "light",
		paramtype2    = "facedir",
		drop          = '',
		node_box      = {
			type  = "fixed",
			fixed = {
				{ -0.312500, -0.500000, 0.437500, -0.187500, -0.375000, 0.500000 },
				{ 0.187500, -0.500000, 0.437500, 0.312500, -0.375000, 0.500000 },
				{ -0.375000, -0.375000, 0.437500, -0.125000, -0.250000, 0.500000 },
				{ 0.125000, -0.375000, 0.437500, 0.375000, -0.250000, 0.500000 },
				{ -0.437500, -0.250000, 0.437500, -0.062500, -0.125000, 0.500000 },
				{ 0.062500, -0.250000, 0.437500, 0.437500, -0.125000, 0.500000 },
				{ -0.500000, -0.125000, 0.437500, 0.000000, 0.000000, 0.500000 },
				{ 0.000000, -0.125000, 0.437500, 0.500000, 0.000000, 0.500000 },
				{ -0.500000, 0.000000, 0.437500, 0.500000, 0.500000, 0.500000 },
			},
		},
		selection_box = {
			type  = "fixed",
			fixed = {
				{ -0.500000, -0.500000, 0.437500, 0.500000, 1.500000, 0.500000 },
			},
		},
		on_place      = function(itemstack, placer, pointed_thing)
			local above = pointed_thing.above
			if minetest.get_node({ x = above.x, y = above.y + 1, z = above.z }).name ~= "air" then
				return itemstack
			end
			local fdir       = 0
			local placer_pos = placer:get_pos()
			if placer_pos then
				local dir  = {
					x = above.x - placer_pos.x,
					y = above.y - placer_pos.y,
					z = above.z - placer_pos.z
				}
				fdir = minetest.dir_to_facedir(dir)
			end
			minetest.add_node(above, { name = "lottother:tapestry_" .. name, param2 = fdir })
			minetest.add_node(
				{ x = above.x, y = above.y + 1, z = above.z },
				{ name = "lottother:tapestry_top_" .. name, param2 = fdir }
			)
			if not minetest.is_creative_enabled(placer) then
				itemstack:take_item()
			end
			return itemstack
		end,
		on_destruct   = function(pos)
			local p = { x = pos.x, y = pos.y + 1, z = pos.z }
			minetest.remove_node(p)
		end
	})
end

for _, row in ipairs(tapestry.colours) do
	local name = row[1]
	local desc = row[2]
	-- Node Definition
	minetest.register_node("lottother:tapestry_top_" .. name, {
		drawtype    = "nodebox",
		description = SL(desc .. " Tapestry Top"),
		tiles       = { "lottother_banner_top_" .. name .. ".png" },
		groups      = { oddly_breakable_by_hand = 3, flammable = 3, not_in_creative_inventory = 1 },
		sounds      = default.node_sound_defaults(),
		paramtype   = "light",
		paramtype2  = "facedir",
		drop        = '',
		pointable   = false,
		node_box    = {
			type  = "fixed",
			fixed = {
				{ -0.500000, -0.500000, 0.437500, 0.500000, 0.500000, 0.500000 },
			},
		},
	})
end
