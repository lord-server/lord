local S = core.get_mod_translator()

-- vectors to place one node next to or behind another

lord_homedecor.fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 },
}

lord_homedecor.fdir_to_left = {
	{ -1,  0 },
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
}

lord_homedecor.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

local placeholder_node = "lord_homedecor:expansion_placeholder"
core.register_node(placeholder_node, {
	description = "Expansion placeholder (you hacker you!)",
	groups = { not_in_creative_inventory=1 },
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	selection_box = { type = "fixed", fixed = { 0, 0, 0, 0, 0, 0 } },
	is_ground_content = false,
	sunlight_propagates = true,
	buildable_to = false,
})

--- select which node was pointed at based on it being known, not ignored, buildable_to
-- returns nil if no node could be selected
local function select_node(pointed_thing)
	local pos = pointed_thing.under
	local node = core.get_node_or_nil(pos)
	local def = node and core.registered_nodes[node.name]

	if not def or not def.buildable_to then
		pos = pointed_thing.above
		node = core.get_node_or_nil(pos)
		def = node and core.registered_nodes[node.name]
	end
	return def and pos, def
end

--- check if all nodes can and may be build to
local function is_buildable_to(placer_name, ...)
	for _, pos in ipairs({...}) do
		local node = core.get_node_or_nil(pos)
		local def = node and core.registered_nodes[node.name]
		if not (def and def.buildable_to) or core.is_protected(pos, placer_name) then
			return false
		end
	end
	return true
end

--- @param node2 string|nil
--- @return string, boolean name of the node to set, whether it should get the `param2`
local function resolve_second_node(node2)
	if node2 == 'placeholder' then
		return placeholder_node, false
	end
	-- this can be used to clear buildable_to nodes even though we are using a multinode mesh
	-- do not assume by default, as we still might want to allow overlapping in some cases
	node2 = node2 or 'air'

	return node2, node2 ~= 'air'
end

--- call after_place_node of the placed node if available
local function call_after_place_node(node_name, pos, placer)
	local node_def = core.registered_nodes[node_name]
	if node_def and node_def.after_place_node then
		node_def.after_place_node(pos, placer)
	end
end

-- place one or two nodes if and only if both can be placed
local function stack(itemstack, placer, fdir, pos, def, pos2, node1, node2)
	local placer_name = placer:get_player_name() or ""
	if not is_buildable_to(placer_name, pos, pos2) then
		return itemstack
	end

	fdir = fdir or core.dir_to_facedir(placer:get_look_dir())
	core.set_node(pos, { name = node1, param2 = fdir })
	local node2_name, has_facedir = resolve_second_node(node2)
	core.set_node(pos2, { name = node2_name, param2 = has_facedir and fdir or nil })

	call_after_place_node(node1, pos, placer)

	if not lord_homedecor.expect_infinite_stacks(placer) then
		itemstack:take_item()
	end

	return itemstack
end

local function rightclick_pointed_thing(pos, placer, itemstack)
	local node = core.get_node_or_nil(pos)
	if not node then return false end
	local def = core.registered_nodes[node.name]
	if not def or not def.on_rightclick then return false end
	return def.on_rightclick(pos, node, placer, itemstack) or itemstack
end

-- Stack one node above another
-- leave the last argument nil if it's one 2m high node
function lord_homedecor.stack_vertically(itemstack, placer, pointed_thing, node1, node2)
	local rightclick_result = rightclick_pointed_thing(pointed_thing.under, placer, itemstack)
	if rightclick_result then return rightclick_result end

	local pos, def = select_node(pointed_thing)
	if not pos then return itemstack end

	local top_pos = { x=pos.x, y=pos.y+1, z=pos.z }

	return stack(itemstack, placer, nil, pos, def, top_pos, node1, node2)
end

-- Stack one door node above another
-- like  lord_homedecor.stack_vertically but tests first
--    if it was placed as a right wing, then uses node1_right and node2_right instead

