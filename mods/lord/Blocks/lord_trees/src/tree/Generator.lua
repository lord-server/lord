
local branch_Type      = require('tree.branch.Type')
local crown_level_Type = require("tree.crown.level_Type")


-- TREE GENERATOR

--- Places node only if it was an air in this `pos`
--- @param pos       Position position to place to.
--- @param node_name string   technical name of leaf ("<mod_name>:<node_name>").
local function add_leaf_node(pos, node_name)
	local n = minetest.get_node(pos)
	if (n.name == "air") then
		minetest.add_node(pos, { name = node_name })
	end
end

--- Places node only if it was an air|leaf|sapling in this `pos`
--- @param pos       Position position to place to.
--- @param node_name string   technical name of trunk ("<mod_name>:<node_name>").
local function add_trunk_node(pos, node_name)
	local n = minetest.get_node(pos)
	if (n.name == "air") or (string.find(n.name, "leaf")) or (string.find(n.name, "sapling")) then
		minetest.add_node(pos, { name = node_name })
	end
end

--- @overload fun(pos:Position,height:number,node_name:string)
--- @param pos       Position
--- @param height    number
--- @param node_name string
--- @param thickness number   default:1
local function add_trunk(pos, height, node_name, thickness)
	thickness = thickness or 1
	for dy = 0, height do
		for dx = 0, thickness - 1 do
			for dz = 0, thickness - 1 do
				add_trunk_node({ x = pos.x + dx, y = pos.y + dy, z = pos.z + dz }, node_name)
			end
		end
	end
end

--- @param pos       Position of branch trunk, around which will leaves be added.
--- @param node_name string   technical name of leaf ("<mod>:<node>").
--- @param radius    number   max possible radius of crown around branch.
local function add_branch_crown_in(pos, node_name, radius)
	radius = radius or 2
	for dx = -math.random(radius), math.random(radius) do
		for dz = -math.random(radius), math.random(radius) do
			add_leaf_node({ x = pos.x + dx, y = pos.y + math.random(0, 1), z = pos.z + dz }, node_name)
		end
	end
end

--- @param pos             Position of branch trunk, around which will leaves be added, if `leaf_node_name` not `nil`.
--- @param trunk_node_name string   technical name of trunk node ("<mod>:<node>").
--- @param leaf_node_name  string   technical name of leaf node ("<mod>:<node>").
--- @param radius          number   max possible radius of crown around branch.
local function add_branch_in(pos, trunk_node_name, leaf_node_name, radius)
	add_trunk_node(pos, trunk_node_name)
	if leaf_node_name then
		add_branch_crown_in(pos, leaf_node_name, radius)
	end
end

--- @overload fun(sapling_pos:Position,add_at_dy:number,node_name:string)
--- @param sapling_pos     Position where tree trunk starts (or where sapling was).
--- @param add_at_dy       number   height where branch to add at.
--- @param node_name       string   technical name of trunk node ("<mod>:<node>").
--- @param trunk_thickness number   Default: 1
--- @param length          number   Default: 1
--- @param type            number   type of branch (one of `branch_Type::<CONST>`).
--- @param leaf_node_name  string   technical name of leaf ("<mod>:<node>") or `nil`, if no leaves needed.
local function add_branches_at(sapling_pos, add_at_dy, node_name, trunk_thickness, length, type, leaf_node_name)
	type    = type or branch_Type.SHURIKEN
	length  = length or 1
	local t = trunk_thickness or 1

	local pos = vector.new(sapling_pos) + vector.new(0, add_at_dy, 0)

	if type == branch_Type.SHURIKEN then
		for i = 0, length - 1 do
			add_branch_in({ x = pos.x        , y = pos.y, z = pos.z + t + i }, node_name, leaf_node_name)
			add_branch_in({ x = pos.x + t - 1, y = pos.y, z = pos.z - 1 - i }, node_name, leaf_node_name)
			add_branch_in({ x = pos.x + t + i, y = pos.y, z = pos.z + t - 1 }, node_name, leaf_node_name)
			add_branch_in({ x = pos.x - 1 - i, y = pos.y, z = pos.z         }, node_name, leaf_node_name)
		end
	elseif type == branch_Type.DIAGONAL then
		t = t - 1
		for i = 1, length do
			add_branch_in({ x = pos.x + t + i, y = pos.y - 1 + i, z = pos.z + t + i }, node_name, leaf_node_name)
			add_branch_in({ x = pos.x + t + i, y = pos.y - 1 + i, z = pos.z     - i }, node_name, leaf_node_name)
			add_branch_in({ x = pos.x     - i, y = pos.y - 1 + i, z = pos.z + t + i }, node_name, leaf_node_name)
			add_branch_in({ x = pos.x     - i, y = pos.y - 1 + i, z = pos.z     - i }, node_name, leaf_node_name)
		end
	elseif type == branch_Type.TRUNKED then
		t = t - 1
		for i = 0, length - 1 do
			local branch_pos = { x = pos.x + math.random(0, t), y = pos.y + i, z = pos.z + math.random(0, t) }
			add_branch_in(branch_pos, node_name, leaf_node_name)
		end
	else
		error("Unknown branch Type: " .. type, 2)
	end
