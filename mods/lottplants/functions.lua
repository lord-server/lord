
-- TREE FUNCTIONS

function add_tree_branch(pos,nodename)
	local n = minetest.get_node(pos)

	--print(n.name)
	if (n.name=="air") then
		minetest.add_node(pos, {name=nodename})
	end

end

function add_tree_trunk(pos,nodename)
	local n = minetest.get_node(pos)

	--print(n.name)
	if (n.name=="air") or (string.find(n.name,"leaf"))  or (string.find(n.name,"sapling")) then
		--print("===========================сработало=================================")
		minetest.add_node(pos, {name=nodename})
	end

end





-- Alders / Ольха

function lottplants_aldertree(pos)
	local t = 6 + math.random(2) -- trunk height
	local r = 3
	--minetest.add_node({x = pos.x, y = pos.y, z = pos.z}, {name = "lottplants:aldertree"}) -- заменяем саженец на ствол
	for j = 0, t do
		add_tree_trunk({x = pos.x, y = pos.y + j, z = pos.z}, "lottplants:aldertree")
	end
	for j = t - 2, t do
		if j == t or j == t - 2 then
			for i = -r, r do
				for k = -r, r do
					local absi = math.abs(i)
					local absk = math.abs(k)
					if (absk == r)and(absi+1 > (r+1)/2)or(absi == r)and(absk+1 > (r+1)/2) then
						-- ничего
					else
						if math.random() > (absi + absk) / 24 then
							--minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:alderleaf"})
							add_tree_branch({x = pos.x + i, y = pos.y + j + math.random(0, 1), z = pos.z + k}, "lottplants:alderleaf")
						end
					end
				end
			end
		end
	end
end

-- Apple tree / Яблоня

function lottplants_appletree(pos)
	local t = 3 + math.random(2) -- trunk height
	local r = 3
	--minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 0, t do
		add_tree_trunk({x = pos.x, y = pos.y + j, z = pos.z}, "default:tree")
	end
	for j = t - 2, t do
		if j == t or j == t - 2 then
			for i = -r, r do
				for k = -r, r do
					local absi = math.abs(i)
					local absk = math.abs(k)
					if (absk == r)and(absi + 1 > (r + 1) / 2)or(absi == r)and(absk + 1 > (r + 1) / 2) then
						-- ничего
					else
						if math.random() > (absi + absk) / 12 then
							--minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="default:apple"})
							add_tree_branch({x = pos.x + i, y = pos.y + j + math.random(0, 1), z = pos.z + k}, "default:apple")
						end
						if math.random() > (absi + absk) / 24 then
							--minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:appleleaf"})
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
	local t = 7 + math.random(5) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="lottplants:birchtree"}) -- заменяем саженец на ствол
	for j = 0, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"lottplants:birchtree")
	end
	--for j = 4, t do
		--if j == math.floor(t * 0.7) or j == t then
			--for i = -2, 2 do
			--for k = -2, 2 do
				--local absi = math.abs(i)
				--local absk = math.abs(k)
				--if math.random() > (absi + absk) / 24 then
					--add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
				--end
			--end
			--end
		--end
	--end
	local j = math.floor(t * 0.4)
	for i = -3, 3 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
		end
	end
	end

	local j = math.floor(t * 0.6)
	for i = -2, 2 do
	for k = -3, 3 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
		end
	end
	end

	local j = math.floor(t * 0.8)
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:birchleaf")
		end
	end
	end

	j = t
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
	local t = 10 + math.random(3) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 0, t do
		--minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:tree")
	end
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		local j
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
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
	local t = 4 + math.random(2) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 0, t do
		--minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:tree")
	end
	for j = t-2, t do
		if j == t or j == t - 2 then
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
	local t = 20 + math.random(5) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 0, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:tree")
	end

	local j = math.floor(t * 0.4)
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:elmleaf")
		end
	end
	end

	local j = math.floor(t * 0.7)
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:elmleaf")
		end
	end
	end

	j = t
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
	local t = 10 + math.random(3) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="lottplants:pinetree"}) -- заменяем саженец на ствол

	for j = 0, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"lottplants:pinetree")
	end

	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		local j
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
		end
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i+1,y=pos.y+j-2,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i-1,y=pos.y+j-2,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-1},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i+1,y=pos.y+j-5,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i-1,y=pos.y+j-5,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+1},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-1},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i+2,y=pos.y+j-8,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i-2,y=pos.y+j-8,z=pos.z+k},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+2},"lottplants:pineleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-2},"lottplants:pineleaf")
		end
	end
	end
end

-- Lebethron

function lottplants_lebethrontree(pos)
	local t = 3 + math.random(1) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="lottplants:lebethrontree"}) -- заменяем саженец на ствол
	for j = 0, t do
		--minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:lebethrontree"})
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"lottplants:lebethrontree")
	end
	for j = 1, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					--minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:lebethronleaf"})
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:lebethronleaf")
				end
			end
			end
		end
	end
