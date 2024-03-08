-- TREE FUNCTIONS

function add_leaf_node(pos, node_name)
	local n = minetest.get_node(pos)
	if (n.name == "air") then
		minetest.add_node(pos, { name = node_name })
	end
end

--- @param pos       Position
--- @param node_name string
local function add_trunk_node(pos, node_name)
	local n = minetest.get_node(pos)
	if (n.name == "air") or (string.find(n.name, "leaf")) or (string.find(n.name, "sapling")) then
		minetest.add_node(pos, { name = node_name })
	end
end

--- @param pos       Position
--- @param height    number
--- @param node_name string
local function add_trunk(pos, height, node_name)
	for dy = 0, height do
		add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z }, node_name)
	end
end

-- Alders / Ольха

function lottplants_aldertree(pos)
	local height = 6 + math.random(2)
	local radius = 3

	add_trunk(pos, height, "lottplants:aldertree")

	for dy = height - 2, height do
		if dy == height or dy == height - 2 then
			for dx = -radius, radius do
				for dz = -radius, radius do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if not (
						(abs_dz == radius) and (abs_dx + 1 > (radius + 1) / 2)
							or
							(abs_dx == radius) and (abs_dz + 1 > (radius + 1) / 2)
					) then
						if math.random() > (abs_dx + abs_dz) / 24 then
							add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:alderleaf")
						end
					end
				end
			end
		end
	end
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
					if not (
						(abs_dz == radius) and (abs_dx + 1 > (radius + 1) / 2) or
						(abs_dx == radius) and (abs_dz + 1 > (radius + 1) / 2)
					) then
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

	local dy
	dy = math.floor(height * 0.4)
	for dx = -3, 3 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:birchleaf")
			end
		end
	end

	dy = math.floor(height * 0.6)
	for dx = -2, 2 do
		for dz = -3, 3 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:birchleaf")
			end
		end
	end

	dy = math.floor(height * 0.8)
	for dx = -2, 2 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:birchleaf")
			end
		end
	end

	dy = height
	for dx = -2, 2 do
		for dz = -1, 1 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:birchleaf")
			end
		end
	end

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

	add_trunk(pos, height, "default:tree")

	for dy = height - 2, height do
		if dy == height or dy == height - 2 then
			for dx = -2, 2 do
				for dz = -2, 2 do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if math.random() > (abs_dx + abs_dz) / 24 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:culumaldaleaf")
					end
					if math.random() > (abs_dx + abs_dz) / 12 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:yellowflowers")
					end
				end
			end
		end
	end
end

-- Elms / Вяз

