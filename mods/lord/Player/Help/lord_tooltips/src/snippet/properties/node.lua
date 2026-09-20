local items,                 colorize
    = core.registered_items, core.colorize

local S = core.get_mod_translator()



tt.COLOR_DANGER = '#f64'


--- @param list_items string[]
--- @param definition  ItemDefinition
local function add_luminance(list_items, definition)
	local luminance  = definition._tt_luminance or (
		(definition.light_source and definition.light_source >= 1)
			and definition.light_source
			or  nil
	)
	if luminance then
		list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('luminance')) .. ': ' .. luminance
	end
end

--- Damage (or healing) on contact
--- @param list_items string[]
--- @param definition ItemDefinition
local function add_contact_damage(list_items, definition)
	local amount = definition.damage_per_second
	if not amount then
		return
	end

	if amount > 0 then
		local damage_groups = definition.damage_groups or (
			definition.tool_capabilities
				and (definition.tool_capabilities.damage_groups or {})
				or {}
		)
		local damage_type = damage.Type.get_from_groups(damage_groups)
		damage_type = damage_type and colorize('#bbb', S(damage_type..'_dmg') .. ' ') or ''

		list_items[#list_items + 1] =
			damage_type .. colorize(tt.COLOR_DANGER, S('damage on contact')) .. ': ' .. S('@1/sec', amount)
	elseif amount < 0 then
		list_items[#list_items + 1] =
			colorize(tt.COLOR_GOOD, S('contact healing')) .. ': ' .. S('@1/sec', -amount)
	end
end

--- Health-related node facts
--- @param list_items  string[]
--- @param item_string string
--- @param definition  ItemDefinition
local function add_health_facts(list_items, item_string, definition)
	add_contact_damage(list_items, definition)

	if definition.drowning and definition.drowning ~= 0 then
		list_items[#list_items + 1] = colorize(tt.COLOR_DANGER, S('drowning damage')) .. ': ' ..
			S('@1/sec', definition.drowning)
	end

	local fall_damage = core.get_item_group(item_string, 'fall_damage_add_percent')
	if fall_damage > 0 then
		list_items[#list_items + 1] = colorize(tt.COLOR_DANGER, S('fall damage')) .. ': +' .. fall_damage .. '%'
	elseif fall_damage == -100 then
		list_items[#list_items + 1] = colorize(tt.COLOR_GOOD, S('no fall damage'))
	elseif fall_damage < 0 then
		list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('fall damage')) .. ': ' .. fall_damage .. '%'
	end
end

--- Jumping restrictions of the node
--- @param list_items  string[]
--- @param item_string string
--- @param definition  ItemDefinition
local function add_jump_restrictions(list_items, item_string, definition)
	if core.get_item_group(item_string, 'disable_jump') == 1 and not definition.climbable then
		if definition.liquidtype == 'none' then
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('no jumping'))
		elseif core.get_item_group(item_string, 'fake_liquid') == 0 then
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('no swimming upwards'))
		else
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('no rising'))
		end
	end
	if definition.climbable then
		if core.get_item_group(item_string, 'disable_jump') == 1 then
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('climbable (only downwards)'))
		else
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('climbable'))
		end
	end
end

--- Movement-related node facts
--- @param list_items  string[]
--- @param item_string string
--- @param definition  ItemDefinition
local function add_movement_facts(list_items, item_string, definition)
	add_jump_restrictions(list_items, item_string, definition)

	if core.get_item_group(item_string, 'slippery') >= 1 then
		list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('slippery'))
	end
	local bouncy = core.get_item_group(item_string, 'bouncy')
	if bouncy >= 1 then
		list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('bouncy (@1%)', bouncy))
	end
end


return {
	--- @param item_string string
	--- @return string[]
	get_list_items = function(item_string)
		local definition = items[item_string]

		local list_items = {}

		add_luminance(list_items, definition)
		add_health_facts(list_items, item_string, definition)
		add_movement_facts(list_items, item_string, definition)

		return list_items
	end
}
