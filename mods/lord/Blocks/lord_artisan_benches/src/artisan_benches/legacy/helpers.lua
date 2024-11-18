local S = minetest.get_mod_translator()

-- moved AS IS from lottpotion.

local lottpotion_nodes = {}

function lottpotion_nodes.can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if not inv:is_empty("src") or not inv:is_empty("dst") or not inv:is_empty("fuel") or
		not inv:is_empty("upgrade1") or not inv:is_empty("upgrade2") then
		minetest.chat_send_player(player:get_player_name(), S("Brewer cannot be removed because it is not empty"))
		return false
	else
		return true
	end
end

--- @param meta         NodeMetaRef
--- @param inv          InvRef
--- @param formspec     string
--- @param machine_name string
function lottpotion_nodes.init(meta, inv, formspec, machine_name)
	if meta:get_string("infotext") == "" then
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", machine_name)
		inv:set_size("fuel", 1)
		inv:set_size("src", 2)
		inv:set_size("dst", 1)
	end
	for _, name in pairs({
		"fuel_totaltime",
		"fuel_time",
		"src_totaltime",
		"src_time" }) do
		if not meta:get_float(name) then
			meta:set_float(name, 0.0)
		end
	end
end

--- @param pos       Position
--- @param meta      NodeMetaRef
--- @param node_name string
--- @param info      string
--- @param spec      string
function lottpotion_nodes.update_node(pos, meta, node_name, info, spec)
	minetest.swap_node_if_not_same(pos, node_name)
	meta:set_string("infotext", info)
	meta:set_string("formspec", spec)
end

--- @param meta   NodeMetaRef
--- @param inv    InvRef
--- @param result table
function lottpotion_nodes.process(meta, inv, result)
	meta:set_int("fuel_time", meta:get_int("fuel_time") + 1)
	if result then
		meta:set_int("src_time", meta:get_int("src_time") + 1)
		if meta:get_int("src_time") >= result.time then
			meta:set_int("src_time", 0)
			local result_stack = ItemStack(result.output)
			if inv:room_for_item("dst", result_stack) then
				inv:set_list("src", result.new_input)
				inv:add_item("dst", result_stack)
			end
		end
	else
		meta:set_int("src_time", 0)
	end
end


return lottpotion_nodes
