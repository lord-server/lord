local S        = minetest.get_translator(minetest.get_current_modname())
local colorize = minetest.colorize


--- @class lord_potions.PotionEffect
--- @field name          string                   one of registered `lord_effects.<CONST>` names.
--- @field is_periodical boolean                  whether effect has action every second or not.
--- @field power         lord_potions.PotionPower applied power params of Effect. (amount, duration)

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
--- @param name_prefix   string  technical item/node name (`<mod>:<node>`) prefix (will be name_prefix..'_'..power_abs).
--- @param title         string  prefix to description of item or will extracted from `item_name` (`title`.." Potion").
--- @param description   string  some words you want to displayed in tooltip before properties of power.
--- @param color         string  color of potion liquid (bottle contents).
--- @param effect        string  one of registered `lord_effects.<CONST>` names.
--- @param is_periodical boolean whether effect has action every second or not.
--- @param power         lord_potions.PotionPower applied power params of Effect. (amount, duration)
--- @param groups        table  additional or overwrite groups for item definition groups.
local function register_potion(name_prefix, title, description, color, effect, is_periodical, power, level, groups)
	local power_abs = math.abs(level)
	local item_name = name_prefix .. '_' .. power_abs
	local sub_name  = item_name:split(':')[2]
	title           = title and title:first_to_upper() or sub_name:first_to_upper()
	level           = level or 0

	local content_opacity_by_level = tonumber(level) >= 0
		and (120 - power_abs * 40)
		or  (150 - power_abs * 50)
	local bottle_contents_img      = '(' ..
		'lord_potions_bottle_content_mask.png' ..
		'^[colorize:' .. color .. ':170' ..
		'^[colorize:#000:' .. content_opacity_by_level ..
	')'
	local texture                  = bottle_contents_img .. '^(lord_potions_bottle.png)'

	minetest.register_node(item_name, {
		description     = S('Potion "@1"@2',
			colorize('#ee8', title),
			level ~= 0 and ' '..S('(Power: @1)', level) or ''
		),
		_tt_help        = description and colorize('#aaa',  '\n'..description),
		inventory_image = texture,
		tiles           = { texture },
		selection_box   = { type = 'fixed', fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 } },
		groups          = table.overwrite({ dig_immediate = 3, attached_node = 1, vessel = 1, potions = 1 }, groups or {}),
		sounds          = default.node_sound_glass_defaults(),
		walkable        = false,
		drawtype        = 'plantlike',
		paramtype       = 'light',
		on_use          = function(itemstack, user, pointed_thing)
			effects.for_player(user):apply(effect, power.amount, power.duration)
		end,
		_effect         = { name = effect, is_periodical = is_periodical, power = power, },
	})

	potions.all_items[item_name]  = minetest.registered_nodes[item_name]
	potions.lord_items[item_name] = minetest.registered_nodes[item_name]
end

--- @param group lord_potions.PotionGroup
local function register_potion_group(group)
	for level, power in pairs(group.powers) do
		register_potion(
			group.item_name,
			group.title,
			group.description,
			power.color or group.color,
			group.effect,
			group.is_periodical,
			power,
			level
		)
	end
end


return {
	add_existing          = add_existing,
	register_potion       = register_potion,
	register_potion_group = register_potion_group,
	get_all_items         = function() return potions.all_items end,
	get_lord_items        = function() return potions.lord_items end,
}