function lottplants_elmtree(pos)
	local height = 20 + math.random(5)

	add_trunk(pos, height, "default:tree")

	local dy
	dy = math.floor(height * 0.4)
	for dx = -2, 2 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:elmleaf")
			end
		end
	end

	dy = math.floor(height * 0.7)
	for dx = -2, 2 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:elmleaf")
			end
		end
	end

	dy = height
	for dx = -2, 2 do
		for dz = -2, 2 do
			local abs_dx = math.abs(dx)
			local abs_dz = math.abs(dz)
			if math.random() > (abs_dx + abs_dz) / 24 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:elmleaf")
			end
		end
	end

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

	add_trunk(pos, height, "lottplants:lebethrontree")

	for dy = 1, height do
		if dy == math.floor(height * 0.7) or dy == height then
			for dx = -2, 2 do
				for dz = -2, 2 do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if math.random() > (abs_dx + abs_dz) / 24 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:lebethronleaf")
					end
				end
			end
		end
	end
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
	add_trunk_node(pos, "lottplants:mallorntree") -- заменяем саженец на ствол

	for dy = height, 0, -1 do
		if (math.sin(dy / height * dy) < 0.2 and dy > 3 and math.random(0, 2) < 1.5) then
			local branch_pos = { x = pos.x + math.random(0, 1), y = pos.y + dy, z = pos.z - math.random(0, 1) }
			add_tree_branch_mallorn(branch_pos)
		end
		if dy < math.random(0, 1) then
			add_trunk_node({ x = pos.x + 1, y = pos.y + dy, z = pos.z + 1 }, "lottplants:mallorntree")
			add_trunk_node({ x = pos.x + 2, y = pos.y + dy, z = pos.z - 1 }, "lottplants:mallorntree")
			add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z - 2 }, "lottplants:mallorntree")
			add_trunk_node({ x = pos.x - 1, y = pos.y + dy, z = pos.z }, "lottplants:mallorntree")
		end
		if dy == height then
			add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + dy, z = pos.z + 1 })
			add_tree_branch_mallorn({ x = pos.x + 2, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mallorn({ x = pos.x, y = pos.y + dy, z = pos.z - 2 })
			add_tree_branch_mallorn({ x = pos.x - 1, y = pos.y + dy, z = pos.z })
			add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + dy, z = pos.z + 2 })
			add_tree_branch_mallorn({ x = pos.x + 3, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mallorn({ x = pos.x, y = pos.y + dy, z = pos.z - 3 })
			add_tree_branch_mallorn({ x = pos.x - 2, y = pos.y + dy, z = pos.z })
			add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + dy, z = pos.z })
			add_tree_branch_mallorn({ x = pos.x + 1, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mallorn({ x = pos.x, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mallorn({ x = pos.x, y = pos.y + dy, z = pos.z })
		else
			add_trunk_node({ x = pos.x + 1, y = pos.y + dy, z = pos.z }, "lottplants:mallorntree")
			add_trunk_node({ x = pos.x + 1, y = pos.y + dy, z = pos.z - 1 }, "lottplants:mallorntree")
			add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z - 1 }, "lottplants:mallorntree")
			add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z }, "lottplants:mallorntree")
		end
	end
end

function lottplants_smallmallorntree(pos)
	local height = 15

	add_trunk(pos, height, "lottplants:mallorntree")

	for dy = 11, height do
		if dy == 11 or dy == height then
			for dx = -2, 2 do
				for dz = -2, 2 do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if math.random() > (abs_dx + abs_dz) / 24 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:mallornleaf")
					end
				end
			end
		end
	end
end

function lottplants_young_mallorn(pos)
	local height = 6 + math.random(1)

	add_trunk(pos, height, "lottplants:mallorntree_young")

	for dy = height - 2, height do
		if dy == height or dy == height - 2 then
			for dx = -1, 1 do
				for dz = -1, 1 do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if math.random() > (abs_dx + abs_dz) / 24 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:mallornleaf")
					end
				end
			end
		end
	end
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

	add_trunk(pos, height, "default:tree")

	for dy = height - 2, height do
		if dy == height or dy == height - 2 then
			for dx = -2, 2 do
				for dz = -2, 2 do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if math.random() > (abs_dx + abs_dz) / 24 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:plumleaf")
					end
					if math.random() > (abs_dx + abs_dz) / 12 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:plum")
					end
				end
			end
		end
	end
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

	add_trunk(pos, height, "default:tree")

	for dy = height - 2, height do
		if dy == height or dy == height - 2 then
			for dx = -2, 2 do
				for dz = -2, 2 do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if math.random() > (abs_dx + abs_dz) / 24 then
						add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz }, "lottplants:whiteleaf")
					end
				end
			end
		end
	end
end

-- Yavannamire / Йаванамирэ

