lord = {}

function lord.require_intllib()
	if minetest.global_exists("intllib") then
		return intllib.make_gettext_pair()
	else
		return function(q) return q end
	end
end
