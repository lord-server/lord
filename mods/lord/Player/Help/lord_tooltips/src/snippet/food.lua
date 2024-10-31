local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_mod_translator()


--- @param value number
--- @return string
local function sign(value)
	return value > 0 and '+' or (value < 0 and '-' or '')
end


--- @param item_string string
--- @return string|nil
return function(item_string)
	local _tt_food_hp = items[item_string]._tt_food_hp
	if not _tt_food_hp then return nil end

	return '\n' ..
		colorize('#ee8', S('Food')) .. ':\n' ..
		'  ' .. S('@1@2 to satiety', sign(_tt_food_hp), _tt_food_hp)
end