function lord_homedecor.stack_wing(itemstack, placer, pointed_thing, node1, node2, node1_right, node2_right)
	local rightclick_result = rightclick_pointed_thing(pointed_thing.under, placer, itemstack)
	if rightclick_result then return rightclick_result end

	local pos, def = select_node(pointed_thing)
	if not pos then return itemstack end

	local forceright = placer:get_player_control()["sneak"]
	local fdir = core.dir_to_facedir(placer:get_look_dir())

	local is_right_wing = node1 == core.get_node({
			x = pos.x + lord_homedecor.fdir_to_left[fdir+1][1],
			y = pos.y,
			z = pos.z + lord_homedecor.fdir_to_left[fdir+1][2],
	}).name
	if forceright or is_right_wing then
		node1, node2 = node1_right, node2_right
	end

	local top_pos = { x=pos.x, y=pos.y+1, z=pos.z }
	return stack(itemstack, placer, fdir, pos, def, top_pos, node1, node2)
end

function lord_homedecor.stack_sideways(itemstack, placer, pointed_thing, node1, node2, dir)
	local rightclick_result = rightclick_pointed_thing(pointed_thing.under, placer, itemstack)
	if rightclick_result then return rightclick_result end

	local pos, def = select_node(pointed_thing)
	if not pos then return itemstack end

	local fdir = core.dir_to_facedir(placer:get_look_dir())
	local fdir_transform = dir and lord_homedecor.fdir_to_right or lord_homedecor.fdir_to_fwd

	local pos2 = { x = pos.x + fdir_transform[fdir+1][1], y=pos.y, z = pos.z + fdir_transform[fdir+1][2] }

	return stack(itemstack, placer, fdir, pos, def, pos2, node1, node2)
end

function lord_homedecor.bed_expansion(pos, placer, itemstack, pointed_thing, color)

	local thisnode = core.get_node(pos)
	local fdir = thisnode.param2

	local fxd = lord_homedecor.fdir_to_fwd[fdir+1][1]
	local fzd = lord_homedecor.fdir_to_fwd[fdir+1][2]

	local forwardpos = {x=pos.x+fxd, y=pos.y, z=pos.z+fzd}
	local forwardnode = core.get_node(forwardpos)

	local def = core.registered_nodes[forwardnode.name]
	local placer_name = placer:get_player_name()

	if not (def and def.buildable_to) then
		core.chat_send_player( placer:get_player_name(), "Not enough room - the space for the headboard is occupied!" )
		core.set_node(pos, {name = "air"})
		return true
	end

	if core.is_protected(forwardpos, placer_name) then
		core.chat_send_player( placer:get_player_name(), "Someone already owns the spot where the headboard goes." )
		return true
	end

	core.set_node(forwardpos, {name = "air"})

	local lxd = lord_homedecor.fdir_to_left[fdir+1][1]
	local lzd = lord_homedecor.fdir_to_left[fdir+1][2]
	local leftpos = {x=pos.x+lxd, y=pos.y, z=pos.z+lzd}
	local leftnode = core.get_node(leftpos)

	local rxd = lord_homedecor.fdir_to_right[fdir+1][1]
	local rzd = lord_homedecor.fdir_to_right[fdir+1][2]
	local rightpos = {x=pos.x+rxd, y=pos.y, z=pos.z+rzd}
	local rightnode = core.get_node(rightpos)

	if leftnode.name == "lord_homedecor:bed_"..color.."_regular" then
		local newname = string.replace(thisnode.name, "_regular", "_kingsize")
		core.set_node(pos, {name = "air"})
		core.set_node(leftpos, { name = newname, param2 = fdir})
	elseif rightnode.name == "lord_homedecor:bed_"..color.."_regular" then
		local newname = string.replace(thisnode.name, "_regular", "_kingsize")
		core.set_node(rightpos, {name = "air"})
		core.set_node(pos, { name = newname, param2 = fdir})
	end

	local topnode = core.get_node({x=pos.x, y=pos.y+1.0, z=pos.z})
	local bottomnode = core.get_node({x=pos.x, y=pos.y-1.0, z=pos.z})

	if string.find(topnode.name, "lord_homedecor:bed_.*_regular$") then
		if fdir == topnode.param2 then
			local newname = string.replace(thisnode.name, "_regular", "_extended")
			core.set_node(pos, { name = newname, param2 = fdir})
		end
	end

	if string.find(bottomnode.name, "lord_homedecor:bed_.*_regular$") then
		if fdir == bottomnode.param2 then
			local newname = string.replace(bottomnode.name, "_regular", "_extended")
			core.set_node({x=pos.x, y=pos.y-1.0, z=pos.z}, { name = newname, param2 = fdir})
		end
	end
