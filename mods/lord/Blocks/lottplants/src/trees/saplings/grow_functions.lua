-- TREE FUNCTIONS

function add_tree_branch(pos,nodename)
	local n = minetest.get_node(pos)
	if (n.name=="air") then
		minetest.add_node(pos, {name=nodename})
	end
end

--- @param pos       Position
--- @param node_name string
local function add_trunk_node(pos, node_name)
	local n = minetest.get_node(pos)
	if (n.name=="air") or (string.find(n.name,"leaf")) or (string.find(n.name,"sapling")) then
		minetest.add_node(pos, {name= node_name })
	end
end

--- @param pos       Position
--- @param height    number
--- @param node_name string
local function add_trunk(pos, height, node_name)
	for dy = 0, height do
		add_trunk_node({ x = pos.x, y = pos.y + dy, z = pos.z}, node_name)
	end
end

-- Alders / Ольха

function lottplants_aldertree(pos)
	local height = 6 + math.random(2)
	local r      = 3

	add_trunk(pos, height, "lottplants:aldertree")

	for j = height - 2, height do
		if j == height or j == height - 2 then
			for i = -r, r do
				for k = -r, r do
					local absi = math.abs(i)
					local absk = math.abs(k)
					if not (
						(absk == r) and (absi + 1 > (r + 1) / 2)
						or
						(absi == r) and (absk + 1 > (r + 1) / 2)
					) then
						if math.random() > (absi + absk) / 24 then
							add_tree_branch({ x = pos.x + i, y = pos.y + j + math.random(0, 1), z = pos.z + k }, "lottplants:alderleaf")
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
	local r      = 3

	add_trunk(pos, height, "default:tree")

	for j = height - 2, height do
		if j == height or j == height - 2 then
			for i = -r, r do
				for k = -r, r do
					local absi = math.abs(i)
					local absk = math.abs(k)
					if not (
						(absk == r) and (absi + 1 > (r + 1) / 2)
						or
						(absi == r) and (absk + 1 > (r + 1) / 2)
					) then
						if math.random() > (absi + absk) / 12 then
							add_tree_branch({x = pos.x + i, y = pos.y + j + math.random(0, 1), z = pos.z + k}, "default:apple")
						end
						if math.random() > (absi + absk) / 24 then
							add_tree_branch({x = pos.x + i, y = pos.y + j + math.random(0, 1), z = pos.z + k}, "lottplants:appleleaf")
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

	local j
	j = math.floor(height * 0.4)
	for i = -3, 3 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
		end
	end
	end

	j = math.floor(height * 0.6)
	for i = -2, 2 do
	for k = -3, 3 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
		end
	end
	end

	j = math.floor(height * 0.8)
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
		end
	end
	end

	j = height
	for i = -2, 2 do
	for k = -1, 1 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
		end
	end
	end

end

-- Beeches / Бук

function lottplants_beechtree(pos)
	local height = 10 + math.random(3)

	add_trunk(pos, height, "default:tree")

	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		local j
		if absi >= absk then
			j = height - absi
		else
			j = height - absk
		end
		if math.random() > (absi + absk) / 24 then
		    add_tree_branch({x=pos.x+i,y=pos.y+j+7,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j+4,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i+2,y=pos.y+j+4,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i+2,y=pos.y+j+4,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j+4,z=pos.z+k+2},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j+4,z=pos.z+k-2},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i+3,y=pos.y+j+1,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i-3,y=pos.y+j+1,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k+3},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k-3},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i+3,y=pos.y+j-2,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i-3,y=pos.y+j-2,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+3},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-3},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i+4,y=pos.y+j-5,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i-4,y=pos.y+j-5,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+4},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-4},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i+4,y=pos.y+j-8,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i-4,y=pos.y+j-8,z=pos.z+k},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+4},"lottplants:beechleaf")
		    add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-4},"lottplants:beechleaf")
		end
	end
	end
end

-- Culumalda

function lottplants_culumaldatree(pos)
	local height = 4 + math.random(2)

	add_trunk(pos, height, "default:tree")

	for j = height -2, height do
		if j == height or j == height - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:culumaldaleaf")
				end
				if math.random() > (absi + absk) / 12 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:yellowflowers")
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

	local j
	j = math.floor(height * 0.4)
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:elmleaf")
		end
	end
	end

	j = math.floor(height * 0.7)
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:elmleaf")
		end
	end
	end

	j = height
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:elmleaf")
		end
	end
	end

end

-- Firs / Ель

function lottplants_firtree(pos)
	local height = 10 + math.random(3)

	add_trunk(pos, height, "lottplants:firtree")

	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		local j
		if absi >= absk then
			j = height - absi
		else
			j = height - absk
		end
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i+1,y=pos.y+j-2,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i-1,y=pos.y+j-2,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-1},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i+1,y=pos.y+j-5,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i-1,y=pos.y+j-5,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+1},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-1},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i+2,y=pos.y+j-8,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i-2,y=pos.y+j-8,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+2},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-2},"lottplants:firleaf")
		end
	end
	end
