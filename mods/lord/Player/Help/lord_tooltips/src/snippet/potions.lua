local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_mod_translator()


local template = {
	general    = '@1: @2 during @3 seconds',
	periodical = '@1: @2 every second during @3 seconds'
}

--- @param value number
--- @return string
local function sign(value)
	return tonumber(value) > 0 and '+' or ''
end
--- @param value number
--- @return string
local function value_color(value)
	return tonumber(value) > 0 and '#aea' or '#f66'
end


--- @param item_string string
--- @return string|nil
return function (item_string)
	local item = items[item_string]

	--- @type lord_potions.PotionEffect
	local effect = item._effect
	local groups = item.groups

	if not groups.potions or not effect then
		return
	end

	local effects_strings = {}

	local tpl = effect.is_periodical and template.periodical or template.general
	local effect_name  = effect.name:first_to_upper()
	local amount       = sign(effect.power.amount) .. effect.power.amount
	local amount_color = value_color(effect.power.amount)
	effects_strings[#effects_strings +1] =
		'  • ' .. S(tpl, S(effect_name), colorize(amount_color, amount), effect.power.duration)

	return #effects_strings ~= 0
		and ('\n' ..
			colorize('#ee8', S('Effects')) .. ':\n' ..
				table.concat(effects_strings, '\n')
		)
		or nil
end
