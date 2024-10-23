local S = minetest.get_translator('lord_potion')


local potions = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	all_items  = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	lord_items = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { potions = 1 }),
	})
	potions.all_items[node_name] = definition
end

--- default groups: default: { dig_immediate = 3, attached_node = 1, vessel = 1, potions = 1 }
--- @param item_name_start string technical item/node name (`"<mod>:<node>"`).
--- @param title     string       prefix to description of item or will extracted from `item_name` (`title`.." Potion")
--- @param groups    table        additional or overwrite groups
local function register_potion(item_name_start, title, color, effect, amount, duration, power, groups)
	local power_abs             = math.abs(power)
	local item_name             = item_name_start .. '_' .. power_abs
	local sub_name              = item_name:split(':')[2]
	title                       = title and title:first_to_upper() or sub_name:first_to_upper()

	local power_overlay_opacity = tonumber(power) > 0
		and (120 - power_abs * 40)
		or (150 - power_abs * 50)
	local contents_img          = '(' ..
		'lord_potions_bottle_content_mask.png' ..
		'^[colorize:' .. color .. ':170' ..
		'^[colorize:#000:' .. power_overlay_opacity ..
	')'
	local texture               = contents_img .. '^(lord_potions_bottle.png)'

	minetest.register_node(item_name, {
		description     = S('Potion of @1 (Power: @2)', title, power),
		inventory_image = texture,
		tiles           = { texture },
		selection_box   = { type = 'fixed', fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 } },
		groups          = table.overwrite({ dig_immediate = 3, attached_node = 1, vessel = 1, potions = 1 }, groups or {}),
		sounds          = default.node_sound_glass_defaults(),
		walkable        = false,
		drawtype        = 'plantlike',
		paramtype       = 'light',
		on_use          = function(itemstack, user, pointed_thing)
			effects.for_player(user):apply(effect, amount, duration)
		end
	})

	potions.all_items[item_name]  = minetest.registered_nodes[item_name]
	potions.lord_items[item_name] = minetest.registered_nodes[item_name]
end

--- @param group lord_potions.PotionGroup
local function register_potion_group(group)
	for power_name, power in pairs(group.powers) do
		register_potion(
			group.item_name,
			group.title,
			power.color or group.color,
			group.effect,
			power.amount,
			power.duration,
			power_name
		)
	end
end


return {
	add_existing          = add_existing,
	register_potion       = register_potion,
	register_potion_group = register_potion_group,
	--- @return NodeDefinition[]
	get_all_items         = function() return potions.all_items end,
	get_lord_items        = function() return potions.lord_items end,
}