end

function lord_homedecor.unextend_bed(pos, color)
	local bottomnode = core.get_node({x=pos.x, y=pos.y-1.0, z=pos.z})
	local fdir = bottomnode.param2
	if string.find(bottomnode.name, "lord_homedecor:bed_.*_extended$") then
		local newname = string.replace(bottomnode.name, "_extended", "_regular")
		core.set_node({x=pos.x, y=pos.y-1.0, z=pos.z}, { name = newname, param2 = fdir})
	end
end

--- @param pos           Position
--- @param compared_name string
local function is_same_banister_at(pos, compared_name)
	local definition = core.get_node(pos)
	local def_name = definition and definition.name or ""
	local node_name = compared_name or "-----"

	def_name = def_name:replace("diagonal_left", "")
	def_name = def_name:replace("diagonal_right", "")
	def_name = def_name:replace("horizontal", "")
	node_name = node_name:replace("diagonal_left", "")
	node_name = node_name:replace("diagonal_right", "")
	node_name = node_name:replace("horizontal", "")

	return def_name == node_name
end

local DIAGONAL_BANISTER_PATTERN = 'lord_homedecor:banister_.*_diagonal'

--- @param pos Position
--- @param dx  number
--- @param dy  number
--- @param dz  number
--- @return Position
local function shifted(pos, dx, dy, dz)
	return { x = pos.x + dx, y = pos.y + dy, z = pos.z + dz }
end

--- @param pos  Position
--- @param fdir integer
--- @return table<string, Position> positions around `pos` relative to the facedir
local function get_banister_neighbour_positions(pos, fdir)
	local left  = lord_homedecor.fdir_to_left[fdir + 1]
	local right = lord_homedecor.fdir_to_right[fdir + 1]
	local fwd   = lord_homedecor.fdir_to_fwd[fdir + 1]

	return {
		below           = shifted(pos, 0, -1, 0),
		fwd             = shifted(pos, fwd[1], 0, fwd[2]),
		left            = shifted(pos, left[1], 0, left[2]),
		right           = shifted(pos, right[1], 0, right[2]),
		left_below      = shifted(pos, left[1], -1, left[2]),
		right_below     = shifted(pos, right[1], -1, right[2]),
		left_fwd        = shifted(pos, left[1] + fwd[1], 0, left[2] + fwd[2]),
		right_fwd       = shifted(pos, right[1] + fwd[1], 0, right[2] + fwd[2]),
		left_fwd_above  = shifted(pos, left[1] + fwd[1], 1, left[2] + fwd[2]),
		right_fwd_above = shifted(pos, right[1] + fwd[1], 1, right[2] + fwd[2]),
		left_fwd_below  = shifted(pos, left[1] + fwd[1], -1, left[2] + fwd[2]),
		right_fwd_below = shifted(pos, right[1] + fwd[1], -1, right[2] + fwd[2]),
	}
end

--- @param placer_name string
--- @param pos         Position
--- @param itemstack   ItemStack
--- @return string|nil message with the reason why the banister can't be placed
local function get_banister_placement_error(placer_name, pos, itemstack)
	local def      = core.registered_nodes[core.get_node(pos).name]
	local abovepos = shifted(pos, 0, 1, 0)
	local adef     = core.registered_nodes[core.get_node(abovepos).name]

	if not (def and def.buildable_to) and not is_same_banister_at(pos, itemstack:get_name()) then
		return S('Cannot place - the space is occupied by another block!')
	end
	if not (adef and adef.buildable_to) then
		return S('Not enough room - the upper space is occupied!')
	end
	if core.is_protected(abovepos, placer_name) then
		return S('Someone already owns that spot.')
	end
