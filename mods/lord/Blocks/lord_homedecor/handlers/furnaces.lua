-- This code supplies an oven/stove. Basically it's just a copy of the default furnace with different textures.

local S = core.get_mod_translator()


local function make_formspec(furnacedef, percent)
	local fire

	if percent and (percent > 0) then
		fire = ("%s^[lowpart:%d:%s"):format(
			furnacedef.fire_bg,
			(100-percent),
			furnacedef.fire_fg
		)
	else
		fire = "default_furnace_fire_bg.png"
	end

	local w = furnacedef.output_width
	local h = math.ceil(furnacedef.output_slots / furnacedef.output_width)

	return "size["..math.max(8, 6 + w)..",9]"..
		"image[2,2;1,1;"..fire.."]"..
		"list[current_name;fuel;2,3;1,1;]"..
		"list[current_name;src;2,1;1,1;]"..
		"list[current_name;dst;5,1;"..w..","..h..";]"..
		"list[current_player;main;0,5;8,4;]"
end

--[[
furnacedef = {
	description = "Oven",
	tiles = { ... },
	tiles_active = { ... },
	^ +Y -Y +X -X +Z -Z
	tile_format = "oven_%s%s.png",
	^ First '%s' replaced by one of "top", "bottom", "side", "front".
	^ Second '%s' replaced by "" for inactive, and "_active" for active "front"
	^ "side" is used for left, right and back.
	^ tiles_active for front is set
	output_slots = 4,
	output_width = 2,
	cook_speed = 1,
	^ Higher values cook stuff faster.
	extra_nodedef_fields = { ... },
	^ Stuff here is copied verbatim into both active and inactive nodedefs
	^ Useful for overriding drawtype, etc.
}
]]

local function make_tiles(tiles, fmt, active)
	if not fmt then return tiles end
	tiles = { }
	for i,side in ipairs{"top", "bottom", "side", "side", "side", "front"} do
		if active and (i == 6) then
			tiles[i] = fmt:format(side, "_active")
		else
			tiles[i] = fmt:format(side, "")
		end
	end
	return tiles
end

local furnace_can_dig = function(pos,player)
	local meta = core.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel")
		and inv:is_empty("dst")
		and inv:is_empty("src")
end

--- Common logic for `allow_metadata_inventory_put` / `allow_metadata_inventory_move`.
--- @param pos         Position
--- @param listname    string target inventory list
--- @param stack       ItemStack moved / put stack
--- @param count       integer   amount to return when the move is allowed
--- @param description string
--- @return integer|nil allowed amount (nil for unknown list)
local function get_allowed_count(pos, listname, stack, count, description)
	if listname == 'fuel' then
		if core.get_craft_result({ method = 'fuel', width = 1, items = { stack } }).time == 0 then
			return 0
		end
		local meta = core.get_meta(pos)
		if meta:get_inventory():is_empty('src') then
			meta:set_string('infotext', S('%s is empty'):format(description))
		end

		return count
	elseif listname == 'src' then
		return count
	elseif listname == 'dst' then
		return 0
	end
end

--- @param furnacedef table
--- @param description string
--- @return function, function, function `on_construct`, `allow_metadata_inventory_put`, `allow_metadata_inventory_move`
local function make_furnace_callbacks(furnacedef, description)
	local function furnace_construct(pos)
		local meta = core.get_meta(pos)
		meta:set_string('formspec', make_formspec(furnacedef, 0))
		meta:set_string('infotext', description)
		local inv = meta:get_inventory()
		inv:set_size('fuel', 1)
		inv:set_size('src', 1)
		inv:set_size('dst', furnacedef.output_slots)
	end

	local function furnace_allow_put(pos, listname, index, stack, player)
		return get_allowed_count(pos, listname, stack, stack:get_count(), description)
	end

	local function furnace_allow_move(pos, from_list, from_index, to_list, to_index, count, player)
		local stack = core.get_meta(pos):get_inventory():get_stack(from_list, from_index)

		return get_allowed_count(pos, to_list, stack, count, description)
	end

	return furnace_construct, furnace_allow_put, furnace_allow_move
end

--- @param furnacedef table
local function set_furnace_defaults(furnacedef)
	furnacedef.fire_fg = furnacedef.fire_bg or 'default_furnace_fire_fg.png'
	furnacedef.fire_bg = furnacedef.fire_bg or 'default_furnace_fire_bg.png'

	furnacedef.output_slots = furnacedef.output_slots or 4
	furnacedef.output_width = furnacedef.output_width or 2

	furnacedef.cook_speed = furnacedef.cook_speed or 1
end

--- @param meta MetaDataRef
local function init_missing_timers(meta)
	for _, property in ipairs({ 'fuel_totaltime', 'fuel_time', 'src_totaltime', 'src_time' }) do
		if meta:get_string(property) == '' then
			meta:set_float(property, 0.0)
		end
	end
end

--- @param meta MetaDataRef
--- @return boolean whether the fuel is still burning
local function is_burning(meta)
	return meta:get_float('fuel_time') < meta:get_float('fuel_totaltime')
end

--- Advance the burning fuel and finish cooking of the source item if it's time.
--- @param meta        MetaDataRef
--- @param inv         InvRef
--- @param cook_speed  number
--- @param cooked      table|nil result of the `cooking` craft for the source list
--- @param aftercooked table|nil
local function burn_and_cook(meta, inv, cook_speed, cooked, aftercooked)
	meta:set_float('fuel_time', meta:get_float('fuel_time') + 1)
	meta:set_float('src_time', meta:get_float('src_time') + cook_speed)
	if not (cooked and cooked.item and meta:get_float('src_time') >= cooked.time) then
		return
	end

	-- check if there's room for output in 'dst' list
	if inv:room_for_item('dst', cooked.item) then
		-- Put result in 'dst' list
		inv:add_item('dst', cooked.item)
		-- take stuff from 'src' list
		inv:set_stack('src', 1, aftercooked.items[1])
	end
	meta:set_string('src_time', 0)