end

-- Lebethron

function lottplants_lebethrontree(pos)
	local height = 3 + math.random(1)

	add_trunk(pos, height, "lottplants:lebethrontree")

	for j = 1, height do
		if j == math.floor(height * 0.7) or j == height then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:lebethronleaf")
				end
			end
			end
		end
	end
end

-- Mallorn

function add_tree_branch_mallorn(pos)
	add_trunk_node(pos, "lottplants:mallorntree")
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			add_tree_branch(p,"lottplants:mallornleaf")
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				add_tree_branch(p,"lottplants:mallornleaf")
			end
		end
	end
end

function lottplants_mallorntree(pos)
    local height = 25 + math.random(5)
	minetest.add_node(pos,{name="lottplants:mallorntree"}) -- заменяем саженец на ствол
		if height < 10 then
			for i = height, 0, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				add_trunk_node(p,"lottplants:mallorntree")
				if i == height then
					add_tree_branch_mallorn({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					add_trunk_node({ x =pos.x+1, y =pos.y+i-math.random(2), z =pos.z},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x, y =pos.y+i-math.random(2), z =pos.z+1},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x-1, y =pos.y+i-math.random(2), z =pos.z},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x, y =pos.y+i-math.random(2), z =pos.z-1},"lottplants:mallorntree")
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
			end
		else
			for i = height, 0, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
				if i < math.random(0,1) then
					add_trunk_node({ x =pos.x+1, y =pos.y+i, z =pos.z+1},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x+2, y =pos.y+i, z =pos.z-1},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x, y =pos.y+i, z =pos.z-2},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x-1, y =pos.y+i, z =pos.z},"lottplants:mallorntree")
				end
				if i == height then
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_mallorn({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_mallorn({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z})
				else
					add_trunk_node({ x =pos.x+1, y =pos.y+i, z =pos.z},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x+1, y =pos.y+i, z =pos.z-1},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x, y =pos.y+i, z =pos.z-1},"lottplants:mallorntree")
					add_trunk_node({ x =pos.x, y =pos.y+i, z =pos.z},"lottplants:mallorntree")
				end
			end
		end
end

function lottplants_smallmallorntree(pos)
	local height = 15

	add_trunk(pos, height, "lottplants:mallorntree")

	for j = 11, height do
		if j == 11 or j == height then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:mallornleaf")
				end
			end
			end
		end
	end
end

function lottplants_young_mallorn(pos)
	local height = 6 + math.random(1)

	add_trunk(pos, height, "lottplants:mallorntree_young")

	for j = height -2, height do
		if j == height or j == height - 2 then
			for i = -1, 1 do
			for k = -1, 1 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:mallornleaf")
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

	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		local j
		if absi >= absk then
			j = height - absi
		else
			j = height - absk
		end
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},"lottplants:pineleaf")
		end
	end
	end
end

-- Plum Trees / Слива

function lottplants_plumtree(pos)
	local height = 4 + math.random(2)

	add_trunk(pos, height, "default:tree")

	for j = height -2, height do
		if j == height or j == height - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:plumleaf")
				end
				if math.random() > (absi + absk) / 12 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:plum")
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

	for j = height -4, height do
		if j == height -4 or j == height then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.random(3) ~= 2 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:rowanleaf")
				end
			end
			end
		else
			for i = -3, 3 do
			for k = -3, 3 do
				if math.random(8) == 8 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:rowanberry")
				elseif math.random(2) ~= 2 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:rowanleaf")
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

	for j = height -2, height do
		if j == height or j == height - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:whiteleaf")
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

	for j = height -2, height do
		if j == height or j == height - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:yavannamireleaf")
				end
				if math.random() > (absi + absk) / 12 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:yavannamirefruit")
				end
			end
			end
		end
	end
end

--Mirk large / Большое дерево Лихолесья

function add_tree_branch_mirktree(pos)
	add_trunk_node(pos, "default:jungletree")
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.get_node(p)
			if (n.name=="air") then
				minetest.add_node(p, {name="lottplants:mirkleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.get_node(p)
				if (n.name=="air") then
					minetest.add_node(p, {name="lottplants:mirkleaf"})
				end
			end
		end
	end
end

function lottplants_mirktree(pos)
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:jungletree"}) -- заменяем саженец на ствол
    local height = 5 + math.random(1)
		if height < 1 then
			for i = height, 0, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				add_tree_branch(p,"default:jungletree")
				if i == height then
					add_tree_branch_mirktree({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					add_tree_branch({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z},"default:jungletree")
					add_tree_branch({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1},"default:jungletree")
					add_tree_branch({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z},"default:jungletree")
					add_tree_branch({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1},"default:jungletree")
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
			end
		else
			for i = height, 0, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
				if i < math.random(0,1) then
					add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z+1},"default:jungletree")
					add_tree_branch({x=pos.x+2, y=pos.y+i, z=pos.z-1},"default:jungletree")
					add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-2},"default:jungletree")
					add_tree_branch({x=pos.x-1, y=pos.y+i, z=pos.z},"default:jungletree")
				end
				if i == height then
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_mirktree({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_mirktree({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_mirktree({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_mirktree({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z})
				else
					add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z},"default:jungletree")
					add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z-1},"default:jungletree")
					add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-1},"default:jungletree")
					add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z},"default:jungletree")
				end
			end
		end
