for i = 1,4 do
	minetest.register_node("icicles:icicle_"..i, {
		description = "Icicle "..i,
		groups = {cracky=3, icicle=1, oddly_breakable_by_hand=4-i, drop_on_dig=1,attached_node=1},
		tiles = {"default_stone.png"},
		is_ground_content = true,
		sounds = default.node_sound_stone_defaults(),
		drop = {
			max_items = 1,
			items = {
				{
					items = {"default:cobble"},
					rarity = 5 - i,
				},
			},
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "wallmounted",
		node_box = {
			type = "fixed",
			fixed = {-i/10, -0.5, -i/10, i/10, 0.5, i/10}
		},
		selection_box = {
			type = "fixed",
			fixed = {-i/10, -0.5, -i/10, i/10, 0.5, i/10}
		},
	})
end

icicles = {}

function icicles.make_stalactite(pos, length)
	for i = length,1,-1 do
		if minetest.env:get_node({x=pos.x,y=pos.y-i+1,z=pos.z}).name == "air" then
			minetest.env:set_node({x=pos.x,y=pos.y-i+1,z=pos.z}, {name = "icicles:icicle_"..5-i})
		else return end
	end
end

function icicles.make_stalagmite(pos, length)
	for i = 1,length do
		if minetest.env:get_node({x=pos.x,y=pos.y+i-1,z=pos.z}).name == "air" then
			minetest.env:set_node({x=pos.x,y=pos.y+i-1,z=pos.z}, {name = "icicles:icicle_"..5-i, param2 = 1})
		else return end
	end
end

local function generate(minp, maxp, seed, chunks_per_volume, icicles_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if icicles_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / icicles_per_chunk)
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max and (y0+2)%16 ~= 0 then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			for x1=0,chunk_size-1 do
				for y1=0,chunk_size-1 do
					for z1=0,chunk_size-1 do
						if pr:next(1,inverse_chance) == 1 then
							local x2 = x0+x1
							local y2 = y0+y1
							local z2 = z0+z1
							local p2 = {x=x2, y=y2, z=z2}
							local p3 = {x=x2, y=y2+1, z=z2}
							local p4 = {x=x2, y=y2-1, z=z2}
							if minetest.env:get_node(p2).name == "air" then
								if minetest.env:get_node(p3).name == "default:stone" then
									icicles.make_stalactite(p2, pr:next(2, 4))
								elseif minetest.env:get_node(p4).name == "default:stone" then
									icicles.make_stalagmite(p2, pr:next(2, 4))
								end
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated(function(minp, maxp, seed)
	generate(minp, maxp, seed, 1/8, 1, -31000, -200)
end)