end

--- @overload fun(pos:Position,node_name:string)
--- @param pos             Position
--- @param node_name       string
--- @param trunk_thickness number   default:1
local function add_roots(pos, node_name, trunk_thickness)
	add_branches_at(pos, 0, node_name, trunk_thickness or 1)
end


--=== CROWN: ===--

--- @param abs_dx number how far the current leaf from trunk by x coordinate
--- @param abs_dz number how far the current leaf from trunk by z coordinate
--- @param radius number crown radius
local function is_crown_corners(abs_dx, abs_dz, radius)
	return
	(abs_dz == radius) and (abs_dx + 1 > (radius + 1) / 2) or
		(abs_dx == radius) and (abs_dz + 1 > (radius + 1) / 2)
end

--- @param radii    table                                      with {radius_x, radius_z}.
--- @param callback fun(dx:number,dz:number,avg_radius:number) to call on each iteration.
local function foreach_deltas_in_radii(radii, callback)
	local radius_x, radius_z = radii[1], radii[2]
	local avg_radius         = (radius_x + radius_z) / 2
	for dx = -radius_x, radius_x do
		for dz = -radius_z, radius_z do
			callback(dx, dz, avg_radius)
		end
	end
end

--- @param sapling_pos           Position where tree trunk starts (or where sapling was).
--- @param add_at_dy             number   height where crown to add at.
--- @param radii                 number   radii of crown: table with {radius_x, radius_z}.
--- @param leaf_node_name        string   technical name of leaf.
--- @param alternative_node_name string   technical name of alternative leaf or fruit.
--- @param properties  tree.crown.Properties additional properties of crown placement. Defaults in tree.crown.Properties
local function add_ring_crown_at(sapling_pos, add_at_dy, radii, leaf_node_name, alternative_node_name, properties)
	foreach_deltas_in_radii(radii, function(dx, dz, avg_radius)
		local abs_dx = math.abs(dx)
		local abs_dz = math.abs(dz)
		if properties.no_leaves_on_corners and is_crown_corners(abs_dx, abs_dz, avg_radius) then
			return -- continue foreach_deltas_in_radii
		end

		if math.random() > (abs_dx + abs_dz) / 24 then
			local position = vector.new(sapling_pos) + vector.new(dx, add_at_dy + math.random(0, 1), dz)
			add_leaf_node(position, leaf_node_name)
		end
		if alternative_node_name then
			if math.random() > (abs_dx + abs_dz) / 12 then
				local position = vector.new(sapling_pos) + vector.new(dx, add_at_dy + math.random(0, 1), dz)
				add_leaf_node(position, alternative_node_name)
			end
		end
	end)
end

