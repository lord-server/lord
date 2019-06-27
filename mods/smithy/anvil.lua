local SL = lord.require_intllib()

local function has_anvil_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

local tmp = {}
local itemtexture = {}

minetest.register_entity("smithy:item_on_anvil",{
	hp_max = 1,
	visual = "wielditem",
	visual_size = {x=.13,y=.13},
	collisionbox = {0,0,0,0,0,0},
	physical = false,
	textures = {"air"},
	on_activate = function(self, staticdata)
		if tmp.nodename ~= nil and tmp.texture ~= nil then
			self.nodename = tmp.nodename
			tmp.nodename = nil
			self.texture = tmp.texture
			tmp.texture = nil
		elseif staticdata ~= nil and staticdata ~= "" then
			local data = staticdata:split(';')
			if data and data[1] and data[2] then
				self.nodename = data[1]
				self.texture = data[2]
			end
		end
		if self.texture ~= nil then
			self.object:set_properties({textures={self.texture}})
		end
	end,
	get_staticdata = function(self)
		if self.nodename ~= nil and self.texture ~= nil then
			return self.nodename .. ';' .. self.texture
		end
		return ""
	end,
})

local smithy_anvil_formspec =
	"size[8,7]"..
	"background[0,0;8.5,8.5;gui_anvilbg.png;true]"..
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
	sounds = default.node_sound_metal_defaults(),

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

	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory();
		local owner = meta:get_string('owner');
		if not inv:is_empty("input")
			or not inv:is_empty("hammer")
			or not player then
				minetest.chat_send_player( player:get_player_name(), SL('Can not break. Something is inside.'));
			return false;
		elseif owner and owner ~= '' and player:get_player_name() ~= owner  then
			minetest.chat_send_player(player:get_player_name(), SL("Only for @1", owner))
			return false;
		end
		return true;
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_anvil_privilege(meta, player) then
			minetest.chat_send_player(player:get_player_name(), SL("Only for @1", meta:get_string("owner")))
			return 0
		end

		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_anvil_privilege(meta, player) then
			minetest.chat_send_player(player:get_player_name(), SL("Only for @1", meta:get_string("owner")))
			return 0
		end

		local name = stack:get_name()

		itemtexture = minetest.registered_items[name].inventory_image
		
		local px = pos.x
		local py = pos.y + 0.8
		local pz = pos.z

		if listname == 'hammer' and stack and name ~= 'tools:warhammer_steel'
		 and name ~= 'tools:warhammer_bronze'
		 and name ~= 'tools:warhammer_copper'
		 and name ~= 'tools:warhammer_tin'
		 and name ~= 'tools:warhammer_silver'
		 and name ~= 'tools:warhammer_gold'
		 and name ~= 'tools:warhammer_galvorn'
		 and name ~= 'tools:warhammer_mithril'then
			return 0;
		else
			obj = minetest.add_entity({x=px, y=py, z=pz}, "smithy:item_on_anvil")
			--[[remove = {}
			if remove == "do" then
				obj:remove()
			end]]
		end

		if listname == 'input' and stack and
		 (--wooden tools
		 name == 'tools:pick_wood'
		 or name == 'tools:shovel_wood'
		 or name == 'tools:axe_wood'
		 or name == 'tools:sword_wood'
		 or name == 'tools:battleaxe_wood'
		 or name == 'tools:warhammer_wood'
		 or name == 'tools:spear_wood'
		 or name == 'tools:dagger_wood'
		 --stone tools
		 or name == 'tools:pick_stone'
		 or name == 'tools:shovel_stone'
		 or name == 'tools:axe_stone'
		 or name == 'tools:sword_stone'
		 or name == 'tools:battleaxe_stone'
		 or name == 'tools:warhammer_stone'
		 or name == 'tools:spear_stone'
		 or name == 'tools:dagger_stone'
		 --rings
		 or name == 'lottother:dwarf_ring'
		 or name == 'lottother:vilya'
		 or name == 'lottother:narya'
		 or name == 'lottother:nenya'
		 or name == 'lottother:lottother:beast_ring'
		 -- new rings
		 --[[
		 or name == 'lottother:dwarf_ring_new'
		 or name == 'lottother:vilya_new'
		 or name == 'lottother:narya_new'
		 or name == 'lottother:nenya_new'
		 or name == 'lottother:lottother:beast_ring_new'
		 ]]
		 --hammers
		 or name == 'tools:warhammer_bronze'
		 or name == 'tools:warhammer_copper'
		 or name == 'tools:warhammer_tin'
		 or name == 'tools:warhammer_silver'
		 or name == 'tools:warhammer_gold'
		 or name == 'tools:warhammer_galvorn'
		 or name == 'tools:warhammer_mithril'
		 --armor
		 or name == 'lottarmor:helmet_wood'
		 or name == 'lottarmor:chestplate_wood'
		 or name == 'lottarmor:leggings_wood'
		 or name == 'lottarmor:boots_wood'
		 or name == 'lottarmor:shield_wood'
		 --new armor
		 --[[
		 or name == 'lottarmor:dragon_warrior_helmet'
		 or name == 'lottarmor:dragon_warrior_chestplate'
		 or name == 'lottarmor:dragon_warrior_leggings'
		 or name == 'lottarmor:dragon_warrior_boots'
		 or name == 'lottarmor:dragon_warrior_shield'
		 ]]
		 --special tools/items
		 or name == 'tools:sword_elven'
		 or name == 'tools:sword_orc'
		 or name == 'defaults:ghost_tool'
		 --or name == 'tools:melkor_pick'
		 --or name == 'tools:dragon_warrior_sword'
		 --or name == 'lottother:gem_pick'
		 --[[optional: or name == 'lottother:chisel']]) then
			minetest.chat_send_player(player:get_player_name(), SL('You can not repair this item!'));
			return 0;
		end

		if listname == 'input' and stack:get_wear() == 0 then
			minetest.chat_send_player(player:get_player_name(), SL('The workpiece slot is for damaged tools only.'));
			return 0;
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_anvil_privilege(meta, player) then
			return 0
		end
		obj:remove()
		return stack:get_count()
	end,

	on_punch = function(pos, node, puncher)
		if not (pos or node or puncher) then
			return;
		end

		-- only punching with the hammer is supposed to work
		local wielded = puncher:get_wielded_item();

		if not (wielded or wielded:get_name()) or (wielded:get_name() ~= 'tools:warhammer_steel'
		 and wielded:get_name() ~= 'tools:warhammer_bronze'
		 and wielded:get_name() ~= 'tools:warhammer_copper'
		 and wielded:get_name() ~= 'tools:warhammer_tin'
		 and wielded:get_name() ~= 'tools:warhammer_silver'
		 and wielded:get_name() ~= 'tools:warhammer_gold'
		 and wielded:get_name() ~= 'tools:warhammer_galvorn'
		 and wielded:get_name() ~= 'tools:warhammer_mithril') then
			return 0
		end

		--local name = puncher:get_player_name();
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
			elseif minetest.registered_items[tool_name].textures and
			type(minetest.registered_items[ tool_name ].textures) == 'table' then
				hud_image = minetest.registered_items[tool_name].textures[1];
			elseif minetest.registered_items[tool_name].textures and
			type(minetest.registered_items[ tool_name ].textures) == 'string' then
				hud_image = minetest.registered_items[tool_name].textures;
			end
		end

		local hud1 = puncher:hud_add({
				hud_elem_type = "image",
				scale = {x = 10, y = 10},
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
				offset = {x = -160, y = 0},
				size = {x=16, y=16},
			})

			hud3 = puncher:hud_add({
				hud_elem_type = "statbar",
				text = "default_cloud.png^[colorize:#00ff00:256",
				number = damage_state,
				direction = 0, -- left to right
				position = {x=0.5, y=0.65},
				alignment = {x = 0, y = 0},
				offset = {x = -160, y = 0},
				size = {x=16, y=16},
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

		-- damage the hammer slightly
		if wielded:get_name() == 'tools:warhammer_steel' then
			wielded:add_wear(600);
			input:add_wear( -80 );
			inv:set_stack("input", 1, input)
		elseif wielded:get_name() == 'tools:warhammer_bronze' then
			wielded:add_wear(600);
			input:add_wear( -80 );
			inv:set_stack("input", 1, input)
		elseif wielded:get_name() == 'tools:warhammer_copper' then
			wielded:add_wear(680);
			input:add_wear( -50 );
			inv:set_stack("input", 1, input)
		elseif wielded:get_name() == 'tools:warhammer_tin' then
			wielded:add_wear(680);
			input:add_wear( -50 );
			inv:set_stack("input", 1, input)
		elseif wielded:get_name() == 'tools:warhammer_silver' then
			wielded:add_wear(600);
			input:add_wear( -80 );
			inv:set_stack("input", 1, input)
		elseif wielded:get_name() == 'tools:warhammer_gold' then
			wielded:add_wear(800);
			input:add_wear( -30 );
			inv:set_stack("input", 1, input)
		elseif wielded:get_name() == 'tools:warhammer_galvorn' then
			wielded:add_wear(400);
			input:add_wear( -120 );
			inv:set_stack("input", 1, input)
		elseif wielded:get_name() == 'tools:warhammer_mithril' then
			wielded:add_wear(200);
			input:add_wear( -120 );
			inv:set_stack("input", 1, input)
		end
		puncher:set_wielded_item(wielded);
	end,
	is_ground_content = false,
})
