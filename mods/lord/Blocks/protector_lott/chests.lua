local S = core.get_mod_translator()

-- Protected Chest

core.register_node("protector_lott:chest", {
	description = S("Protected Chest"),
	tiles = {
		"default_chest_top.png", "default_chest_top.png",
		"default_chest_side.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_front.png^protector_logo.png"
	},
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, unbreakable = 1, wooden = 1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = core.get_meta(pos)
		meta:set_string("infotext", S("Protected Chest"))
		meta:set_string("name", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,

	can_dig = function(pos,player)
		local meta = core.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:is_empty("main") then
			if not core.is_protected(pos, player:get_player_name()) then
				return true
			end
		end
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
		" moves stuff to protected chest at " .. core.pos_to_string(pos))
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
		" takes stuff from protected chest at " .. core.pos_to_string(pos))
	end,

	on_rightclick = function(pos, node, clicker)
		if not core.is_protected(pos, clicker:get_player_name()) then
		local meta = core.get_meta(pos)
		local spos = pos.x .. "," .. pos.y .. "," ..pos.z
		local formspec = "size[8,9]"
			.. "list[nodemeta:".. spos .. ";main;0,0.3;8,4;]"
			.. "button[0,4.5;2,0.25;toup;"..S("To Chest").."]"
			.. "field[2.3,4.8;4,0.25;chestname;;"
			.. meta:get_string("name") .. "]"
			.. "button[6,4.5;2,0.25;todn;"..S("To Inventory").."]"
			.. "list[current_player;main;0,5;8,1;]"
			.. "list[current_player;main;0,6.08;8,3;8]"
			.. "listring[nodemeta:" .. spos .. ";main]"
			.. "listring[current_player;main]"

			core.show_formspec(
				clicker:get_player_name(),
				"protector_lott:chest_" .. core.pos_to_string(pos),
				formspec)
		end
	end,
})

--- Moves the stack from one inventory to another.
--- @param from_inv InvRef
--- @param to_inv   InvRef
--- @param stack    ItemStack
local function move_item(from_inv, to_inv, stack)
	local leftover = to_inv:add_item('main', stack)
	from_inv:remove_item('main', stack)
	if leftover and not leftover:is_empty() then
		from_inv:add_item('main', stack)
	end
end

--- Copies contents of the players inventory to the chest.
--- @param player_inv InvRef
--- @param chest_inv  InvRef
local function move_to_chest(player_inv, chest_inv)
	for _, v in ipairs(player_inv:get_list('main') or {}) do
		if chest_inv and chest_inv:room_for_item('main', v) then
			move_item(player_inv, chest_inv, v)
		end
	end
end

--- Copies contents of the chest to the players inventory.
--- @param chest_inv  InvRef
--- @param player_inv InvRef
local function move_to_player(chest_inv, player_inv)
	for _, v in ipairs(chest_inv:get_list('main') or {}) do
		if player_inv:room_for_item('main', v) then
			move_item(chest_inv, player_inv, v)
		end
	end
end

--- Changes the chest infotext to display the name.
--- @param meta MetaDataRef
--- @param name string
local function rename_chest(meta, name)
	if name ~= '' then
		meta:set_string('name', name)
		meta:set_string('infotext',
		S('Protected Chest')..' (' .. name .. ')')
	else
		meta:set_string('infotext', S('Protected Chest'))
	end
end

-- Protected Chest formspec buttons

core.register_on_player_receive_fields(function(player, formname, fields)

	if string.sub(formname, 0, string.len('protector_lott:chest_')) == 'protector_lott:chest_' then

		local pos_s = string.sub(formname,string.len('protector_lott:chest_') + 1)
		local pos = core.string_to_pos(pos_s)
		local meta = core.get_meta(pos)
		local chest_inv = meta:get_inventory()
		local player_inv = player:get_inventory()

		if fields.toup then
			move_to_chest(player_inv, chest_inv)
		elseif fields.todn then
			move_to_player(chest_inv, player_inv)
		elseif fields.chestname then
			rename_chest(meta, fields.chestname)
		end
	end

end)

-- Protected Chest recipe

core.register_craft({
	output = 'protector_lott:chest',
	recipe = {
		{'default:chest', 'protector_lott:protect2', ''},
	}
})

core.register_on_mods_loaded(function()
	if not core.global_exists('chests') then
		return
	end
	chests.add_existing('protector_lott:chest')
end)
