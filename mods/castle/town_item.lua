local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_alias("darkage:box",         "castle:crate")
minetest.register_alias("cottages:straw",      "farming:straw")
minetest.register_alias("castle:straw",        "farming:straw")
minetest.register_alias("darkage:straw",       "farming:straw")
minetest.register_alias("cottages:straw_bale", "castle:bound_straw")
minetest.register_alias("darkage:straw_bale",  "castle:bound_straw")
minetest.register_alias("darkage:lamp",        "castle:street_light")

minetest.register_node("castle:anvil",{
	drawtype = "nodebox",
	description = SL("Anvil"),
	tiles = {"castle_steel.png"},
	groups = {cracky=2,falling_node=1},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.3, 0.5, -0.3, 0.3},
			{-0.4, -0.5, -0.4, 0.4, -0.3, 0.4},
			{-0.3, -0.5, -0.5, 0.3, -0.3, 0.5},
			{-0.4, -0.3, -0.4, -0.1, -0.2, -0.1},
			{-0.4, -0.3, 0.4, -0.1, -0.2, 0.1},
			{0.4, -0.3, 0.4, 0.1, -0.2, 0.1},
			{0.4, -0.3, -0.4, 0.1, -0.2, -0.1},
			{-0.3, -0.2, -0.3, 0.3, -0.1, 0.3},
			{-0.2, -0.1, -0.2, 0.2, 0.1, 0.2},
			{-0.3, 0.1, -0.25, 0.3, 0.5, 0.25},
			{-0.4, 0.1, -0.15, -0.3, 0.5, 0.15},
			{-0.4, 0.15, -0.2, -0.3, 0.45, 0.2},
			{-0.5, 0.15, -0.1, -0.4, 0.45, 0.1},
			{-0.5, 0.2, -0.15, -0.4, 0.4, 0.15},
			{-0.6, 0.25, -0.05, -0.5, 0.45, 0.05},
			{-0.6, 0.3, -0.1, -0.5, 0.4, 0.1},
			{-0.7, 0.35, -0.05, -0.6, 0.45, 0.05},
			{0.3, 0.1, -0.2, 0.4, 0.5, 0.2},
			{0.4, 0.2, -0.15, 0.5, 0.5, 0.15},
			{0.5, 0.3, -0.1, 0.6, 0.5, 0.1},
			{0.6, 0.4, -0.05, 0.7, 0.5, 0.05},
			--{-0.500000,-0.500000,-0.500000,0.500000,-0.250000,0.500000},
			--{-0.187500,-0.500000,-0.375000,0.187500,0.312500,0.375000}, 
			--{-0.375000,-0.500000,-0.437500,0.375000,-0.125000,0.437500}, 
			--{-0.500000,0.312500,-0.500000,0.500000,0.500000,0.500000}, 
			--{-0.375000,0.187500,-0.437500,0.375000,0.425000,0.437500}, 
		},
	},
})

minetest.register_craft({
	output = "castle:anvil",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"","default:steel_ingot", ""},
		{"default:steel_ingot", "default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_node("castle:workbench",{
	description = SL("Workbench"),
	tiles = {"castle_workbench_top.png", "default_wood.png", "castle_workbench_1.png", "castle_workbench_1.png", "castle_workbench_2.png", "castle_workbench_2.png"},
	paramtype2 = "facedir",
	paramtype = "light",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2, wooden = 1},
	drawtype = "normal",
    on_construct = function ( pos )
        local meta = minetest.get_meta( pos )
		meta:set_string( 'formspec', 'size[8,9;]' ..
			"background[-0.5,-0.65;9,10.35;gui_chestbg.png]"..
			"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"..
			'label[0,0;'..SL('Source Material')..']' ..
			'list[context;src;0,0.5;2,4;]' ..
			'label[3.5,0.5;'..SL('Recipe to Use')..']' ..
			'list[context;rec;2.5,1;3,3;]' ..
			'label[6,0;'..SL('Craft Output')..']' ..
			'list[context;dst;6,0.5;2,4;]' ..
			'list[current_player;main;0,5;8,4;]' )
        meta:set_string( 'infotext', SL('Workbench'))
        local inv = meta:get_inventory()
        inv:set_size( 'src', 2 * 4 )
		inv:set_size( 'rec', 3 * 3 )
		inv:set_size( 'dst', 2 * 4 )
    end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in workbench at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to workbench at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from workbench at "..minetest.pos_to_string(pos))
	end,
})
local get_recipe = function ( inv )
	local result, needed, input
	needed = inv:get_list( 'rec' )

	result, input = minetest.get_craft_result( {
		method = 'normal',
		width = 3,
		items = needed
	} )

	local totalneed = {}

	if result.item:is_empty() then
		result = nil
	else
		result = result.item
		for _, item in ipairs( needed ) do
			if item ~= nil and not item:is_empty() and not inv:contains_item( 'src', item ) then
				result = nil
				break
			end
			if item ~= nil and not item:is_empty() then
				if totalneed[item:get_name()] == nil then
					totalneed[item:get_name()] = 1
				else
					totalneed[item:get_name()] = totalneed[item:get_name()] + 1
				end
			end
		end
		for name, number in pairs( totalneed ) do
			local totallist = inv:get_list( 'src' )
			for i, srcitem in pairs( totallist ) do
				if srcitem:get_name() == name then
					local taken = srcitem:take_item( number )
					number = number - taken:get_count()
					totallist[i] = srcitem
				end
				if number <= 0 then
					break
				end
			end
			if number > 0 then
				result = nil
				break
			end
		end
	end

	return needed, input, result
