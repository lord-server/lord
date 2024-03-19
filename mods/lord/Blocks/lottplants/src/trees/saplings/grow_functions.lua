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

--- @overload fun(pos:Position,node_name:string)
--- @param pos             Position
--- @param node_name       string
--- @param trunk_thickness number   default:1
local function add_roots(pos, node_name, trunk_thickness)
	local t = trunk_thickness or 1
	add_trunk_node({ x = pos.x        , y = pos.y, z = pos.z + t     }, node_name)
	add_trunk_node({ x = pos.x + t - 1, y = pos.y, z = pos.z - 1     }, node_name)
	add_trunk_node({ x = pos.x + t    , y = pos.y, z = pos.z + t - 1 }, node_name)
	add_trunk_node({ x = pos.x - 1    , y = pos.y, z = pos.z         }, node_name)
end

--- @param abs_dx number how far the current leaf from trunk by x coordinate
--- @param abs_dz number how far the current leaf from trunk by z coordinate
--- @param radius number crown radius
local function is_crown_corners(abs_dx, abs_dz, radius)
	return
		(abs_dz == radius) and (abs_dx + 1 > (radius + 1) / 2) or
		(abs_dx == radius) and (abs_dz + 1 > (radius + 1) / 2)
end

--- @class tree.crown.Properties
--- @field no_leaves_on_corners boolean

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

	for dx = -radius_x, radius_x do
		for dz = -radius_z, radius_z do repeat -- this `repeat` is for continue statement below
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if properties.no_leaves_on_corners and is_crown_corners(abs_dx, abs_dz, radius) then
				break -- continue (breaks only `repeat` statement, not `for`)
			end

			if math.random() > (abs_dx + abs_dz) / 24 then
				local position = vector.add(sapling_pos, vector.new(dx, add_at_dy + math.random(0, 1), dz))
				add_leaf_node(position, node_name)
			end
			if alternative_node_name then
				if math.random() > (abs_dx + abs_dz) / 12 then
					local position = vector.add(sapling_pos, vector.new(dx, add_at_dy + math.random(0, 1), dz))
					add_leaf_node(position, alternative_node_name)
				end
			end
		until true end
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

	for dy = height - 2, height do
		if dy == height or dy == height - 2 then
			for dx = -radius, radius do
				for dz = -radius, radius do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if not is_crown_corners(abs_dx, abs_dz, radius) then
						if math.random() > (abs_dx + abs_dz) / 12 then
							add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "default:apple")
						end
						if math.random() > (abs_dx + abs_dz) / 24 then
							add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:appleleaf")
						end
					end
				end
			end
		end
	end
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
	local height = 10 + math.random(3)

	add_trunk(pos, height, "default:tree")

	for dx = -2, 2 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			local dy
			if abs_dx >= abs_dz then
				dy = height - abs_dx
			else
				dy = height - abs_dz
			end
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 7, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 4, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx + 2, y = pos.y + dy + 4, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx + 2, y = pos.y + dy + 4, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 4, z = pos.z + dz + 2 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 4, z = pos.z + dz - 2 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 1, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx + 3, y = pos.y + dy + 1, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx - 3, y = pos.y + dy + 1, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 1, z = pos.z + dz + 3 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 1, z = pos.z + dz - 3 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 2, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx + 3, y = pos.y + dy - 2, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx - 3, y = pos.y + dy - 2, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 2, z = pos.z + dz + 3 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 2, z = pos.z + dz - 3 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 5, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx + 4, y = pos.y + dy - 5, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx - 4, y = pos.y + dy - 5, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 5, z = pos.z + dz + 4 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 5, z = pos.z + dz - 4 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 8, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx + 4, y = pos.y + dy - 8, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx - 4, y = pos.y + dy - 8, z = pos.z + dz }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 8, z = pos.z + dz + 4 }, "lottplants:beechleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 8, z = pos.z + dz - 4 }, "lottplants:beechleaf")
			end
		end
	end
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

	add_trunk(pos, height, "lottplants:firtree")

	for dx = -2, 2 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			local dy
			if abs_dx >= abs_dz then
				dy = height - abs_dx
			else
				dy = height - abs_dz
			end
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 1, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 2, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx + 1, y = pos.y + dy - 2, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx - 1, y = pos.y + dy - 2, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 2, z = pos.z + dz + 1 }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 2, z = pos.z + dz - 1 }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 5, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx + 1, y = pos.y + dy - 5, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx - 1, y = pos.y + dy - 5, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 5, z = pos.z + dz + 1 }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 5, z = pos.z + dz - 1 }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 8, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx + 2, y = pos.y + dy - 8, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx - 2, y = pos.y + dy - 8, z = pos.z + dz }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 8, z = pos.z + dz + 2 }, "lottplants:firleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 8, z = pos.z + dz - 2 }, "lottplants:firleaf")
			end
		end
	end
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
	for dx = -math.random(2), math.random(2) do
		for dz = -math.random(2), math.random(2) do
			local p = { x = pos.x + dx, y = pos.y, z = pos.z + dz }
			add_leaf_node(p, "lottplants:mallornleaf")
			local chance = math.abs(dx + dz)
			if (chance < 1) then
				p = { x = pos.x + dx, y = pos.y + 1, z = pos.z + dz }
				add_leaf_node(p, "lottplants:mallornleaf")
			end
		end
	end