end

--- @param inv InvRef
--- @return table|nil, table|nil result of the `cooking` craft for the source list
local function get_cooking_result(inv)
	local srclist = inv:get_list('src')
	if srclist then
		return core.get_craft_result({ method = 'cooking', width = 1, items = srclist })
	end
end

--- Switch the furnace to the not burning node with the given infotext
local function stop_furnace(meta, pos, furnacedef, idle_node_name, infotext)
	meta:set_string('infotext', infotext)
	core.swap_node_if_not_same(pos, idle_node_name)
	meta:set_string('formspec', make_formspec(furnacedef, 0))
end

--- Takes a new portion of fuel if there is something to cook and room for the result.
--- @param state table { meta, inv, pos, furnacedef, idle_node_name, desc, was_active }
local function try_to_take_fuel(state)
	local meta, inv = state.meta, state.inv
	local cooked = get_cooking_result(inv)

	local fuel, afterfuel
	local fuellist = inv:get_list('fuel')
	if fuellist then
		fuel, afterfuel = core.get_craft_result({ method = 'fuel', width = 1, items = fuellist })
	end

	local stop = function(infotext)
		stop_furnace(meta, state.pos, state.furnacedef, state.idle_node_name, infotext)
	end

	if (not fuel) or (fuel.time <= 0) then
		stop(state.desc .. S(': Out of fuel'))
	elseif cooked.item:is_empty() then
		if state.was_active then
			stop(S('%s is empty'):format(state.desc))
		end
	elseif not inv:room_for_item('dst', cooked.item) then
		stop(state.desc .. S(': output bins are full'))
	else
		meta:set_string('fuel_totaltime', fuel.time)
		meta:set_string('fuel_time', 0)

		inv:set_stack('fuel', 1, afterfuel.items[1])
	end
end

--- @param furnacedef       table
--- @param node_name        string
--- @param node_name_active string
--- @return function ABM `action`
local function make_furnace_action(furnacedef, node_name, node_name_active)
	return function(pos, node, active_object_count, active_object_count_wider)
		local meta = core.get_meta(pos)
		init_missing_timers(meta)

		local inv = meta:get_inventory()
		local was_active = false
		if is_burning(meta) then
			was_active = true
			burn_and_cook(meta, inv, furnacedef.cook_speed, get_cooking_result(inv))
		end

		-- XXX: Quick patch, make it better in the future.
		local locked = node.name:find('_locked$') and '_locked' or ''
		local desc = core.registered_nodes[node_name .. locked].description

		if is_burning(meta) then
			local percent = math.floor(meta:get_float('fuel_time') / meta:get_float('fuel_totaltime') * 100)
			meta:set_string('infotext', S('%s active: %d%%'):format(desc, percent))
			core.swap_node_if_not_same(pos, node_name_active .. locked)
			meta:set_string('formspec', make_formspec(furnacedef, percent))
			return
		end

		try_to_take_fuel({
			meta = meta, inv = inv, pos = pos, furnacedef = furnacedef,
			idle_node_name = node_name .. locked, desc = desc, was_active = was_active,
		})
	end
end

function lord_homedecor.register_furnace(name, furnacedef)
	set_furnace_defaults(furnacedef)

	local description = furnacedef.description or 'Furnace'
	local furnace_construct, furnace_allow_put, furnace_allow_move = make_furnace_callbacks(furnacedef, description)

	local def = {
		description = description,
		tiles = make_tiles(furnacedef.tiles, furnacedef.tile_format, false),
		groups = furnacedef.groups or {cracky=2, wall_connected = 1},
		sounds = furnacedef.sounds or default.node_sound_wood_defaults(),
		on_construct = furnace_construct,
		can_dig = furnace_can_dig,
		allow_metadata_inventory_put = furnace_allow_put,
		allow_metadata_inventory_move = furnace_allow_move,
		inventory = { lockable = true }
	}

	local def_active = {
		description = description .. ' (active)',
		tiles = make_tiles(furnacedef.tiles_active, furnacedef.tile_format, true),
		light_source = 8,
		drop = 'lord_homedecor:' .. name,
		groups = furnacedef.groups or {cracky=2, wall_connected = 1, not_in_creative_inventory=1},
		sounds = furnacedef.sounds or default.node_sound_stone_defaults(),
		on_construct = furnace_construct,
		can_dig = furnace_can_dig,
		allow_metadata_inventory_put = furnace_allow_put,
		allow_metadata_inventory_move = furnace_allow_move,
		inventory = { lockable = true }
	}

	for k, v in pairs(furnacedef.extra_nodedef_fields or {}) do
		def[k] = v
		def_active[k] = v
	end

	local name_active = name..'_active'

	lord_homedecor.register(name, def)
	lord_homedecor.register(name_active, def_active)

	local node_name, node_name_active = 'lord_homedecor:'..name, 'lord_homedecor:'..name_active

	core.register_abm({
		nodenames = { node_name, node_name_active, node_name ..'_locked', node_name_active ..'_locked'},
		label = 'furnaces',
		interval = 1.0,
		chance = 1,
		action = make_furnace_action(furnacedef, node_name, node_name_active),
	})

end
