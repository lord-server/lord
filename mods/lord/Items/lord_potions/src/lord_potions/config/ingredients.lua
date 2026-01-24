local S = minetest.get_mod_translator()

--- @class lord_potions.Ingredient
--- @field node_name   string technical item/node name (`<mod>:<node>`).
--- @field title       string prefix to description of item or will extracted from `item_name` (`title`.." ingredient").
--- @field description string some words you want to displayed in tooltip.
--- @field groups      table  additional or overwrite groups for item definition groups.
--- @field recipe      {input:string[],time:number|nil}  default time: 60.


--- @type lord_potions.Ingredient[]
local config = {
	-- Base Ingredients
	{
		node_name = "lord_potions:ingredient_mese",
		title     = S("Extract of Mese"),
		recipe    = {
			input = { "default:mese_crystal_fragment 1", "lord_vessels:glass_bottle_water" },
		},
	},
	{
		node_name = "lord_potions:ingredient_geodes",
		title     = S("Extract of Geodes Crystal"),
		recipe    = {
			input = { "lottores:geodes_crystal_1", "lord_vessels:glass_bottle_water" },
		},
	},
	{
		node_name = "lord_potions:ingredient_seregon",
		title     = S("Extract of Seregon"),
		recipe    = {
			input = { "lottplants:seregon", "lord_vessels:glass_bottle_water" },
		}
	},
	-- Negative Base Ingredients
	{
		node_name = "lord_potions:ingredient_obsidian",
		title     = S("Extract of Obsidian"),
		recipe    = {
			input = { "default:obsidian_shard 1", "lord_vessels:glass_bottle_water" },
		},
	},
	{
		node_name = "lord_potions:ingredient_bonedust",
		title     = S("Extract of Bonedust"),
		recipe    = {
			input = { "bones:bonedust 1", "lord_vessels:glass_bottle_water" },
		},
	},
	{
		node_name = "lord_potions:ingredient_mordor",
		title     = S("Extract of Mordor Thorn"),
		recipe    = {
			input = { "lottplants:brambles_of_mordor", "lord_vessels:glass_bottle_water" },
		},
	},
}


return config
