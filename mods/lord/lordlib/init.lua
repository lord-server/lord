lord = {}

function lord.require_intllib()
	if minetest.global_exists("intllib") then
		return intllib.make_gettext_pair()
	else
		return function(q) return q end
	end
end

------------------------------------
---Remove after updating to 5.4.1---
------------------------------------
local creative_mode_cache = minetest.settings:get_bool("creative_mode")
function minetest.is_creative_enabled(name)
	return creative_mode_cache
end
