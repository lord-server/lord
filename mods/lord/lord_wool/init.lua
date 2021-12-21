-- lord_wool/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("lord_wool")

for _, row in ipairs(dye.dyes) do
	local name = row[1]
	local desc = row[2]

	stairs.register_stair_and_slab(
		"wool"..name,
		"wool:"..name,
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"wool_"..name..".png"},
		S(desc.." Wool Stair"), --desc_stair
		S(desc.." Wool Slab"), --desc_slab
		default.node_sound_wood_defaults(),
		false, --worldaligntex
		S("Inner "..desc.." Wool Stair"), --desc_stair_inner
		S("Outer "..desc.." Wool Stair") --desc_stair_outer
  )
end

--[[ для справки, взято из minetest_game/stairs/init.lua
-- Stair/slab registration function.
-- Nodes will be called stairs:{stair,slab}_<subname>

function stairs.register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, worldaligntex,
		desc_stair_inner, desc_stair_outer)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair,
		sounds, worldaligntex)
	stairs.register_stair_inner(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_inner)
	stairs.register_stair_outer(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_outer)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab,
		sounds, worldaligntex)
end
--]]
