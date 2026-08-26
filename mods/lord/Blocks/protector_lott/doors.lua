local S = core.get_mod_translator()

-- Register Protected Doors

local function reg_prot_door(desc, name, door, mat, texture_i, texture_uv)
	local gd
	if mat == "wood" then
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1, wooden = 1}
	elseif mat == "steel" then
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1, steel_item = 1}
	else
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1}
	end
	doors.register(name, {
		tiles = {{ name = texture_uv.."^protector_logo_door_uv.png", backface_culling = true }},
		description = S(desc),
		inventory_image = texture_i.."^protector_logo_i.png",
		groups = gd,
		sunlight = true,
		recipe = {
			{door, "protector_lott:protect2"}
		},
		on_rightclick = function(pos, node, clicker)
			if not core.is_protected(pos, clicker:get_player_name()) then
				doors.door_toggle(pos, node, clicker)
			end
		end,
	})
end


-- from doors mod

reg_prot_door(
	"Protected Wooden Door", "protector_lott:door_wood", "doors:door_wood", "wood",
	"doors_item_wood.png",
	"doors_door_wood.png"
)

reg_prot_door(
	"Protected Steel Door", "protector_lott:door_steel", "doors:door_steel", "steel",
	"doors_item_steel.png", "doors_door_steel.png"
)

reg_prot_door(
	"Protected Glass Door", "protector_lott:door_glass", "doors:door_glass", "glass",
	"doors_item_glass.png",
	"doors_door_glass.png"
)

reg_prot_door(
	"Protected Obsidian Glass Door", "protector_lott:door_obsidian_glass", "doors:door_obsidian_glass", "glass",
	"doors_item_obsidian_glass.png",
	"doors_door_obsidian_glass.png"
)

-- from lord_wooden_stuff mod

reg_prot_door(
	"Protected Junglewood Door", "protector_lott:door_junglewood", "lord_wooden_stuff:door_junglewood", "wood",
	"lord_wooden_stuff_door_junglewood.png",
	"lord_wooden_stuff_door_junglewood_uv.png"
)

reg_prot_door(
	"Protected Alder Door", "protector_lott:door_alder", "lord_wooden_stuff:door_alder", "wood",
	"lord_wooden_stuff_door_alder.png",
	"lord_wooden_stuff_door_alder_uv.png"
)

reg_prot_door(
	"Protected Birch Door", "protector_lott:door_birch", "lord_wooden_stuff:door_birch", "wood",
	"lord_wooden_stuff_door_birch.png",
	"lord_wooden_stuff_door_birch_uv.png"
)

reg_prot_door(
	"Protected Pine Door", "protector_lott:door_pine", "lord_wooden_stuff:door_pine", "wood",
	"lord_wooden_stuff_door_pine.png", "lord_wooden_stuff_door_pine_uv.png"
)

reg_prot_door(
	"Protected Lebethron Door", "protector_lott:door_lebethron", "lord_wooden_stuff:door_lebethron", "wood",
	"lord_wooden_stuff_door_lebethron.png",
	"lord_wooden_stuff_door_lebethron_uv.png"
)

reg_prot_door(
	"Protected Mallorn Door", "protector_lott:door_mallorn", "lord_wooden_stuff:door_mallorn", "wood",
	"lord_wooden_stuff_door_mallorn.png",
	"lord_wooden_stuff_door_mallorn_uv.png"
)

reg_prot_door(
	"Protected Cherry Door", "protector_lott:door_cherry", "lord_wooden_stuff:door_cherry", "wood",
	"lord_wooden_stuff_door_cherry.png",
	"lord_wooden_stuff_door_cherry_uv.png"
)

reg_prot_door(
	"Protected Culumalda Door", "protector_lott:door_culumalda", "lord_wooden_stuff:door_culumalda", "wood",
	"lord_wooden_stuff_door_culumalda.png",
	"lord_wooden_stuff_door_culumalda_uv.png"
)

reg_prot_door(
	"Protected Elm Door", "protector_lott:door_elm", "lord_wooden_stuff:door_elm", "wood",
	"lord_wooden_stuff_door_elm.png",
	"lord_wooden_stuff_door_elm_uv.png"
)

reg_prot_door(
	"Protected Fir Door", "protector_lott:door_fir", "lord_wooden_stuff:door_fir", "wood",
	"lord_wooden_stuff_door_fir.png",
	"lord_wooden_stuff_door_fir_uv.png"
)

reg_prot_door(
	"Protected Hardwood Door", "protector_lott:door_hardwood", "lord_wooden_stuff:door_hardwood", "wood",
	"lord_wooden_stuff_door_hardwood.png",
	"lord_wooden_stuff_door_hardwood_uv.png"
)

reg_prot_door(
	"Protected Infected Door", "protector_lott:door_infected", "lord_wooden_stuff:door_infected", "wood",
	"lord_wooden_stuff_door_infected.png",
	"lord_wooden_stuff_door_infected_uv.png"
)

reg_prot_door(
	"Protected Plum Door", "protector_lott:door_plum", "lord_wooden_stuff:door_plum", "wood",
	"lord_wooden_stuff_door_plum.png",
	"lord_wooden_stuff_door_plum_uv.png"
)

reg_prot_door(
	"Protected White Door", "protector_lott:door_white", "lord_wooden_stuff:door_white", "wood",
	"lord_wooden_stuff_door_white.png",
	"lord_wooden_stuff_door_white_uv.png"
)

reg_prot_door(
	"Protected Yavannamire Door", "protector_lott:door_yavannamire", "lord_wooden_stuff:door_yavannamire", "wood",
	"lord_wooden_stuff_door_yavannamire.png",
	"lord_wooden_stuff_door_yavannamire_uv.png"
)

-- from castle mod
reg_prot_door(
	"Protected Oak Door", "protector_lott:oak_door", "castle:oak_door", "wood",
	"castle_oak_door.png",
	"castle_oak_door_uv.png"
)

-- from castle mod
reg_prot_door(
	"Protected Oak Door", "protector_lott:oak_door", "castle:oak_door", "wood",
	"castle_oak_door.png",
	"castle_oak_door_uv.png"
)

reg_prot_door(
	"Protected Jail Door", "protector_lott:jail_door", "castle:jail_door", "steel",
	"castle_jail_door.png",
	"castle_jail_door_uv.png"
)

-- from _minetest_game/xpanes mod
reg_prot_door(
	"Protected Steel Bar Door", "protector_lott:door_steel_bar", "xpanes:door_steel_bar", "steel",
	"xpanes_item_steel_bar.png",
	"xpanes_door_steel_bar.png"
)