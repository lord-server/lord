-- TREE FUNCTIONS

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

local branch_Type = {
	SHURIKEN = 1,
	DIAGONAL = 2,
}

--- @overload fun(sapling_pos:Position,add_at_dy:number,node_name:string)
--- @param sapling_pos     Position where tree trunk starts (or where sapling was).
--- @param add_at_dy       number   height where crown to add at.
--- @param node_name       string   technical name of leaf or table with name & name of alternative leaf or fruit.
--- @param trunk_thickness number   default:1
--- @param length          number   default:1
--- @param type            number   type of branch (one of `branch_Type::<CONST>`)
local function add_branches_trunks_at(sapling_pos, add_at_dy, node_name, trunk_thickness, length, type)
	type    = type or branch_Type.SHURIKEN
	length  = length or 1
	local t = trunk_thickness or 1

	local pos = vector.new(sapling_pos) + vector.new(0, add_at_dy, 0)

	if type == branch_Type.SHURIKEN then
		for i = 0, length - 1 do
			add_trunk_node({ x = pos.x        , y = pos.y, z = pos.z + t + i }, node_name)
			add_trunk_node({ x = pos.x + t - 1, y = pos.y, z = pos.z - 1 - i }, node_name)
			add_trunk_node({ x = pos.x + t + i, y = pos.y, z = pos.z + t - 1 }, node_name)
			add_trunk_node({ x = pos.x - 1 - i, y = pos.y, z = pos.z         }, node_name)
		end
	elseif type == branch_Type.DIAGONAL then
		t = t - 1
		for i = 1, length do
			add_trunk_node({ x = pos.x + t + i, y = pos.y - 1 + i, z = pos.z + t + i }, "default:jungletree")
			add_trunk_node({ x = pos.x + t + i, y = pos.y - 1 + i, z = pos.z     - i }, "default:jungletree")
			add_trunk_node({ x = pos.x     - i, y = pos.y - 1 + i, z = pos.z + t + i }, "default:jungletree")
			add_trunk_node({ x = pos.x     - i, y = pos.y - 1 + i, z = pos.z     - i }, "default:jungletree")
		end
	else
		error("Unknown branch Type: " .. type, 2)
	end
end

--- @param pos       Position of branch trunk, around which will leaves be added.
--- @param node_name string   technical name of leaf ("<mod>:<node>").
--- @param radius    number   possible radius of crown around branch.
local function add_branch_crown_in(pos, node_name, radius)
	radius = radius or 2
	for dx = -math.random(radius), math.random(radius) do
		for dz = -math.random(radius), math.random(radius) do
			add_leaf_node({ x = pos.x + dx, y = pos.y + math.random(0, 1), z = pos.z + dz }, node_name)
		end
	end
end

--- @overload fun(pos:Position,node_name:string)
--- @param pos             Position
--- @param node_name       string
--- @param trunk_thickness number   default:1
local function add_roots(pos, node_name, trunk_thickness)
	add_branches_trunks_at(pos, 0, node_name, trunk_thickness or 1)
end

--- @param abs_dx number how far the current leaf from trunk by x coordinate
--- @param abs_dz number how far the current leaf from trunk by z coordinate
--- @param radius number crown radius
local function is_crown_corners(abs_dx, abs_dz, radius)
	return
		(abs_dz == radius) and (abs_dx + 1 > (radius + 1) / 2) or
		(abs_dx == radius) and (abs_dz + 1 > (radius + 1) / 2)
end

local crown_level_Type = {
	RING = 1,
	CONE = 2,
}

--- @class tree.crown.Properties
--- @field no_leaves_on_corners boolean Default: `false`
--- @field level_type           number  type of crown part(level) (one of `crown_level_Type::<CONST>`). Default: `RING`
--- @field cone_solid           boolean not hollow crown for `CONE` crown_level_Type. Default: `false`

