lord = {}

function lord.require_intllib()
	if minetest.global_exists("intllib") then
		return intllib.make_gettext_pair()
	else
		return function(q) return q end
	end
end

-- Вспомогательная функция give_or_drop
-- Даёт предмет данному игроку или кидает на землю рядом при недостатке места в инвентаре.
-- Принимает:
-- - player - объект игрока;
-- - stack - объект ItemStack (не itemstring!).
-- Возвращает
-- true, если предмет положен в инвентарь, и
-- false, если предмет выброшен.
function lord.give_or_drop(player, stack)
	local inv = player:get_inventory()
	if inv:room_for_item("main", stack) then
		inv:add_item("main", stack)
		return true
	else
		minetest.item_drop(stack, player, player:get_pos())
		return false
	end
end

------------------------------------
---Remove after updating to 5.4.1---
------------------------------------
local creative_mode_cache = minetest.settings:get_bool("creative_mode")
function minetest.is_creative_enabled(name)
	return creative_mode_cache
end
