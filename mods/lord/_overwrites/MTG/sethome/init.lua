
local S = core.get_mod_translator("sethome")

local original_sethome_set = sethome.set

sethome.set = function(name, pos)
	if core.get_modpath("protector_lott") ~= nil then
		if core.is_protected(pos, name) then
			core.chat_send_player(name, S("Home not set!"))
			return false
		end
	end

	return original_sethome_set(name, pos)
end