--- @param sapling_pos Position where tree trunk starts (or where sapling was).
--- @param add_at_dy   number   height where crown to add at.
--- @param radius      number   radius of whole crown. Or table with {radius_x, radius_z}.
--- @param node_name   string   technical name of leaf or table with name & name of alternative leaf or fruit.
--- @param properties  tree.crown.Properties additional properties of crown placement.
local function add_crown_at(sapling_pos, add_at_dy, radius, node_name, properties)
	local radius_x = type(radius) == "table" and radius[1] or radius
	local radius_z = type(radius) == "table" and radius[2] or radius
	radius = (radius_x + radius_z) / 2

	local alternative_node_name
	alternative_node_name = type(node_name) == "table" and node_name[2] or nil
	node_name             = type(node_name) == "table" and node_name[1] or node_name

	properties = properties or {}
	properties.no_leaves_on_corners = properties.no_leaves_on_corners or false
	properties.level_type           = properties.level_type or crown_level_Type.RING
	properties.cone_solid           = properties.cone_solid or false

	if properties.level_type == crown_level_Type.RING then

		for dx = -radius_x, radius_x do
			for dz = -radius_z, radius_z do repeat -- this `repeat` is for continue statement below
				local abs_dx = math.abs(dx)
				local abs_dz = math.abs(dz)
				if properties.no_leaves_on_corners and is_crown_corners(abs_dx, abs_dz, radius) then
					break -- continue (breaks only `repeat` statement, not `for`)
				end

				if math.random() > (abs_dx + abs_dz) / 24 then
					local position = vector.new(sapling_pos) + vector.new(dx, add_at_dy + math.random(0, 1), dz)
					add_leaf_node(position, node_name)
				end
				if alternative_node_name then
					if math.random() > (abs_dx + abs_dz) / 12 then
						local position = vector.new(sapling_pos) + vector.new(dx, add_at_dy + math.random(0, 1), dz)
						add_leaf_node(position, alternative_node_name)
					end
				end
			until true end
		end

	elseif properties.level_type == crown_level_Type.CONE then

		local pos = sapling_pos
		for dx = -radius, radius do
			for dz = -radius, radius do
				local abs_dx = math.abs(dx)
				local abs_dz = math.abs(dz)
				local dy = abs_dx >= abs_dz and add_at_dy - abs_dx or add_at_dy - abs_dz
				if math.random() > (abs_dx + abs_dz) / 24 then
					add_leaf_node(    { x = pos.x + dx,     y = pos.y + dy, z = pos.z + dz     }, node_name)
					if properties.cone_solid then
						add_leaf_node({ x = pos.x + dx + 1, y = pos.y + dy, z = pos.z + dz     }, node_name)
						add_leaf_node({ x = pos.x + dx - 1, y = pos.y + dy, z = pos.z + dz     }, node_name)
						add_leaf_node({ x = pos.x + dx,     y = pos.y + dy, z = pos.z + dz + 1 }, node_name)
						add_leaf_node({ x = pos.x + dx,     y = pos.y + dy, z = pos.z + dz - 1 }, node_name)
					end
				end
			end
		end

	else
		error("Unknown crown level Type: " .. type, 2)
	end
end


-- Alders / Ольха

function lottplants_aldertree(pos)
	local height = 6 + math.random(2)
	local radius = 3

	add_trunk(pos, height, "lottplants:aldertree")

	add_crown_at(pos, height - 2, radius, "lottplants:alderleaf", { no_leaves_on_corners = true })
	add_crown_at(pos, height,     radius, "lottplants:alderleaf", { no_leaves_on_corners = true })
end

-- Apple tree / Яблоня

function lottplants_appletree(pos)
	local height = 3 + math.random(2)
	local radius = 3

	add_trunk(pos, height, "default:tree")
	-- HACK: это адаптированная версия, лучше бы передавать шансы листьев и альтернативной ноды
	--       но в данном варианте выдаёт примерно то же самое кол-во яблок, что и раньше
	add_crown_at(pos, height - 2, radius, { "default:apple", "lottplants:appleleaf" })
	add_crown_at(pos, height,     radius, "lottplants:appleleaf")
	add_crown_at(pos, height,     radius, "default:apple")
end

-- Birches / Береза

function lottplants_birchtree(pos)
	local height = 7 + math.random(5)

	add_trunk(pos, height, "lottplants:birchtree")

	add_crown_at(pos, math.floor(height * 0.4), {3,2}, "lottplants:birchleaf")
	add_crown_at(pos, math.floor(height * 0.6), {2,3}, "lottplants:birchleaf")
	add_crown_at(pos, math.floor(height * 0.8), {2,2}, "lottplants:birchleaf")
	add_crown_at(pos, height,                   {2,1}, "lottplants:birchleaf")
end

-- Beeches / Бук

