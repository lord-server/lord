local S        = minetest.get_mod_translator()
local colorize = minetest.colorize


--- @class lord_potions.PotionEffect
--- @field name          string                   one of registered `lord_effects.<CONST>` names.
--- @field is_periodical boolean                  whether effect has action every second or not.
--- @field power         lord_potions.PotionPower applied power params of Effect. (amount, duration)
--- @field group         string                   name of effect group.

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

--- @param item_name     string
--- @param title         string
--- @param description   string
--- @param color         string
--- @param effect        lord_potions.PotionEffect
--- @param groups        table
local function register_potion_node(item_name, title, description, color, effect, level, groups)
	local power_abs = math.abs(level)
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
			effects.for_player(user):apply(effect.name, effect.power.amount, effect.power.duration, {
				name = effect.group, description = colorize('#ee8', title)
			})

			itemstack:take_item()

			return itemstack
		end,
		_effect         = effect,
	})
end

--- @param item_name string
--- @param recipe    {input:string[],time:number|nil}  default time: 120.
local function register_potion_craft(item_name, recipe)
	if not recipe then
		return
	end

	local craft = {
		method = minetest.CraftMethod.POTION,
		type   = 'cooking',
		input  = { recipe.input },
		output = item_name,
		time   = recipe.time or 120,
	}

	minetest.register_craft(craft)
end

--- default groups: default: { dig_immediate = 3, attached_node = 1, vessel = 1, potions = 1 }
--- @param name_prefix   string  technical item/node name (`<mod>:<node>`) prefix (will be name_prefix..'_'..power_abs).
--- @param title         string  prefix to description of item or will extracted from `item_name` ("Potion:"..`title`).
--- @param description   string  some words you want to displayed in tooltip before properties of power.
--- @param color         string  color of potion liquid (bottle contents).
--- @param effect        lord_potions.PotionEffect  one of registered `lord_effects.<CONST>` names.
--- @param groups        table  additional or overwrite groups for item definition groups.
--- @param recipe        {input:string[],time:number|nil}  default time: 120.
local function register_potion(name_prefix, title, description, color, effect, level, groups, recipe)
	local power_abs = math.abs(level)
	local item_name = name_prefix .. '_' .. power_abs

	register_potion_node(item_name, title, description, color, effect, level, groups)

	potions.all_items[item_name]  = minetest.registered_nodes[item_name]
	potions.lord_items[item_name] = minetest.registered_nodes[item_name]

	register_potion_craft(item_name, recipe)
end


--- @param group_item_name string                            items names prefix of group
--- @param level           string                            level of potion power (`"+1"`, `"+2"`,.. `"-1"`, `"-2"`,..)
--- @param crafting        lord_potions.PotionGroup.Crafting crafting ingredients & times of group of potions.
--- @return {input:string[],output:string,time:number|nil}
local function get_recipe_for(group_item_name, level, crafting)
	level = math.abs(tonumber(level))
	crafting.times = crafting.times or { 120, 180, 240 }

	--- @type {input:string[],output:string,time:number|nil}
	local recipe = {
		input  = {
			-- we crafts each next-level potion from prev-level potion, and first one from `base`
			[1] = level == 1 and crafting.ingredients.base or (group_item_name .. '_' .. (level-1)),
			[2] = crafting.ingredients.mixin,
		},
		output = group_item_name .. '_' .. level,
		time   = crafting.times[level] or 120 + (level - 1) * 60,
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
	add_existing   = add_existing,
	register       = register_potion,
	register_group = register_potion_group,
	get_all        = function() return potions.all_items end,
	--- returns only lord internal registered potions.
	get_lord       = function() return potions.lord_items end,
}