end

--- try to place a diagonal one on the side of blocks stacked like stairs
--- or follow an existing diagonal with another.
--- @return string|nil name of the diagonal banister to place
local function get_diagonal_banister_name(base_name, placer_name, near)
	local below_buildable = is_buildable_to(placer_name, near.below)
	local left_below_name  = core.get_node(near.left_below).name
	local right_below_name = core.get_node(near.right_below).name

	if (left_below_name:find('banister_.-_diagonal_right') and below_buildable)
		or not is_buildable_to(placer_name, near.right_fwd_above) then
		return string.replace(base_name, '_horizontal', '_diagonal_right')
	end
	if (right_below_name:find('banister_.-_diagonal_left') and below_buildable)
		or not is_buildable_to(placer_name, near.left_fwd_above) then
		return string.replace(base_name, '_horizontal', '_diagonal_left')
	end
end

--- try to follow a diagonal with the corresponding horizontal: from the top of a diagonal,
--- in-line with the nearest diagonal at the top, at the bottom of a diagonal, in-line at the bottom.
--- @return string|nil, integer|nil, Position|nil name, facedir and position of the horizontal banister to place
local function get_horizontal_banister_after_diagonal(placer_name, near)
	local candidates = {
		{ near.left_below,      false }, { near.right_below,      false },
		{ near.left_fwd_below,  true  }, { near.right_fwd_below,  true  },
		{ near.left,            false }, { near.right,            false },
		{ near.left_fwd,        true  }, { near.right_fwd,        true  },
	}
	for _, candidate in ipairs(candidates) do
		local node = core.get_node(candidate[1])
		local is_fwd = candidate[2]
		if node.name:find(DIAGONAL_BANISTER_PATTERN)
			and (not is_fwd or is_buildable_to(placer_name, near.fwd)) then

			return string.replace(node.name, '_diagonal_.-$', '_horizontal'),
				node.param2, is_fwd and near.fwd or nil
		end
	end
end

--- @return string, integer, Position name, facedir and position of the banister to place
local function choose_banister(base_name, placer_name, near, fdir, pos)
	local diagonal_name = get_diagonal_banister_name(base_name, placer_name, near)
	if diagonal_name then
		return diagonal_name, fdir, pos
	end

	local horizontal_name, horizontal_fdir, horizontal_pos = get_horizontal_banister_after_diagonal(placer_name, near)
	if horizontal_name then
		return horizontal_name, horizontal_fdir, horizontal_pos or pos
	end

	return base_name, fdir, pos
end

--- manually invert left-right orientation
--- @param name string
--- @return string
local function invert_banister_side(name)
	if name:find('banister_.*_diagonal') then
		return string.replace(name, '_left', '_right')
	end

	return string.replace(name, '_right', '_left')
end

--- @param itemstack     ItemStack
--- @param placer        Player
--- @param pointed_thing pointed_thing
function lord_homedecor.place_banister(itemstack, placer, pointed_thing)
	local rightclick_result = rightclick_pointed_thing(pointed_thing.under, placer, itemstack)
	if rightclick_result then return rightclick_result end

	local pos = select_node(pointed_thing)
	if not pos then return itemstack end

	local placer_name = placer:get_player_name()
	local error_message = get_banister_placement_error(placer_name, pos, itemstack)
	if error_message then
		core.chat_send_player(placer_name, error_message)

		return itemstack
	end

	local fdir   = core.dir_to_facedir(placer:get_look_dir())
	local pindex = itemstack:get_meta():get_int('palette_index')
	local near   = get_banister_neighbour_positions(pos, fdir)

	local new_place_name
	new_place_name, fdir, pos = choose_banister(itemstack:get_name(), placer_name, near, fdir, pos)

	if placer:get_player_control()['sneak'] then
		new_place_name = invert_banister_side(new_place_name)
	end

	if not is_same_banister_at(pos, new_place_name) then
		itemstack:take_item()
	end
	core.set_node(pos, { name = new_place_name, param2 = fdir + pindex })

	return itemstack
end
