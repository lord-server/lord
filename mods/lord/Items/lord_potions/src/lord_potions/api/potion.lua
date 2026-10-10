local S        = core.get_mod_translator()
local colorize = core.colorize
local logger   = core.get_mod_logger()


--- @type string[]
local RANK_BY_POWER = {
	[1] = item_rank.Type.ADVANCED,
	[2] = item_rank.Type.RARE,
	[3] = item_rank.Type.EPIC,
}

--- @param rank_type string?
--- @return string
local function get_rank_color(rank_type)
	local rank = rank_type and item_rank.get(rank_type)

	return rank
		and rank.color
		or  forms.DefaultStyle.get_params_for('listcolors', true)[5]
end

--- @class lord_potions.PotionEffect
--- @field name          string                   one of registered `lord_effects.<CONST>` names.
--- @field is_periodical boolean?                 whether effect has action every second or not (`nil` means `false`).
--- @field power         lord_potions.PotionPower applied power params of Effect. (amount, duration)
--- @field group         string                   name of effect group.

local potions = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	all_items          = {},
	--- @type table<string,table<string,NodeDefinition>>|NodeDefinition[][]
	all_items_grouped  = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	lord_items         = {},
	--- @type table<string,table<string,NodeDefinition>>|NodeDefinition[][]
	lord_items_grouped = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = core.registered_nodes[node_name]
	core.override_item(node_name, {
		groups = table.merge(definition.groups, { potions = 1 }),
	})
	potions.all_items[node_name] = definition
end

--- @param item_name     string
--- @param title         string
--- @param description   string
--- @param color         string
--- @param effect        lord_potions.PotionEffect
--- @param groups        table?
local function register_potion_node(item_name, title, description, color, effect, level, groups)
	local power_abs = math.abs(level)
	local sub_name  = item_name:split(':')[2]
	assert(sub_name, 'item_name must be "<mod>:<name>": ' .. item_name)
	--- @cast sub_name string `assert` above throws on `nil`
	title           = title and title:first_to_upper() or sub_name:first_to_upper()
	level           = level or 0

	local rank_type  = RANK_BY_POWER[power_abs]
	local rank_color = get_rank_color(rank_type)

	local content_opacity_by_level = tonumber(level) >= 0
		and (120 - power_abs * 40)
		or  (150 - power_abs * 50)
	local bottle_contents_img      = '(' ..
		'lord_potions_bottle_content_mask.png' ..
		'^[colorize:' .. color .. ':170' ..
		'^[colorize:#000:' .. content_opacity_by_level ..
	')'
	local texture                  = bottle_contents_img .. '^(lord_potions_bottle.png)'

	core.register_node(item_name, {
		description     = colorize(rank_color, S(
			'Potion "@1"@2',
			colorize('#ee8', title) .. core.get_color_escape_sequence(rank_color),
			level ~= 0 and ' '..S('(Power: @1)', level) or ''
		)),
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
			if not user or not user:is_player() then
				logger.error('potion on_use: expected a player, got %s', tostring(user))
				return itemstack
			end
			--- @cast user Player checked above
			effects.for_player(user):apply(effect.name, effect.power.amount, effect.power.duration, {
				name = effect.group, description = colorize('#ee8', title)
			})

			itemstack:take_item()

			return itemstack
		end,
		_effect         = effect,
		_rank           = rank_type,
		_rank_autocolorize = false,
	})
end

--- @param item_name string
--- @param recipe    {input:string[],time:number|nil}  default time: 120.
local function register_potion_craft(item_name, recipe)
	if not recipe then
		return
	end

	local craft = {
		method = core.CraftMethod.POTION,
		type   = 'cooking',
		input  = { recipe.input },
		output = item_name,
		time   = recipe.time or 120,
	}

	core.register_craft(craft)
end

--- default groups: default: { dig_immediate = 3, attached_node = 1, vessel = 1, potions = 1 }
--- @param name_prefix   string  technical item/node name (`<mod>:<node>`) prefix (will be name_prefix..'_'..power_abs).
--- @param title         string  prefix to description of item or will extracted from `item_name` ("Potion:"..`title`).
--- @param description   string  some words you want to displayed in tooltip before properties of power.
--- @param color         string  color of potion liquid (bottle contents).
--- @param effect        lord_potions.PotionEffect  one of registered `lord_effects.<CONST>` names.
--- @param groups        table?  additional or overwrite groups for item definition groups.
--- @param recipe        {input:string[],time:number|nil}  default time: 120.
local function register_potion(name_prefix, title, description, color, effect, level, groups, recipe)
	local power_abs = math.abs(level)
	local item_name = name_prefix .. '_' .. power_abs

	register_potion_node(item_name, title, description, color, effect, level, groups)

	potions.all_items_grouped [effect.group] = potions.all_items_grouped [effect.group] or {}
	potions.lord_items_grouped[effect.group] = potions.lord_items_grouped[effect.group] or {}

	potions.all_items [item_name]                       = core.registered_nodes[item_name]
	potions.lord_items[item_name]                       = core.registered_nodes[item_name]
	potions.all_items_grouped [effect.group][item_name] = core.registered_nodes[item_name]
	potions.lord_items_grouped[effect.group][item_name] = core.registered_nodes[item_name]

	register_potion_craft(item_name, recipe)
end


--- @param group_item_name string                            items names prefix of group
--- @param level           string                            level of potion power (`"+1"`, `"+2"`,.. `"-1"`, `"-2"`,..)
--- @param crafting        lord_potions.PotionGroup.Crafting crafting ingredients & times of group of potions.
--- @return {input:string[],output:string,time:number|nil}
local function get_recipe_for(group_item_name, level, crafting)
	local power = math.abs(assert(tonumber(level), 'invalid potion level: ' .. tostring(level)))
	crafting.times = crafting.times or { 120, 180, 240 }

	--- @type {input:string[],output:string,time:number|nil}
	local recipe = {
		input  = {
			-- we crafts each next-level potion from prev-level potion, and first one from `base`
			[1] = power == 1 and crafting.ingredients.base or (group_item_name .. '_' .. (power-1)),
			[2] = crafting.ingredients.mixin,
		},
		output = group_item_name .. '_' .. power,
		time   = crafting.times[power] or 120 + (power - 1) * 60,
	}

	return recipe
end

--- @param group lord_potions.PotionGroup
local function register_potion_group(group)
	for level, power in pairs(group.powers) do
		register_potion(
			group.item_name,
			group.title,
			group.description,
			power.color or group.color,
			{
				name          = group.effect,
				is_periodical = group.is_periodical,
				power         = power,
				group         = group.item_name,
			},
			level,
			nil,
			get_recipe_for(group.item_name, level, group.crafting)
		)
	end
end


return {
	add_existing     = add_existing,
	register         = register_potion,
	register_group   = register_potion_group,
	get_all          = function() return potions.all_items end,
	get_all_grouped  = function() return potions.all_items_grouped end,
	--- returns only lord internal registered potions.
	get_lord         = function() return potions.lord_items end,
	get_lord_grouped = function() return potions.lord_items_grouped end,
}