function lottplants_yavannamiretree(pos)
	local height = 4 + math.random(2)

	add_trunk(pos, height, "default:tree")

	for dy = height - 2, height do
		if dy == height or dy == height - 2 then
			for dx = -2, 2 do
				for dz = -2, 2 do
					local abs_dx = math.abs(dx)
					local abs_dz = math.abs(dz)
					if math.random() > (abs_dx + abs_dz) / 24 then
						add_leaf_node(
							{ x = pos.x + dx, y = pos.y + dy + math.random(0, 1), z = pos.z + dz },
							"lottplants:yavannamireleaf"
						)
					end
					if math.random() > (abs_dx + abs_dz) / 12 then
						add_leaf_node(
							{ x = pos.x + dx, y = pos.y + dy + math.random(0,1), z = pos.z + dz },
							"lottplants:yavannamirefruit"
						)
					end
				end
			end
		end
	end
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
	add_trunk_node(pos, "default:jungletree") -- заменяем саженец на ствол
	local height = 5 + math.random(1)
	for dy = height, 0, -1 do
		if (math.sin(dy / height * dy) < 0.2 and dy > 3 and math.random(0, 2) < 1.5) then
			local branch_pos = { x = pos.x + math.random(0, 1), y = pos.y + dy, z = pos.z - math.random(0, 1) }
			add_tree_branch_mirktree(branch_pos)
		end
		if dy < math.random(0, 1) then
			add_trunk_node({ x = pos.x + 1, y = pos.y + dy, z = pos.z + 1 }, "default:jungletree")
			add_trunk_node({ x = pos.x + 2, y = pos.y + dy, z = pos.z - 1 }, "default:jungletree")
			add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z - 2 }, "default:jungletree")
			add_trunk_node({ x = pos.x - 1, y = pos.y + dy, z = pos.z }, "default:jungletree")
		end
		if dy == height then
			add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + dy, z = pos.z + 1 })
			add_tree_branch_mirktree({ x = pos.x + 2, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mirktree({ x = pos.x, y = pos.y + dy, z = pos.z - 2 })
			add_tree_branch_mirktree({ x = pos.x - 1, y = pos.y + dy, z = pos.z })
			add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + dy, z = pos.z + 2 })
			add_tree_branch_mirktree({ x = pos.x + 3, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mirktree({ x = pos.x, y = pos.y + dy, z = pos.z - 3 })
			add_tree_branch_mirktree({ x = pos.x - 2, y = pos.y + dy, z = pos.z })
			add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + dy, z = pos.z })
			add_tree_branch_mirktree({ x = pos.x + 1, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mirktree({ x = pos.x, y = pos.y + dy, z = pos.z - 1 })
			add_tree_branch_mirktree({ x = pos.x, y = pos.y + dy, z = pos.z })
		else
			add_trunk_node({ x = pos.x + 1, y = pos.y + dy, z = pos.z }, "default:jungletree")
			add_trunk_node({ x = pos.x + 1, y = pos.y + dy, z = pos.z - 1 }, "default:jungletree")
			add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z - 1 }, "default:jungletree")
			add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z }, "default:jungletree")
		end
	end
end

--Mirk Small / Малое дерево Лихолесья

function lottplants_smallmirktree(pos)
	add_trunk_node(pos, "default:jungletree") -- заменяем саженец на ствол
	for dy = 0, 7 do
		if dy == 6 then
			for dx = -1, 1 do
				for dz = -1, 1 do
					if math.abs(dx) + math.abs(dz) == 2 then
						add_trunk_node({ x = pos.x + dx, y = pos.y + dy, z = pos.z + dz }, "default:jungletree")
					end
				end
			end
		elseif dy == 7 then
			for dx = -2, 2, 4 do
				for dz = -2, 2, 4 do
					add_trunk_node({ x = pos.x + dx, y = pos.y + dy, z = pos.z + dz }, "default:jungletree")
				end
			end
		else
			add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z }, "default:jungletree")
		end
	end

	local dy = 6
	for dx = -4, 4 do
		for dz = -4, 4 do
			if math.random(20) ~= 10 then
				add_leaf_node({ x = pos.x + dx, y = pos.y + dy + math.random(1, 2), z = pos.z + dz }, "lottplants:mirkleaf")
			end
		end
	end
end
