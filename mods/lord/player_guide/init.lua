local S = minetest.get_translator("player_guide")
local esc = minetest.formspec_escape

-- Display guide message when violating area protection
local violation_message = "Hello! Unfortunately, the area, where you are trying to dig or build, is used by other players. So, building/digging resources here is not allowed. But you can search other place, which is not used and build or dig resources there. Best regards, L.O.R.D. server!"
local function violation_formspec(player_name)
	formspec = "size[6,5]"
	formspec = formspec.."textarea[0.5,1;5,3;;;"..esc(S(violation_message)).."]"
	formspec = formspec.."button_exit[0.25,3.5;5,1;close_form;"..esc(S("ok")).."]"
	return formspec
end

local function violation_handler(pos, player_name, owners)
	minetest.show_formspec(player_name, "player_guide:area_violation_form", violation_formspec(player_name))
end

areas:registerViolationHandler(violation_handler)