function lottplants_beechtree(pos)
	local height = 12 + math.random(3)

	add_trunk(pos, height, "default:tree")

	add_crown_at(pos, height - 8, 4, "lottplants:beechleaf")
	add_crown_at(pos, height - 8, 4, "lottplants:beechleaf")
	add_crown_at(pos, height - 6, 4, "lottplants:beechleaf")
	add_crown_at(pos, height - 4, 4, "lottplants:beechleaf")
	add_crown_at(pos, height - 2, 3, "lottplants:beechleaf")
	add_crown_at(pos, height,     2, "lottplants:beechleaf")
end

-- Culumalda

function lottplants_culumaldatree(pos)
	local height = 4 + math.random(2)
	local radius = 2

	add_trunk(pos, height, "default:tree")

	add_crown_at(pos, height - 2, radius, { "lottplants:culumaldaleaf", "lottplants:yellowflowers" })
	add_crown_at(pos, height,     radius, { "lottplants:culumaldaleaf", "lottplants:yellowflowers" })
end

-- Elms / Вяз

function lottplants_elmtree(pos)
	local height = 20 + math.random(5)
	local radius = 2

	add_trunk(pos, height, "default:tree")

	add_crown_at(pos, math.floor(height * 0.4), radius, "lottplants:elmleaf")
	add_crown_at(pos, math.floor(height * 0.7), radius, "lottplants:elmleaf")
	add_crown_at(pos, height,                   radius, "lottplants:elmleaf")
end

-- Firs / Ель

function lottplants_firtree(pos)
	local height = 10 + math.random(3)
	local radius = 2

	add_trunk(pos, height, "lottplants:firtree")

	add_crown_at(pos, height + 1, radius, "lottplants:firleaf", { level_type = crown_level_Type.CONE })
	add_crown_at(pos, height - 2, radius, "lottplants:firleaf", { level_type = crown_level_Type.CONE, cone_solid = true })
	add_crown_at(pos, height - 5, radius, "lottplants:firleaf", { level_type = crown_level_Type.CONE, cone_solid = true })
	add_crown_at(pos, height - 8, radius, "lottplants:firleaf", { level_type = crown_level_Type.CONE, cone_solid = true })
end

-- Lebethron

function lottplants_lebethrontree(pos)
	local height = 3 + math.random(1)
	local radius = 2

	add_trunk(pos, height, "lottplants:lebethrontree")

	add_crown_at(pos, math.floor(height * 0.7), radius, "lottplants:lebethronleaf")
	add_crown_at(pos, height,                   radius, "lottplants:lebethronleaf")
end

-- Mallorn

function add_tree_branch_mallorn(pos)
	add_trunk_node(pos, "lottplants:mallorntree")
	add_branch_crown_in(pos, "lottplants:mallornleaf")
end

function lottplants_mallorntree(pos)
	local height = 25 + math.random(5)

	add_trunk(pos, height, "lottplants:mallorntree", 2)
	if math.random(0, 1) == 1 then
		add_roots(pos, "lottplants:mallorntree", 2)
	end

	for dy = height, 0, -1 do
		if (math.sin(dy / height * dy) < 0.2 and dy > 3 and math.random(0, 2) < 1.5) then
			local branch_pos = { x = pos.x + math.random(0, 1), y = pos.y + dy, z = pos.z + math.random(0, 1) }
			add_tree_branch_mallorn(branch_pos)
		end
	end

	add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + height, z = pos.z + 2 })
	add_tree_branch_mallorn({ x = pos.x + 2, y = pos.y + height, z = pos.z     })
	add_tree_branch_mallorn({ x = pos.x,     y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mallorn({ x = pos.x - 1, y = pos.y + height, z = pos.z + 1 })

	add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + height, z = pos.z + 3 })
	add_tree_branch_mallorn({ x = pos.x + 3, y = pos.y + height, z = pos.z     })
	add_tree_branch_mallorn({ x = pos.x,     y = pos.y + height, z = pos.z - 2 })
	add_tree_branch_mallorn({ x = pos.x - 2, y = pos.y + height, z = pos.z + 1 })
end

function lottplants_smallmallorntree(pos)
	local height = 15
	local radius = 2

	add_trunk(pos, height, "lottplants:mallorntree")

	add_crown_at(pos, height - 4, radius, "lottplants:mallornleaf")
	add_crown_at(pos, height,     radius, "lottplants:mallornleaf")
