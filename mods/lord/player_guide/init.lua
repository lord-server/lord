local S = minetest.get_translator("player_guide")
local esc = minetest.formspec_escape

-- Display guide message when violating area protection
local function violation_formspec(player_name)
	formspec = "size[6,5]"
	formspec = formspec.."textarea[0.5,1;5,3;;;"..esc(S("area_violation")).."]"
	formspec = formspec.."button_exit[0.25,3.5;5,1;close_form;"..esc(S("ok")).."]"
	return formspec
end

local function violation_handler(pos, player_name, owners)
	minetest.show_formspec(player_name, "player_guide:area_violation_form", violation_formspec(player_name))
end

areas:registerViolationHandler(violation_handler)