end

--Mirk Small / Малое дерево Лихолесья

function lottplants_smallmirktree(pos)
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:jungletree"}) -- заменяем саженец на ствол
	for j = 0, 7 do
		if j == 6 then

			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) == 2 then
					add_tree_branch({x=pos.x+i,y=pos.y+j,z=pos.z+k},"default:jungletree")
				end
			end
			end
		elseif j == 7 then
			for i = -2, 2, 4 do
			for k = -2, 2, 4 do
				add_tree_branch({x=pos.x+i,y=pos.y+j,z=pos.z+k},"default:jungletree")
			end
			end
		else
			add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:jungletree")
		end
	end

	local j=6
	for i = -4, 4 do
	for k = -4, 4 do
		if math.random(20) ~= 10 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(1, 2),z=pos.z+k},"lottplants:mirkleaf")
		end
	end
	end
end



-- SAPLINGS
-- ===== GROWING TIME =====
local SAPLING_GROW_ABM_INTERVAL = 67
local SAPLING_GROW_ABM_CHANCE   = 11
-- Alders sapling / Ольха

minetest.register_abm({
    nodenames = {"lottplants:aldersapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_aldertree(pos)
		print ("[lottplants] Alder Grows")
    end,
})

-- Apple Tree sapling / Яблоня

minetest.register_abm({
    nodenames = {"lottplants:applesapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_appletree(pos)
		print ("[lottplants] Apple Tree Grows")
    end,
})

-- Birch sapling / Береза

minetest.register_abm({
    nodenames = {"lottplants:birchsapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_birchtree(pos)
		print ("[lottplants] Birch Grows")
    end,
})

-- Beech sapling / Бук

minetest.register_abm({
    nodenames = {"lottplants:beechsapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_beechtree(pos)
		print ("[lottplants] Beech Grows")
    end,
})

-- Culumalda sapling / Кулумальда

minetest.register_abm({
    nodenames = {"lottplants:culumaldasapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_culumaldatree(pos)
		print ("[lottplants] Culumalda Grows")
    end,
})

-- Elm sapling / Вяз

minetest.register_abm({
    nodenames = {"lottplants:elmsapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_elmtree(pos)
		print ("[lottplants] Elm Grows")
    end,
})

-- Fir sapling / Ель

minetest.register_abm({
    nodenames = {"lottplants:firsapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_firtree(pos)
		print ("[lottplants] Fir Grows")
    end,
})

-- Lebethron sapling / Лебетрон

minetest.register_abm({
    nodenames = {"lottplants:lebethronsapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_lebethrontree(pos)
		print ("[lottplants] Lebethron Grows")
    end,
})

-- Mallorn sapling / Маллорн

minetest.register_abm({
    nodenames = {"lottplants:mallornsapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		if math.random(3) == 1 then
			lottplants_mallorntree(pos)
		elseif math.random(3) == 2 then
			lottplants_smallmallorntree(pos)
		else
			lottplants_young_mallorn(pos)
		end
		print ("[lottplants] Mallorn Grows")
    end,
})

-- Pine sapling / Сосна

minetest.register_abm({
    nodenames = {"lottplants:pinesapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_pinetree(pos)
		print ("[lottplants] Pine Grows")
    end,
})

-- Plum sapling / Слива

minetest.register_abm({
    nodenames = {"lottplants:plumsapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_plumtree(pos)
		print ("[lottplants] Plum Tree Grows")
    end,
})

-- Rowan sapling / Рябина

minetest.register_abm({
    nodenames = {"lottplants:rowansapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_rowantree(pos)
		print ("[lottplants] Rowan Grows")
    end,
})

-- White Tree / Белое дерево

minetest.register_abm({
    nodenames = {"lottplants:whitesapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_whitetree(pos)
		print ("[lottplants] The White Tree of Minetest Grows")
    end,
})

-- Yavannamire Tree / Йаванамирэ

minetest.register_abm({
    nodenames = {"lottplants:yavannamiresapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		lottplants_yavannamiretree(pos)
		print ("[lottplants] Yavannamire Grows")
    end,
})

--Mirk Tree / Дерево Лихолесья

minetest.register_abm({
    nodenames = {"lottplants:mirksapling"},
    interval = SAPLING_GROW_ABM_INTERVAL,
    chance = SAPLING_GROW_ABM_CHANCE,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if not default.can_grow(pos) then
			return
		end

		if math.random(2) == 1 then
			lottplants_mirktree(pos)
		else
			lottplants_smallmirktree(pos)
		end
		print ("[lottplants] Mirk Tree Grows")
    end,
})
