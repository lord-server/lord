local S = minetest.get_translator("lord_beds")
local esc = minetest.formspec_escape

beds = {}
beds.player = {}
beds.bed_position = {}
beds.pos = {}
beds.spawn = {}
beds.get_translator = S

beds.formspec = "size[8,11;true]" ..
	"no_prepend[]" ..
	"bgcolor[#080808BB;true]" ..
	"button_exit[2,10;4,0.75;leave;" .. esc(S("Leave Bed")) .. "]"

beds.day_interval = {
	start = 0.2,
	finish = 0.790,
}

minetest.mod(function(mod)
	require('functions')
	require('api')
	require('beds')
	require('straw_bed')
	require('spawns')
end)
