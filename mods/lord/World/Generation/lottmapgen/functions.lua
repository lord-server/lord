--Plants

function lottmapgen_grass(data, vi)
	local ids_grasses = {
		minetest.get_content_id("default:grass_1"),
		minetest.get_content_id("default:grass_2"),
		minetest.get_content_id("default:grass_3"),
		minetest.get_content_id("default:grass_4"),
		minetest.get_content_id("default:grass_5"),
	}
	data[vi] = ids_grasses[math.random(#ids_grasses)]
end

function lottmapgen_grass_1_3(data, vi)
	local ids_grasses = {
		minetest.get_content_id("default:grass_1"),
		minetest.get_content_id("default:grass_2"),
		minetest.get_content_id("default:grass_3"),
	}
	data[vi] = ids_grasses[math.random(#ids_grasses)]
end

function lottmapgen_dry_grass(data, vi)
	local ids_grasses = {
		minetest.get_content_id("default:dry_grass_1"),
		minetest.get_content_id("default:dry_grass_2"),
		minetest.get_content_id("default:dry_grass_3"),
		minetest.get_content_id("default:dry_grass_4"),
		minetest.get_content_id("default:dry_grass_5"),
	}
	data[vi] = ids_grasses[math.random(#ids_grasses)]
end

function lottmapgen_lorien_grass(data, vi)
	local ids_lorgrasses = {
		minetest.get_content_id("lottplants:lorien_grass_1"),
		minetest.get_content_id("lottplants:lorien_grass_2"),
		minetest.get_content_id("lottplants:lorien_grass_3"),
		minetest.get_content_id("lottplants:lorien_grass_4"),
	}
	data[vi] = ids_lorgrasses[math.random(#ids_lorgrasses)]
end

function lottmapgen_farmingplants(data, vi)
	local ids_plants = {
		minetest.get_content_id("lottplants:pipeweed_wild"),
		minetest.get_content_id("lottplants:barley_wild"),
		minetest.get_content_id("lottplants:corn_wild"),
		minetest.get_content_id("lottplants:potato_wild"),
		minetest.get_content_id("lottplants:mushroom_wild"),
		minetest.get_content_id("lottplants:berries_wild"),
		minetest.get_content_id("lottplants:turnips_wild"),
		minetest.get_content_id("lottplants:tomatoes_wild"),
		minetest.get_content_id("lottplants:cabbage_wild"),
	}
	data[vi] = ids_plants[math.random(#ids_plants)]
end

function lottmapgen_ithildinplants(data, vi)
	local ids_iplants = {
		minetest.get_content_id("lottplants:asphodel"),
		minetest.get_content_id("lottplants:anemones"),
		minetest.get_content_id("lottplants:eglantive"),
		minetest.get_content_id("lottplants:iris"),
	}
	data[vi] = ids_iplants[math.random(#ids_iplants)]
end

function lottmapgen_lorienplants(data, vi)
	local ids_lplants = {
		minetest.get_content_id("lottplants:elanor"),
		minetest.get_content_id("lottplants:lissuin"),
		minetest.get_content_id("lottplants:niphredil"),
	}
	data[vi] = ids_lplants[math.random(#ids_lplants)]
end


function lottmapgen_papyrus(x, y, z, area, data)
	local id_papyrus = minetest.get_content_id("default:papyrus")
	local ph         = math.random(0, 3)
	for j = 0, ph do
		local vip = area:index(x, y + j, z)
		data[vip] = id_papyrus
	end
end

function lottmapgen_farmingrareplants(data, vi)
	local ids_plants = {
		minetest.get_content_id("lottplants:athelas"),
		minetest.get_content_id("lottplants:melon_wild"),
	}
	data[vi] = ids_plants[math.random(#ids_plants)]
end

function lottmapgen_burnedtree(x, y, z, area, data)
	local id_tree = minetest.get_content_id("default:tree")
	for j = -2, 4 do
	for i = -2, 2 do
		if i == 0 or j == 2 or (j == 3 and math.abs(i) == 2) then
			local vic = area:index(x + i, y + j, z)
			data[vic] = id_tree
		end
	end
	end
end

function lottmapgen_appletree(x, y, z, area, data)
	local id_tree   = minetest.get_content_id("default:tree")
	local id_apple  = minetest.get_content_id("default:apple")
	local id_leaves = minetest.get_content_id("default:leaves")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_apple
				elseif math.random(3) ~= 2 then
					data[vil] = id_leaves
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_plumtree(x, y, z, area, data)
	local id_tree     = minetest.get_content_id("default:tree")
	local id_plum     = minetest.get_content_id("lottplants:plum")
	local id_plumleaf = minetest.get_content_id("lottplants:plumleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_plum
				elseif math.random(3) ~= 2 then
					data[vil] = id_plumleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_rowantree(x, y, z, area, data)
	local id_tree       = minetest.get_content_id("default:tree")
	local id_rowanberry = minetest.get_content_id("lottplants:rowanberry")
	local id_rowanleaf  = minetest.get_content_id("lottplants:rowanleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_rowanberry
				elseif math.random(3) ~= 2 then
					data[vil] = id_rowanleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_culumaldatree(x, y, z, area, data)
	local id_tree          = minetest.get_content_id("default:tree")
	local id_yellowflowers = minetest.get_content_id("lottplants:yellowflowers")
	local id_culumaldaleaf = minetest.get_content_id("lottplants:culumaldaleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_yellowflowers
				elseif math.random(3) ~= 2 then
					data[vil] = id_culumaldaleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_yavannamiretree(x, y, z, area, data)
	local id_tree             = minetest.get_content_id("default:tree")
	local id_yavannamirefruit = minetest.get_content_id("lottplants:yavannamirefruit")
	local id_yavannamireleaf  = minetest.get_content_id("lottplants:yavannamireleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_yavannamirefruit
				elseif math.random(3) ~= 2 then
					data[vil] = id_yavannamireleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_defaulttree(x, y, z, area, data)
	local id_tree   = minetest.get_content_id("default:tree")
	local id_leaves = minetest.get_content_id("default:leaves")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_leaves
				elseif math.random(3) ~= 2 then
					data[vil] = id_leaves
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_aldertree(x, y, z, area, data)
	local id_aldertree = minetest.get_content_id("lottplants:aldertree")
	local id_alderleaf = minetest.get_content_id("lottplants:alderleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_alderleaf
				elseif math.random(3) ~= 2 then
					data[vil] = id_alderleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_aldertree
	end
end

function lottmapgen_lebethrontree(x, y, z, area, data)
	local id_lebethrontree = minetest.get_content_id("lottplants:lebethrontree")
	local id_lebethronleaf = minetest.get_content_id("lottplants:lebethronleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_lebethronleaf
				elseif math.random(3) ~= 2 then
					data[vil] = id_lebethronleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_lebethrontree
	end
end

function lottmapgen_whitetree(x, y, z, area, data)
	local id_tree      = minetest.get_content_id("default:tree")
	local id_whiteleaf = minetest.get_content_id("lottplants:whiteleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = id_whiteleaf
				elseif math.random(3) ~= 2 then
					data[vil] = id_whiteleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_birchtree(x, y, z, area, data)
	local id_birchtree = minetest.get_content_id("lottplants:birchtree")
	local id_birchleaf = minetest.get_content_id("lottplants:birchleaf")
	for j = -5, 12 do
		if j == 8 or j == 11 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = id_birchleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_birchtree
	end
end

function lottmapgen_elmtree(x, y, z, area, data)
	local id_tree    = minetest.get_content_id("default:tree")
	local id_elmleaf = minetest.get_content_id("lottplants:elmleaf")
	for j = -5, 25 do
		if j == 11 or j == 18 or j == 24 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = id_elmleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
end

function lottmapgen_mallornsmalltree(x, y, z, area, data)
	local id_mallorntree = minetest.get_content_id("lottplants:mallorntree")
	local id_mallornleaf = minetest.get_content_id("lottplants:mallornleaf")
	for j = -5, 15 do
		if j == 11 or j == 15 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = id_mallornleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_mallorntree
	end
end

function lottmapgen_young_mallorn(x, y, z, area, data)
	local id_youngmallorn = minetest.get_content_id("lottplants:mallorntree_young")
	local id_mallornleaf  = minetest.get_content_id("lottplants:mallornleaf")
	local t = 6 + math.random(1) -- trunk height
	for j = 0, t do
		if j == t or j == t - 2 then
			for i = -1, 1 do
			for k = -1, 1 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					data[vil] = id_mallornleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_youngmallorn
	end
end

function lottmapgen_jungletree(x, y, z, area, data)
	local id_tree   = minetest.get_content_id("default:jungletree")
	local id_leaves = minetest.get_content_id("lottplants:mirkleaf")
	for j = -3, 7 do
		if j == 6 then
			for i = -4, 4 do
			for k = -4, 4 do
				if math.random(20) ~= 10 then
					local vil = area:index(x + i, y + j + math.random(1, 2), z + k)
					data[vil] = id_leaves
				end
			end
			end
	  for i = -1, 1 do
			for k = -1, 1 do
		  if math.abs(i) + math.abs(k) == 2 then
			local vit = area:index(x + i, y + j, z + k)
			data[vit] = id_tree
		  end
	  end
	  end
		elseif j == 7 then
			for i = -2, 2, 4 do
			for k = -2, 2, 4 do
				local vit = area:index(x + i, y + j, z + k)
				data[vit] = id_tree
			end
			end
		else
			local vit = area:index(x, y + j, z)
			data[vit] = id_tree
		end
	end
end

function lottmapgen_pinetree(x, y, z, area, data)
	local id_pinetree = minetest.get_content_id("lottplants:pinetree")
	local id_pineleaf = minetest.get_content_id("lottplants:pineleaf")
	local id_snow     = minetest.get_content_id("default:snow")
	for j = -4, 13 do
		if j == 3 or j == 6 or j == 9 or j == 12 then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.abs(i) == 2 or math.abs(k) == 2 then
					if math.random(5) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = id_pineleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = id_snow
					end
				end
			end
			end
		elseif j == 4 or j == 7 or j == 10 or j == 13 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = id_pineleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = id_snow
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_pinetree
	end
	local vil = area:index(x, y + 14, z)
	local vila = area:index(x, y + 15, z)
	local vilaa = area:index(x, y + 16, z)
	data[vil] = id_pineleaf
	data[vila] = id_pineleaf
	data[vilaa] = id_snow
end

function lottmapgen_firtree(x, y, z, area, data)
	local id_pinetree = minetest.get_content_id("lottplants:pinetree")
	local id_firleaf  = minetest.get_content_id("lottplants:firleaf")
	local id_snow     = minetest.get_content_id("default:snow")
	for j = -4, 13 do
		if j == 3 or j == 6 or j == 9 or j == 12 then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.abs(i) == 2 or math.abs(k) == 2 then
					if math.random(5) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = id_firleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = id_snow
					end
				end
			end
			end
		elseif j == 4 or j == 7 or j == 10 or j == 13 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = id_firleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = id_snow
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_pinetree
	end
	local vil = area:index(x, y + 14, z)
	local vila = area:index(x, y + 15, z)
	local vilaa = area:index(x, y + 16, z)
	data[vil] = id_firleaf
	data[vila] = id_firleaf
	data[vilaa] = id_snow
end



function lottmapgen_oaktree(x, y, z, area, data)
	local id_tree   = minetest.get_content_id("default:tree")
	local id_leaves = minetest.get_content_id("default:leaves")
	for j = -4, 13 do
		if j == 3 or j == 6 or j == 9 or j == 12 then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.abs(i) == 2 or math.abs(k) == 2 then
					if math.random(5) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = id_leaves
					end
				end
			end
			end
		elseif j == 4 or j == 7 or j == 10 or j == 13 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = id_leaves
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = id_tree
	end
	local vil = area:index(x, y + 14, z)
	local vila = area:index(x, y + 15, z)
	data[vil] = id_leaves
	data[vila] = id_leaves
end

-- Trees Big

function lottmapgen_mallorntree(pos)
	local height = 25 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.add_node(p, {name="lottplants:mallorntree"})
				if i == height then
					add_tree_branch_mallorn({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="lottplants:mallorntree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
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
					minetest.add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					minetest.add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
				end
			end
		end
end

-- бук
function lottmapgen_beechtree(pos)
	local t = 10 + math.random(3) -- trunk height
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
			minetest.add_node({x=pos.x+i,y=pos.y+j+7,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+2,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-2,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k+2},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k-2},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+3,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-3,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k+3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k-3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+3,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-3,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+4,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-4,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+4},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-4},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+4,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-4,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+4},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-4},{name="lottplants:beechleaf"})
		end
	end
	end
	for j = -3, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

function lottmapgen_mirktree(pos)
	local height = 5 + math.random(1)
		if height < 1 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.add_node(p, {name="default:jungletree"})
				if i == height then
					add_tree_branch_mirktree({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
					minetest.add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="default:jungletree"})
					minetest.add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
					minetest.add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="default:jungletree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="default:jungletree"})
					minetest.add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					minetest.add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="default:jungletree"})
					minetest.add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
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
					minetest.add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
					minetest.add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					minetest.add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					minetest.add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
				end
			end
		end
end

minetest.register_node("lottmapgen:mallorngen", {
	tiles = {"lottmapgen_lorien_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_lorien_grass_side.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottmapgen:beechgen", {
	tiles = {"default_snow.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottmapgen:mirktreegen", {
	tiles = {"lottmapgen_mirkwood_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_mirkwood_grass_side.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm({
	nodenames = {"lottmapgen:mallorngen"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		  lottmapgen_mallorntree(pos)
	 end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:mirktreegen"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		  lottmapgen_mirktree(pos)
	 end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:beechgen"},
		interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		lottmapgen_beechtree(pos)
	end,
})
