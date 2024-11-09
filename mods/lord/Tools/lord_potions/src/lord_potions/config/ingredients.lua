local S = minetest.get_mod_translator()

--- @class lord_potions.Ingredient
--- @field node_name   string technical item/node name (`<mod>:<node>`).
--- @field title       string prefix to description of item or will extracted from `item_name` (`title`.." ingredient").
--- @field description string some words you want to displayed in tooltip.
--- @field groups      table  additional or overwrite groups for item definition groups.


--- @type lord_potions.Ingredient[]
local config = {
	-- Base Ingredients
	{
		node_name   = "lord_potions:ingredient_mese",
		description = S("Glass Bottle (Mese Water)"),
	},
	{
		node_name   = "lord_potions:ingredient_geodes",
		description = S("Glass Bottle (Geodes Crystal Water)"),
	},
	{
		node_name   = "lord_potions:ingredient_seregon",
		description = S("Glass Bottle (Seregon Water)"),
	},
	-- Negative Base Ingredients
	{
		node_name   = "lord_potions:ingredient_obsidian",
		description = S("Glass Bottle (Obsidian Water)"),
	},
	{
		node_name   = "lord_potions:ingredient_bonedust",
		description = S("Glass Bottle (Bonedust Water)"),
	},
	{
		node_name   = "lord_potions:ingredient_mordor",
		description = S("Glass Bottle (Mordor Water)"),
	},
}

return config