end

function lottplants_mallorntree(pos)
	local height = 25 + math.random(5)

	add_trunk(pos, height, "lottplants:mallorntree", 2)
	if math.random(0, 1) == 1 then
		add_roots(pos, "lottplants:mallorntree", 2)
	end

	for dy = height, 0, -1 do
		if (math.sin(dy / height * dy) < 0.2 and dy > 3 and math.random(0, 2) < 1.5) then
			local branch_pos = { x = pos.x + math.random(0, 1), y = pos.y + dy, z = pos.z - math.random(0, 1) }
			add_tree_branch_mallorn(branch_pos)
		end
	end

	add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + height, z = pos.z + 1 })
	add_tree_branch_mallorn({ x = pos.x + 2, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mallorn({ x = pos.x, y = pos.y + height, z = pos.z - 2 })
	add_tree_branch_mallorn({ x = pos.x - 1, y = pos.y + height, z = pos.z })

	add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + height, z = pos.z + 2 })
	add_tree_branch_mallorn({ x = pos.x + 3, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mallorn({ x = pos.x, y = pos.y + height, z = pos.z - 3 })
	add_tree_branch_mallorn({ x = pos.x - 2, y = pos.y + height, z = pos.z })

	add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + height, z = pos.z })
	add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mallorn({ x = pos.x, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mallorn({ x = pos.x, y = pos.y + height, z = pos.z })
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

	add_trunk(pos, height, "lottplants:pinetree")

	for dx = -2, 2 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			local dy
			if abs_dx >= abs_dz then
				dy = height - abs_dx
			else
				dy = height - abs_dz
			end
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + 1, z = pos.z + dz }, "lottplants:pineleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 2, z = pos.z + dz }, "lottplants:pineleaf")
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy - 5, z = pos.z + dz }, "lottplants:pineleaf")
			end
		end
	end
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

	for dy = height - 4, height do
		if dy == height - 4 or dy == height then
			for dx = -2, 2 do
				for dz = -2, 2 do
					if math.random(3) ~= 2 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:rowanleaf")
					end
				end
			end
		else
			for dx = -3, 3 do
				for dz = -3, 3 do
					if math.random(8) == 8 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:rowanberry")
					elseif math.random(2) ~= 2 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:rowanleaf")
					end
				end
			end
		end
	end
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
	for dx = -math.random(2), math.random(2) do
		for dz = -math.random(2), math.random(2) do
			add_leaf_node({ x = pos.x + dx, y = pos.y, z = pos.z + dz }, "lottplants:mirkleaf")
			local chance = math.abs(dx + dz)
			if (chance < 1) then
				add_leaf_node({ x = pos.x + dx, y = pos.y + 1, z = pos.z + dz }, "lottplants:mirkleaf")
			end
		end
	end
end

function lottplants_mirktree(pos)
	local height = 5 + math.random(1)

	add_trunk(pos, height, "default:jungletree", 2)
	if math.random(0, 1) == 1 then
		add_roots(pos, "default:jungletree", 2)
	end

	for dy = height, 0, -1 do
		if (math.sin(dy / height * dy) < 0.2 and dy > 3 and math.random(0, 2) < 1.5) then
			local branch_pos = { x = pos.x + math.random(0, 1), y = pos.y + dy, z = pos.z - math.random(0, 1) }
			add_tree_branch_mirktree(branch_pos)
		end
	end

	add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + height, z = pos.z + 1 })
	add_tree_branch_mirktree({ x = pos.x + 2, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mirktree({ x = pos.x, y = pos.y + height, z = pos.z - 2 })
	add_tree_branch_mirktree({ x = pos.x - 1, y = pos.y + height, z = pos.z })
	add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + height, z = pos.z + 2 })
	add_tree_branch_mirktree({ x = pos.x + 3, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mirktree({ x = pos.x, y = pos.y + height, z = pos.z - 3 })
	add_tree_branch_mirktree({ x = pos.x - 2, y = pos.y + height, z = pos.z })
	add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + height, z = pos.z })
	add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mirktree({ x = pos.x, y = pos.y + height, z = pos.z - 1 })
	add_tree_branch_mirktree({ x = pos.x, y = pos.y + height, z = pos.z })
end

--Mirk Small / Малое дерево Лихолесья

function lottplants_smallmirktree(pos)
	local height = 7

	add_trunk(pos, height - 2, "default:jungletree")

	local dy
	dy = 6
	for dx = -1, 1 do
		for dz = -1, 1 do
			if math.abs(dx) + math.abs(dz) == 2 then
				add_trunk_node({ x = pos.x + dx, y = pos.y + dy, z = pos.z + dz }, "default:jungletree")
			end
		end
	end
	dy = 7
	for dx = -2, 2, 4 do
		for dz = -2, 2, 4 do
			add_trunk_node({ x = pos.x + dx, y = pos.y + dy, z = pos.z + dz }, "default:jungletree")
		end
	end

	dy = 6
	for dx = -4, 4 do
		for dz = -4, 4 do
			if math.random(20) ~= 10 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(1, 2), z = pos.z + dz }, "lottplants:mirkleaf")
			end
		end
	end
end
