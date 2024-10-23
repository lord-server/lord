local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_translator(minetest.get_current_modname())



tt.COLOR_DANGER = '#f64'


return {
	--- @param item_string string
	--- @return string|nil
	get_list_items = function(item_string)
		local definition = items[item_string]

		local list_items = {}

		local luminance  = definition._tt_luminance or (
			(definition.light_source and definition.light_source >= 1)
				and definition.light_source
				or  nil
		)
		if luminance then
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('luminance')) .. ': ' .. luminance
		end

		-- Health-related node facts
		if definition.damage_per_second then
			local amount = definition.damage_per_second
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
		if definition.drowning and definition.drowning ~= 0 then
			list_items[#list_items + 1] = colorize(tt.COLOR_DANGER, S('drowning damage')) .. ': ' ..
				S('@1/sec', definition.drowning)
		end
		local tmp = minetest.get_item_group(item_string, 'fall_damage_add_percent')
		if tmp > 0 then
			list_items[#list_items + 1] = colorize(tt.COLOR_DANGER, S('fall damage')) .. ': +' .. tmp .. '%'
		elseif tmp == -100 then
			list_items[#list_items + 1] = colorize(tt.COLOR_GOOD, S('no fall damage'))
		elseif tmp < 0 then
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('fall damage')) .. ': ' .. tmp .. '%'
		end

		-- Movement-related node facts
		if minetest.get_item_group(item_string, 'disable_jump') == 1 and not definition.climbable then
			if definition.liquidtype == 'none' then
				list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('no jumping'))
			elseif minetest.get_item_group(item_string, 'fake_liquid') == 0 then
				list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('no swimming upwards'))
			else
				list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('no rising'))
			end
		end
		if definition.climbable then
			if minetest.get_item_group(item_string, 'disable_jump') == 1 then
				list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('climbable (only downwards)'))
			else
				list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('climbable'))
			end
		end
		if minetest.get_item_group(item_string, 'slippery') >= 1 then
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('slippery'))
		end
		tmp = minetest.get_item_group(item_string, 'bouncy')
		if tmp >= 1 then
			list_items[#list_items + 1] = colorize(tt.COLOR_DEFAULT, S('bouncy (@1%)', tmp))
		end

		return list_items
	end
}
