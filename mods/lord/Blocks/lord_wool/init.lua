-- lord_wool/init.lua

-- Load support for MT game translation.
local S = minetest.get_mod_translator()

for _, row in ipairs(dye.dyes) do
	local name = row[1]
	local desc = row[2]

	stairs.register_stair_and_slab(
		"wool"..name,
		"wool:"..name,
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3,wool=1},
		{"wool_"..name..".png"},
		S(desc.." Wool Stair"), --desc_stair
		S(desc.." Wool Slab"), --desc_slab
		default.node_sound_wood_defaults(),
		false, --worldaligntex
		S("Inner "..desc.." Wool Stair"), --desc_stair_inner
		S("Outer "..desc.." Wool Stair") --desc_stair_outer
	)
end
