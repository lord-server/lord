local SL = lord.require_intllib()


local function register_tapestry_top(node_name, craft_from, description_material, texture)
	local node_and_selection_box = {
		type  = "fixed",
		fixed = { { -0.600000, -0.500000, 0.375000, 0.600000, -0.375000, 0.500000 }, },
	}
	minetest.register_node(node_name, {
		drawtype            = "nodebox",
		description         = SL("@1 Tapestry Top", description_material),
		tiles               = { texture },
		sunlight_propagates = true,
		groups              = { flammable = 3, oddly_breakable_by_hand = 1 },
		sounds              = default.node_sound_defaults(),
		paramtype           = "light",
		paramtype2          = "facedir",
		node_box            = node_and_selection_box,
		selection_box       = node_and_selection_box,
	})

	minetest.register_craft({
		type   = "shapeless",
		output = node_name,
		recipe = { craft_from },
	})
end
-- [code-labels]: planks, sticks
local tapestry_tops = {
--	  node_name                         craft_from                   description_material   texture
	{ "castle:tapestry_top",            "default:stick",               SL("Apple"),     "default_wood.png"          },
	{ "castle:tapestry_top_junglewood", "lottblocks:stick_junglewood", SL("Jungle Wood"),"default_junglewood.png"   },
	{ "castle:tapestry_top_alder",      "lottblocks:stick_alder",      SL("Alder"),     "lord_planks_alder.png"     },
	{ "castle:tapestry_top_beech",      "lottblocks:stick_beech",      SL("Beech"),     "lord_planks_beech.png"     },
	{ "castle:tapestry_top_birch",      "lottblocks:stick_birch",      SL("Birch"),     "lord_planks_birch.png"     },
	{ "castle:tapestry_top_cherry",     "lottblocks:stick_cherry",     SL("Cherry"),    "lord_planks_cherry.png"    },
	{ "castle:tapestry_top_elm",        "lottblocks:stick_elm",        SL("Elm"),       "lord_planks_elm.png"       },
	{ "castle:tapestry_top_fir",        "lottblocks:stick_fir",        SL("Fir"),       "lord_planks_fir.png"       },
	{ "castle:tapestry_top_hardwood",   "lottblocks:stick_hardwood",   SL("Hardwood"),  "lord_planks_hardwood.png"  },
	{ "castle:tapestry_top_lebethron",  "lottblocks:stick_lebethron",  SL("Lebethron"), "lord_planks_lebethron.png" },
	{ "castle:tapestry_top_mallorn",    "lottblocks:stick_mallorn",    SL("Mallorn"),   "lord_planks_mallorn.png"   },
	{ "castle:tapestry_top_pine",       "lottblocks:stick_pine",       SL("Pine"),      "lord_planks_pine.png"      },
}
for _, tapestry_top in pairs(tapestry_tops) do
	register_tapestry_top(unpack(tapestry_top))
end
-- ^^^ tapestry tops aren't used in tapestry crafting, for building only



local tapestry = {} -- namespace

---@type NodeDefinition
local tapestry_node_def_template = {
	drawtype = "nodebox",
	groups = { oddly_breakable_by_hand=3, flammable=3 },
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
}

--- Registers normal tapestry with given params without craft recipe.
---@param name        string @Example: `"castle:tapestry_violet"`
---@param desc_prefix string @Final description will be `desc_prefix .. " Tapestry"`
---@param tile        string @texture. Example: `"wool_blue.png"`
function tapestry.register(name, desc_prefix, tile)
	minetest.register_node(name, table.overwrite(tapestry_node_def_template, {
		description = SL(desc_prefix.." Tapestry"),
		tiles = { tile, },
		drawtype = "mesh",
		mesh = "tapestry.obj",
	    selection_box = {
		    type = "fixed",
		    fixed = {
			    {-0.500000,-0.500000,0.437500,0.500000,1.500000,0.500000},
		    },
	    },
	}))
end

