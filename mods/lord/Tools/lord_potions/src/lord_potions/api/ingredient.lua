local S        = minetest.get_mod_translator()
local colorize = minetest.colorize

local ingredients = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	all_items  = {},
}


--- default groups: default: { dig_immediate = 3, attached_node = 1, vessel = 1, ingredients = 1 }
--- @param node_name   string technical item/node name (`<mod>:<node>`).
--- @param title       string prefix to description of item or will extracted from `item_name` (`title`.." ingredient").
--- @param description string some words you want to displayed in tooltip.
--- @param groups      table  additional or overwrite groups for item definition groups.
local function register_ingredient(node_name, title, description, groups)
	local item_name = node_name
	local sub_name  = item_name:split(':')[2]
	local texture   = node_name:replace(':', '_') .. '.png^lord_potions_bottle.png'
	title           = title and title:first_to_upper() or sub_name:first_to_upper()

	minetest.register_node(item_name, {
		description       = S('Ingredient "@1"', colorize('#aa8', title)),
		_tt_help          = description and colorize('#aaa', '\n' .. description),
		inventory_image   = texture,
		wield_image       = texture,
		drawtype          = 'plantlike',
		use_texture_alpha = 'blend',
		tiles             = { texture .. '^[opacity:160' },
		selection_box     = { type = 'fixed', fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 } },
		walkable          = false,
		paramtype         = 'light',
		groups            = table.overwrite(
			{ vessel = 1, dig_immediate = 3, attached_node = 1, ingredients = 1 },
			groups or {}
		),
		sounds            = default.node_sound_glass_defaults(),
	})

	ingredients.all_items[item_name]  = minetest.registered_nodes[item_name]
end


return {
	register = register_ingredient,
	get_all  = function() return ingredients.all_items end,
}
