lord_homedecor = lord_homedecor or {}

local placeholder_node = 'lord_homedecor:expansion_placeholder'

-- avoid facedir for some drawtypes as they might be used internally for something else
-- even if undocumented
local NO_FACEDIR_DRAWTYPES = {
	glasslike_framed = true,
	raillike         = true,
	plantlike        = true,
	firelike         = true,
}

--- @param def table
--- @return string|nil
local function get_drawtype(def)
	return def.drawtype
		or (def.mesh and 'mesh')
		or (def.node_box and 'nodebox')
end

--- @param def table
local function apply_infotext(def)
	local infotext = def.infotext
	--def.infotext = nil -- currently used to set locked refrigerator infotexts
	if not infotext then
		return
	end

	local on_construct = def.on_construct
	def.on_construct = function(pos)
		local meta = core.get_meta(pos)
		meta:set_string('infotext', infotext)
		if on_construct then on_construct(pos) end
	end
end

--- Removes the node at `pos` if it is the `expected_name` node or an expansion placeholder.
--- @param pos           Position
--- @param expected_name string
local function remove_expanded_node(pos, expected_name)
	local node = core.get_node(pos).name
	if node == expected_name or node == placeholder_node then
		core.remove_node(pos)
	end
end

--- @param pos    Position
--- @param fdir   integer
--- @param expand table
local function remove_side_expansions(pos, fdir, expand)
	if expand.forward == 'air' then
		return
	end

	if expand.right then
		local right = lord_homedecor.fdir_to_right[fdir+1]
		remove_expanded_node({ x = pos.x + right[1], y = pos.y, z = pos.z + right[2] }, expand.right)
	end
	if expand.forward then
		local forward = lord_homedecor.fdir_to_fwd[fdir+1]
		remove_expanded_node({ x = pos.x + forward[1], y = pos.y, z = pos.z + forward[2] }, expand.forward)
	end
end

--- @param expand         table
--- @param after_unexpand function|nil
--- @return function
local function make_after_dig_node(expand, after_unexpand)
	return function(pos, oldnode, oldmetadata, digger)
		if expand.top and expand.forward ~= 'air' then
			remove_expanded_node({ x = pos.x, y = pos.y + 1, z = pos.z }, expand.top)
		end

		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end

		remove_side_expansions(pos, fdir, expand)

		if after_unexpand then
			after_unexpand(pos)
		end
	end
end

--- @param expand table
--- @return function
local function make_on_place(expand)
	return function(itemstack, placer, pointed_thing)
		if expand.top then
			return lord_homedecor.stack_vertically(itemstack, placer, pointed_thing, itemstack:get_name(), expand.top)
		elseif expand.right then
			return lord_homedecor.stack_sideways(itemstack, placer, pointed_thing, itemstack:get_name(), expand.right, true)
		elseif expand.forward then
			return lord_homedecor.stack_sideways(itemstack, placer, pointed_thing, itemstack:get_name(), expand.forward, false)
		end
	end
end

--- @param def table
local function apply_expansion(def)
	local expand = def.expand
	def.expand = nil
	local after_unexpand = def.after_unexpand
	def.after_unexpand = nil

	if not expand then
		return
	end

	-- dissallow rotating only half the expanded node by default
	-- unless we know better
	def.on_rotate = def.on_rotate
		or (def.mesh and expand.top and screwdriver.rotate_simple)
		or screwdriver.disallow

	def.on_place       = def.on_place or make_on_place(expand)
	def.after_dig_node = def.after_dig_node or make_after_dig_node(expand, after_unexpand)
end

--wrapper around core.register_node that sets sane defaults and interprets some specialized settings
function lord_homedecor.register(name, original_def)
	local def = table.copy(original_def)

	def.drawtype  = get_drawtype(def)
	def.paramtype = def.paramtype or 'light'
	if not NO_FACEDIR_DRAWTYPES[def.drawtype] then
		def.paramtype2 = def.paramtype2 or 'facedir'
	end

	lord_homedecor.handle_inventory(name, def, original_def)

	apply_infotext(def)
	apply_expansion(def)

	-- register the actual minetest node
	core.register_node('lord_homedecor:' .. name, def)
end