end

function lottplants_young_mallorn(pos)
	local height = 6 + math.random(1)
	local radius = 1

	add_trunk(pos, height, "lottplants:mallorntree_young")

	add_crown_at(pos, height - 2, radius, "lottplants:mallornleaf")
	add_crown_at(pos, height,     radius, "lottplants:mallornleaf")
end

-- Pines / Сосна

function lottplants_pinetree(pos)
	local height = 10 + math.random(3)
	local radius = 2

	add_trunk(pos, height, "lottplants:pinetree")

	add_crown_at(pos, height + 1, radius, "lottplants:pineleaf", { level_type = crown_level_Type.CONE })
	add_crown_at(pos, height - 2, radius, "lottplants:pineleaf", { level_type = crown_level_Type.CONE })
	add_crown_at(pos, height - 5, radius, "lottplants:pineleaf", { level_type = crown_level_Type.CONE })
end

-- Plum Trees / Слива

function lottplants_plumtree(pos)
	local height = 4 + math.random(2)
	local radius = 2

	add_trunk(pos, height, "default:tree")

	add_crown_at(pos, height - 2, radius, { "lottplants:plumleaf", "lottplants:plum" })
	add_crown_at(pos, height,     radius, { "lottplants:plumleaf", "lottplants:plum" })
end


-- Rowans / Рябина

function lottplants_rowantree(pos)
	local height = 6 + math.random(2)

	add_trunk(pos, height, "default:tree")

	add_crown_at(pos, height - 4, 2, "lottplants:rowanleaf")
	add_crown_at(pos, height - 2, 3, { "lottplants:rowanleaf", "lottplants:rowanberry" })
	add_crown_at(pos, height,     2, "lottplants:rowanleaf")
end

-- White Tree / Белое дерево

function lottplants_whitetree(pos)
	local height = 4 + math.random(2)
	local radius = 2

	add_trunk(pos, height, "default:tree")

	add_crown_at(pos, height - 2, radius, "lottplants:whiteleaf")
	add_crown_at(pos, height,     radius, "lottplants:whiteleaf")
end

-- Yavannamire / Йаванамирэ

function lottplants_yavannamiretree(pos)
	local height = 4 + math.random(2)
	local radius = 2

	add_trunk(pos, height, "default:tree")

	add_crown_at(pos, height - 2, radius, { "lottplants:yavannamireleaf", "lottplants:yavannamirefruit" })
	add_crown_at(pos, height,     radius, { "lottplants:yavannamireleaf", "lottplants:yavannamirefruit" })
end

--Mirk large / Большое дерево Лихолесья

function add_tree_branch_mirktree(pos)
	add_trunk_node(pos, "default:jungletree")
	add_branch_crown_in(pos, "lottplants:mirkleaf")
end

function lottplants_mirktree(pos)
	local height = 5 + math.random(1)

	add_trunk(pos, height, "default:jungletree", 2)
	if math.random(0, 1) == 1 then
		add_roots(pos, "default:jungletree", 2)
	end

	add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + height, z = pos.z + 2 })
	add_tree_branch_mirktree({ x = pos.x + 2, y = pos.y + height, z = pos.z     })
	add_tree_branch_mirktree({ x = pos.x,     y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mirktree({ x = pos.x - 1, y = pos.y + height, z = pos.z + 1 })
	add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + height, z = pos.z + 3 })
	add_tree_branch_mirktree({ x = pos.x + 3, y = pos.y + height, z = pos.z     })
	add_tree_branch_mirktree({ x = pos.x,     y = pos.y + height, z = pos.z - 2 })
	add_tree_branch_mirktree({ x = pos.x - 2, y = pos.y + height, z = pos.z + 1 })
end

--Mirk Small / Малое дерево Лихолесья

function lottplants_smallmirktree(pos)
	local height = 7

	add_trunk(pos, height - 2, "default:jungletree")

	local dy = 6
	add_branches_trunks_at(pos, 6, "default:jungletree", 1, 2, branch_Type.DIAGONAL)

	for dx = -4, 4 do
		for dz = -4, 4 do
			if math.random(20) ~= 10 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(1, 2), z = pos.z + dz }, "lottplants:mirkleaf")
			end
		end
	end
end
