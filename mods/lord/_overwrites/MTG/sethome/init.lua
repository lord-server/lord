
local S = minetest.get_translator("sethome")

local original_sethome_set = sethome.set

sethome.set = function(name, pos)
	if minetest.get_modpath("protector_lott") ~= nil then
		if minetest.is_protected(pos, name) then
			minetest.chat_send_player(name, S("Home not set!"))
			return false
		end
	end

	return original_sethome_set(name, pos)
end