end

minetest.register_abm( {
	nodenames = { 'castle:workbench' },
	interval = 5,
	chance = 1,
	action = function ( pos, node )
		local meta = minetest.get_meta( pos )
		local inv = meta:get_inventory()
		local cresult, newinput, needed
		if not inv:is_empty( 'src' ) then
			-- Check for a valid recipe and sufficient resources to craft it
			needed, newinput, result = get_recipe( inv )
			if result ~= nil and inv:room_for_item( 'dst', result ) then
				inv:add_item( 'dst', result )
				for i, item in pairs( needed ) do
					if item ~= nil and item ~= '' then
						inv:remove_item( 'src', ItemStack( item ) )
					end
					if newinput[i] ~= nil and not newinput[i]:is_empty() then
						inv:add_item( 'src', newinput[i] )
					end
				end
			end
		end
	end
} )

minetest.register_craft({
	output = "castle:workbench",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:wood", "default:wood","default:steel_ingot"},
		{"default:tree", "default:tree","default:steel_ingot"},
	}
})

minetest.register_node("castle:dungeon_stone", {
	description = SL("Dungeon Stone"),
	drawtype = "normal",
	tiles = {"castle_dungeon_stone.png"},
	groups = {cracky=2},
	paramtype = "light",
})

minetest.register_craft({
	output = "castle:dungeon_stone",
	recipe = {
		{"default:stonebrick", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "castle:dungeon_stone",
	recipe = {
		{"default:stonebrick"},
		{"default:obsidian"},

	}
})

minetest.register_node("castle:straw", {
	description = SL("Straw"),
	tiles = {"castle_straw.png"},
	is_ground_content = false,
	groups = {snappy=3, flammable=4, grass = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	output = "castle:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {
		{"castle:straw"},
	}
})

minetest.register_node("castle:bound_straw", {
	description = SL("Bound Straw"),
	drawtype = "normal",
	tiles = {"castle_straw_bale.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3, grass=1},
	paramtype = "light",
})

minetest.register_craft({
	output = "castle:bound_straw",
	recipe = {
		{"castle:straw", "castle:ropes"},
	}
})

stairs.register_stair_and_slab("straw", "castle:straw",
	{choppy=3, flammable=1, oddly_breakable_by_hand=3, grass=1},
	{"castle_straw.png"},
	SL("Castle Straw Stair"),
	SL("Castle Straw Slab"),
	default.node_sound_leaves_defaults()
)

minetest.register_node("castle:pavement", {
	description = SL("Paving Stone"),
	drawtype = "normal",
	tiles = {"castle_pavement_brick.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "castle:pavement 4",
	recipe = {
		{"default:stone", "default:cobble"},
		{"default:cobble", "default:stone"},
	}
})

minetest.register_node("castle:light",{
	drawtype = "glasslike",
	description = SL("Light Block"),
	sunlight_propagates = true,
	light_source = 14,
	tiles = {"castle_street_light.png"},
	groups = {cracky=2},
	paramtype = "light",
})

minetest.register_craft({
	output = "castle:light",
	recipe = {
		{"default:stick", "default:glass", "default:stick"},
		{"default:glass", "default:torch", "default:glass"},
		{"default:stick", "default:glass", "default:stick"},
	}
})
