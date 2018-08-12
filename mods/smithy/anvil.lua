local SL = lord.require_intllib()

minetest.register_tool("smithy:hammer", {
	description = SL("Repairing Hammer"),
	inventory_image = "smithy_hammer.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			-- about equal to a stone pick (it's not intended as a tool)
			cracky={times={[2]=2.00, [3]=1.20}, uses=30, maxlevel=1},
		},
		damage_groups = {fleshy=6},
	}
})

local smithy_anvil_formspec =
	"size[8,7]"..
	"list[current_name;input;2,1;1,1;]"..
	"list[current_name;hammer;5,1;1,1;]"..
	"label[0.5,1.25;"..SL("Workspace:").."]"..
	"label[6.25,1;"..SL("Optional").."]"..
	"label[6.25,1.3;"..SL("storage for").."]"..
	"label[6.25,1.6;"..SL("your hammer").."]"..
	"list[current_player;main;0,3;8,4;]";

local nodebox = 
{
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
	},
}

minetest.register_node(":castle:anvil", {
	drawtype = "nodebox",
	description = SL("Anvil"),
	tiles = {"lottores_galvorn_block.png"},
	groups = {cracky=2,falling_node=1},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = nodebox,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos);
		meta:set_string("infotext", SL("Anvil"));
		local inv = meta:get_inventory();
		inv:set_size("input", 9);
		inv:set_size("hammer", 1);
		meta:set_string("formspec", smithy_anvil_formspec );
	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos);
		meta:set_string("owner", placer:get_player_name() or "");
		meta:set_string("infotext", SL("Anvil (owned by %s)"):format((meta:get_string("owner") or "")));
		meta:set_string("formspec",
		smithy_anvil_formspec,
		"label[2.5,-0.5;"..SL("Owner: %s"):format(meta:get_string('owner') or "").."]");
	end,

	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory();
		local owner = meta:get_string('owner');
		if( not( inv:is_empty("input"))
			or not( inv:is_empty("hammer"))
			or not( player )
			or ( owner and owner ~= '' and player:get_player_name() ~= owner )) then
			minetest.chat_send_player( player:get_player_name(), SL('Can not break. Something is inside.'));
			return false;
		end
		return true;
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if( player and player:get_player_name() ~= meta:get_string('owner' ) and from_list~="input") then
			return 0
		end
		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if( player and player:get_player_name() ~= meta:get_string('owner' ) and listname~="input") then
			return 0;
		end
		if listname=='hammer' and stack and stack:get_name() ~= 'smithy:hammer' then
			return 0;
		end
		if listname=='input' and stack:get_wear() == 0 then
			minetest.chat_send_player( player:get_player_name(), SL('The workpiece slot is for damaged tools only.'));
			return 0;
		end
		if listname=='input' and stack:get_name() == "lottother:dwarf_ring" then
			minetest.chat_send_player(player:get_player_name(), SL('You can not repair rings!'));
			return 0;
		end

		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if( player and player:get_player_name() ~= meta:get_string('owner' ) and listname~="input") then
			return 0
		end
		return stack:get_count()
	end,

	on_punch = function(pos, node, puncher)
		if not (pos or node or puncher) then
			return;
		end
		-- only punching with the hammer is supposed to work
		local wielded = puncher:get_wielded_item();
		if not (wielded or wielded:get_name()) or wielded:get_name() ~= 'smithy:hammer' then
			return;
		end

		local name = puncher:get_player_name();
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory();
		local input = inv:get_stack('input',1);

		-- only tools can be repaired
		if not input 
			or input:is_empty() then
			meta:set_string("formspec",
			smithy_anvil_formspec,
			"label[2.5,-0.5;"..SL("Owner: %s"):format(meta:get_string('owner') or "").."]");
			return;
		end

		-- 65535 is max damage
		local damage_state = 40-math.floor(input:get_wear()/1638);
		local tool_name = input:get_name();
		local hud_image = "";

		if tool_name and minetest.registered_items[tool_name] then
			if minetest.registered_items[tool_name].inventory_image then
				hud_image = minetest.registered_items[tool_name].inventory_image;
			elseif minetest.registered_items[tool_name].textures and type(minetest.registered_items[ tool_name ].textures)=='table' then
				hud_image = minetest.registered_items[tool_name].textures[1];
			elseif minetest.registered_items[tool_name].textures and type(minetest.registered_items[ tool_name ].textures)=='string' then
				hud_image = minetest.registered_items[tool_name].textures;
			end
		end	

		local hud1 = puncher:hud_add({
				hud_elem_type = "image",
				scale = {x = 15, y = 15},
				text = hud_image,
				position = {x = 0.5, y = 0.5},
				alignment = {x = 0, y = 0}
			});
		local hud2 = nil
		local hud3 = nil

		if input:get_wear()>0 then
			hud2 = puncher:hud_add({
				hud_elem_type = "statbar",
				text = "default_cloud.png^[colorize:#ff0000:256",
				number = 40,
				direction = 0, -- left to right
				position = {x=0.5, y=0.65},
				alignment = {x = 0, y = 0},
				offset = {x = -320, y = 0},
				size = {x=32, y=32},
			})

			hud3 = puncher:hud_add({
				hud_elem_type = "statbar",
				text = "default_cloud.png^[colorize:#00ff00:256",
				number = damage_state,
				direction = 0, -- left to right
				position = {x=0.5, y=0.65},
				alignment = {x = 0, y = 0},
				offset = {x = -320, y = 0},
				size = {x=32, y=32},
			});
		end

		minetest.after(2, 
			function()
				if puncher  then
					puncher:hud_remove(hud1);
					puncher:hud_remove(hud2);
					puncher:hud_remove(hud3);
				end
		end)

		-- tell the player when the job is done
		if input:get_wear() == 0  then
			return;
		end
		-- do the actual repair
		input:add_wear( -500 );
		inv:set_stack("input", 1, input)
		-- damage the hammer slightly
		wielded:add_wear(100);
		puncher:set_wielded_item(wielded);
	end,
	is_ground_content = false,
})

---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
minetest.register_craft({
	output = "smithy:hammer",
	recipe = {
		{"default:steel_ingot","default:bronze_ingot","default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{'',"group:stick",''}
	}
})