--- Registers long tapestry with given params without craft recipe.
---@param name        string @Example: `"castle:long_tapestry_violet"`
---@param desc_prefix string @Final description will be `desc_prefix .. " Tapestry (Long)"`
---@param tile        string @texture. Example: `"wool_blue.png"`
function tapestry.register_long(name, desc_prefix, tile)
	minetest.register_node(name, table.merge(tapestry_node_def_template, {
		description = SL(desc_prefix.." Tapestry (Long)"),
		tiles = { tile, },
		node_box = {
		    type = "fixed",
		    fixed = {
			    {-0.312500,-0.500000,0.437500,-0.187500,-0.375000,0.500000},
			    {0.187500,-0.500000,0.437500,0.312500,-0.375000,0.500000},
			    {-0.375000,-0.375000,0.437500,-0.125000,-0.250000,0.500000},
			    {0.125000,-0.375000,0.437500,0.375000,-0.250000,0.500000},
			    {-0.437500,-0.250000,0.437500,-0.062500,-0.125000,0.500000},
			    {0.062500,-0.250000,0.437500,0.437500,-0.125000,0.500000},
			    {-0.500000,-0.125000,0.437500,0.000000,0.000000,0.500000},
			    {0.000000,-0.125000,0.437500,0.500000,0.000000,0.500000},
			    {-0.500000,0.000000,0.437500,0.500000,2.500000,0.500000},
		    },
	    },
	    selection_box = {
		    type = "fixed",
		    fixed = {
			    {-0.500000,-0.500000,0.437500,0.500000,2.500000,0.500000},
		    },
	    },
	}))
end

--- Registers very long tapestry with given params without craft recipe.
---@param name        string @Example: `"castle:very_long_tapestry_violet"`
---@param desc_prefix string @Final description will be `desc_prefix .. " Tapestry (Very Long)"`
---@param tile        string @texture. Example: `"wool_blue.png"`
function tapestry.register_very_long(name, desc_prefix, tile)
	minetest.register_node(name, table.merge(tapestry_node_def_template, {
		description = SL(desc_prefix.." Tapestry (Very Long)"),
		tiles = { tile, },
		node_box = {
		    type = "fixed",
		    fixed = {
			    {-0.312500,-0.500000,0.437500,-0.187500,-0.375000,0.500000},
			    {0.187500,-0.500000,0.437500,0.312500,-0.375000,0.500000},
			    {-0.375000,-0.375000,0.437500,-0.125000,-0.250000,0.500000},
			    {0.125000,-0.375000,0.437500,0.375000,-0.250000,0.500000},
			    {-0.437500,-0.250000,0.437500,-0.062500,-0.125000,0.500000},
			    {0.062500,-0.250000,0.437500,0.437500,-0.125000,0.500000},
			    {-0.500000,-0.125000,0.437500,0.000000,0.000000,0.500000},
			    {0.000000,-0.125000,0.437500,0.500000,0.000000,0.500000},
			    {-0.500000,0.000000,0.437500,0.500000,3.500000,0.500000},
		    },
	    },
	    selection_box = {
		    type = "fixed",
		    fixed = {
			    {-0.500000,-0.500000,0.437500,0.500000,3.500000,0.500000},
		    },
	    },
	}))
end


-- registering colored tapestries
for _, dye in ipairs(dye.dyes) do
	local desc_prefix = dye[2]
	local tile = "wool_"..dye[1]..".png"
	local material = "wool:"..dye[1]

	local name = "castle:tapestry_"..dye[1]
	tapestry.register(name, desc_prefix, tile)
	minetest.register_craft({
		type = "shapeless",
		output = name,
		recipe = { material, 'group:stick', },
	})

	local name_long = "castle:long_tapestry_"..dye[1]
	tapestry.register_long(name_long, desc_prefix, tile)
	minetest.register_craft({
		type = "shapeless",
		output = name_long,
		recipe = { material, name, },
	})

	local name_very_long = "castle:very_long_tapestry_"..dye[1]
	tapestry.register_very_long(name_very_long, desc_prefix, tile)
	minetest.register_craft({
		type = "shapeless",
		output = name_very_long,
		recipe = { material, name_long, },
	})
end


return tapestry