end

-- Mallorn

function add_tree_branch_mallorn(pos)
	add_tree_trunk(pos, "lottplants:mallorntree")
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
				add_tree_trunk(p,"lottplants:mallorntree")
				if i == height then
					add_tree_branch_mallorn({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					add_tree_trunk({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1},"lottplants:mallorntree")
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
					add_tree_trunk({x=pos.x+1, y=pos.y+i, z=pos.z+1},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x+2, y=pos.y+i, z=pos.z-1},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x, y=pos.y+i, z=pos.z-2},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x-1, y=pos.y+i, z=pos.z},"lottplants:mallorntree")
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
					add_tree_trunk({x=pos.x+1, y=pos.y+i, z=pos.z},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x+1, y=pos.y+i, z=pos.z-1},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x, y=pos.y+i, z=pos.z-1},"lottplants:mallorntree")
					add_tree_trunk({x=pos.x, y=pos.y+i, z=pos.z},"lottplants:mallorntree")
				end
			end
		end
end

function lottplants_smallmallorntree(pos)
	for j = 0, 15 do
		add_tree_trunk({x=pos.x,y=pos.y+j,z=pos.z},"lottplants:mallorntree")
	end
	for j = 11, 15 do
		if j == 11 or j == 15 then
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
	local t = 6 + math.random(1) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="lottplants:mallorntree_young"}) -- заменяем саженец на ствол
	for j = 0, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"lottplants:mallorntree_young")
	end
	for j = t-2, t do
		if j == t or j == t - 2 then
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

-- Oaks / Дуб

function lottplants_oaktree(pos)
	local t = 10 + math.random(3) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="lottplants:pinetree"}) -- заменяем саженец на ствол
	for j = 0, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"lottplants:pinetree")
	end
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		local j
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
		end
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+3,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i+1,y=pos.y+j-1,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-3,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-4,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},"lottplants:firleaf")
		end
	end
	end
end

-- Pines / Сосна

function lottplants_pinetree(pos)
	local t = 10 + math.random(3) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="lottplants:pinetree"}) -- заменяем саженец на ствол
	for j = 0, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"lottplants:pinetree")
	end
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		local j
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
		end
		if math.random() > (absi + absk) / 24 then
			add_tree_branch({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},"lottplants:firleaf")
			add_tree_branch({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},"lottplants:firleaf")
		end
	end
	end
end

-- Plum Trees / Слива

function lottplants_plumtree(pos)
	local t = 4 + math.random(2) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 1, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:tree")
	end
	for j = t-2, t do
		if j == t or j == t - 2 then
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
	local t = 6 + math.random(2) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 1, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:tree")
	end
	for j = t-4, t do
		if j == t-4 or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				--local absi = math.abs(i)
				--local absk = math.abs(k)
				--if math.random() > (absi + absk) / 12 then
					--add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:rowanleaf")
				--end
				if math.random(3) ~= 2 then
					add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:rowanleaf")
				end
			end
			end
		else
			for i = -3, 3 do
			for k = -3, 3 do
				--local absi = math.abs(i)
				--local absk = math.abs(k)
				--if math.random() > (absi + absk) / 12 then
					--add_tree_branch({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},"lottplants:rowanleaf")
				--end
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
	local t = 4 + math.random(2) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 1, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:tree")
	end
	for j = t-2, t do
		if j == t or j == t - 2 then
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
	local t = 4 + math.random(2) -- trunk height
	minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name="default:tree"}) -- заменяем саженец на ствол
	for j = 1, t do
		add_tree_branch({x=pos.x,y=pos.y+j,z=pos.z},"default:tree")
	end
	for j = t-2, t do
		if j == t or j == t - 2 then
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
	add_tree_trunk(pos, "default:jungletree")
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
    --print(height)
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

-- Alders sapling / Ольха

minetest.register_abm({
    nodenames = {"lottplants:aldersapling"},
    interval = ALDINT,
    chance = ALDCHA,
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
    interval = APPINT,
    chance = APPCHA,
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
    interval = BIRINT,
    chance = BIRCHA,
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
    interval = BEEINT,
    chance = BEECHA,
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
    interval = CULINT,
    chance = CULCHA,
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
    interval = ELMINT,
    chance = ELMCHA,
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
    interval = FIRINT,
    chance = FIRCHA,
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
    interval = LEBINT,
    chance = LEBCHA,
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
    interval = MALINT,
    chance = MALCHA,
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
    interval = PININT,
    chance = PINCHA,
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
    interval = PLUINT,
    chance = PLUCHA,
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
    interval = ROWINT,
    chance = ROWCHA,
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
    interval = WHIINT,
    chance = WHICHA,
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
    interval = YAVINT,
    chance = YAVCHA,
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
    interval = MIRINT,
    chance = MIRCHA,
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