--- @param sapling_pos    Position where tree trunk starts (or where sapling was).
--- @param add_at_dy      number   height where crown to add at.
--- @param radii          number   radii of crown: table with {radius_x, radius_z}.
--- @param leaf_node_name string   technical name of leaf.
--- @param properties  tree.crown.Properties additional properties of crown placement. Defaults in tree.crown.Properties
local function add_cone_crown_at(sapling_pos, add_at_dy, radii, leaf_node_name, properties)
	local pos = sapling_pos
	foreach_deltas_in_radii(radii, function(dx, dz, avg_radius)
		local abs_dx = math.abs(dx)
		local abs_dz = math.abs(dz)
		local dy = abs_dx >= abs_dz and add_at_dy - abs_dx or add_at_dy - abs_dz
		if math.random() > (abs_dx + abs_dz) / 24 then
			add_leaf_node(    { x = pos.x + dx,     y = pos.y + dy, z = pos.z + dz     }, leaf_node_name)
			if properties.cone_solid then
				add_leaf_node({ x = pos.x + dx + 1, y = pos.y + dy, z = pos.z + dz     }, leaf_node_name)
				add_leaf_node({ x = pos.x + dx - 1, y = pos.y + dy, z = pos.z + dz     }, leaf_node_name)
				add_leaf_node({ x = pos.x + dx,     y = pos.y + dy, z = pos.z + dz + 1 }, leaf_node_name)
				add_leaf_node({ x = pos.x + dx,     y = pos.y + dy, z = pos.z + dz - 1 }, leaf_node_name)
			end
		end
	end)
end

--- @param radius number|table radius of whole crown. Or table with {radius_x, radius_z}.
--- @return table with {radius_x, radius_z}.
local function convert_to_radii_table(radius)
	local radius_x = type(radius) == "table" and radius[1] or radius
	local radius_z = type(radius) == "table" and radius[2] or radius

	return { radius_x, radius_z }
end

--- @param node_name   string|string[] technical name of leaf or table with name & name of alternative leaf or fruit.
--- @return string, string             with two crown node names: leaf_node_name, alternative_node_name
local function extract_crown_node_names(node_name)
	local leaf_node_name        = type(node_name) == "table" and node_name[1] or node_name
	local alternative_node_name = type(node_name) == "table" and node_name[2] or nil

	return leaf_node_name, alternative_node_name
end

--- @class tree.crown.Properties
--- @field no_leaves_on_corners boolean Default: `false`
--- @field level_type           number  type of crown part(level) (one of `crown_level_Type::<CONST>`). Default: `RING`
--- @field cone_solid           boolean not hollow crown for `CONE` crown_level_Type. Default: `false`

--- @param sapling_pos Position where tree trunk starts (or where sapling was).
--- @param add_at_dy   number   height where crown to add at.
--- @param radius      number   radius of whole crown. Or table with {radius_x, radius_z}.
--- @param node_name   string   technical name of leaf or table with name & name of alternative leaf or fruit.
--- @param properties  tree.crown.Properties additional properties of crown placement. Defaults in tree.crown.Properties
local function add_crown_at(sapling_pos, add_at_dy, radius, node_name, properties)
	local radii = convert_to_radii_table(radius)
	local leaf_node_name, alternative_node_name = extract_crown_node_names(node_name)

	properties = properties or {}
	properties.no_leaves_on_corners = properties.no_leaves_on_corners or false
	properties.level_type           = properties.level_type or crown_level_Type.RING
	properties.cone_solid           = properties.cone_solid or false

	if properties.level_type == crown_level_Type.RING then
		add_ring_crown_at(sapling_pos, add_at_dy, radii, leaf_node_name, alternative_node_name, properties)
	elseif properties.level_type == crown_level_Type.CONE then
		add_cone_crown_at(sapling_pos, add_at_dy, radii, leaf_node_name, properties)
	else
		error("Unknown crown level Type: " .. type, 2)
	end
end

--- @class tree.Generator
local Generator = {
	--- @private
	--- @type fun(pos:Position)|table<number,fun(pos:Position)>
	grow_function = nil,

	add_trunk       = add_trunk,
	add_roots       = add_roots,
	add_crown_at    = add_crown_at,
	add_branches_at = add_branches_at,
}

--- Constructor
--- @param grow_function fun(pos:Position)|table<number,fun(pos:Position)> function how to grow into a tree.
--- @return tree.Generator
function Generator:new(grow_function)--, area, data) TODO: #661
	local class = self
	self = {}

	self.grow_function = grow_function

	return setmetatable(self, {__index = class})
end

--- @param position Position
function Generator:generate_tree(position)
	if type(self.grow_function) == "table" then
		self.grow_function[math.random(#self.grow_function)](position, self)
	else
		self.grow_function(position, self)
	end
end

return Generator
