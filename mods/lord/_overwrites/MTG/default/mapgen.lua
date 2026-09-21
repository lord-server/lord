-- mods/default/mapgen.lua

--
-- Aliases for map generator outputs
--

core.register_alias("mapgen_stone", "default:stone")
core.register_alias("mapgen_tree", "default:tree")
core.register_alias("mapgen_leaves", "default:leaves")
core.register_alias("mapgen_jungletree", "default:jungletree")
-- Временно выпилили в связи с #894 (см. github), где возникла проблема с default:junglesapling
-- В коде присутствует и default:jungleleaves, и lord_trees:mirk_leaf/lottplants:mirkleaf, что создаёт путанницу
-- Принято решение пока что оставить только lord_trees:mirk_leaf
-- Может понадобиться при возможном переходе с дерева из lord_trees на дерево из default
--core.register_alias("mapgen_jungleleaves", "default:jungleleaves")
core.register_alias("mapgen_apple", "default:apple")
core.register_alias("mapgen_water_source", "default:water_source")
core.register_alias("mapgen_river_water_source", "default:river_water_source")
core.register_alias("mapgen_dirt", "default:dirt")
core.register_alias("mapgen_sand", "default:sand")
core.register_alias("mapgen_gravel", "default:gravel")
core.register_alias("mapgen_desert_gravel", "default:desert_gravel")
core.register_alias("mapgen_clay", "default:clay")
core.register_alias("mapgen_lava_source", "default:lava_source")
core.register_alias("mapgen_cobble", "default:cobble")
core.register_alias("mapgen_mossycobble", "default:mossycobble")
core.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
core.register_alias("mapgen_junglegrass", "default:junglegrass")
core.register_alias("mapgen_stone_with_coal", "default:stone_with_coal")
core.register_alias("mapgen_stone_with_iron", "default:stone_with_iron")
core.register_alias("mapgen_mese", "default:mese")
core.register_alias("mapgen_desert_sand", "default:desert_sand")
core.register_alias("mapgen_desert_stone", "default:desert_stone")
core.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")


function default.make_papyrus(pos, size)
	for y=0,size-1 do
		local p = {x=pos.x, y=pos.y+y, z=pos.z}
		local nn = core.get_node(p).name
		if core.registered_nodes[nn] and
			core.registered_nodes[nn].buildable_to then
			core.set_node(p, {name="default:papyrus"})
		else
			return
		end
	end
end

function default.make_cactus(pos, size)
	for y=0,size-1 do
		local p = {x=pos.x, y=pos.y+y, z=pos.z}
		local nn = core.get_node(p).name
		if core.registered_nodes[nn] and
			core.registered_nodes[nn].buildable_to then
			core.set_node(p, {name="default:cactus"})
		else
			return
		end
	end
end

-- facedir: 0/1/2/3 (head node facedir value)
-- length: length of rainbow tail
function default.make_nyancat(pos, facedir, length)
	local tailvec = {x=0, y=0, z=0}
	if facedir == 0 then
		tailvec.z = 1
	elseif facedir == 1 then
		tailvec.x = 1
	elseif facedir == 2 then
		tailvec.z = -1
	elseif facedir == 3 then
		tailvec.x = -1
	else
		--print("default.make_nyancat(): Invalid facedir: "+dump(facedir))
		facedir = 0
		tailvec.z = 1
	end
	local p = {x=pos.x, y=pos.y, z=pos.z}
	core.set_node(p, {name="default:nyancat", param2=facedir})
	for i=1,length do
		p.x = p.x + tailvec.x
		p.z = p.z + tailvec.z
		core.set_node(p, {name="default:nyancat_rainbow", param2=facedir})
	end
end

function generate_nyancats(seed, minp, maxp)
	local y_min = -31000
	local y_max = -32
	if maxp.y < y_min or minp.y > y_max then
		return
	end
	y_min = math.max(minp.y, y_min)
	y_max = math.min(maxp.y, y_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed + 9324342)
	local max_num_nyancats = math.floor(volume / (16*16*16))
	for i=1,max_num_nyancats do
		if pr:next(0, 1000) == 0 then
			local x0 = pr:next(minp.x, maxp.x)
			local y0 = pr:next(minp.y, maxp.y)
			local z0 = pr:next(minp.z, maxp.z)
			local p0 = {x=x0, y=y0, z=z0}
			default.make_nyancat(p0, pr:next(0,3), pr:next(3,15))
		end
	end
end

--- @param x integer
--- @param z integer
--- @return integer|nil ground level (0...15)
local function find_ground_y(x, z)
	for y = 30, 0, -1 do
		if core.get_node({ x = x, y = y, z = z }).name ~= 'air' then
			return y
		end
	end
end

--- Splits the mapchunk into `divlen`x`divlen` cells and for each of them calls `generate_at`
--- for the random positions of the amount defined by the perlin noise.
--- @param minp        Position
--- @param maxp        Position
--- @param seed        integer
--- @param perlin      PerlinNoise
--- @param divlen      integer   cell size
--- @param get_amount  fun(noise:number):number amount of positions in the cell by the noise value
--- @param generate_at fun(pr:PseudoRandom, x:integer, z:integer)
local function generate_by_cells(minp, maxp, seed, perlin, divlen, get_amount, generate_at)
	-- Assume X and Z lengths are equal
	local divs = (maxp.x-minp.x)/divlen+1
	for divx = 0, divs-1 do
		for divz = 0, divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine amount from perlin noise
			local amount = get_amount(perlin:get_2d({ x = x0, y = z0 }))
			-- Find random positions based on this random
			local pr = PseudoRandom(seed+1)
			for _ = 0, amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				generate_at(pr, x, z)
			end
		end
	end
end

local function generate_papyrus(minp, maxp, seed)
	generate_by_cells(minp, maxp, seed, core.get_perlin(354, 3, 0.7, 100), 8,
		function(noise)
			return math.floor(noise * 45 - 20)
		end,
		function(pr, x, z)
			if core.get_node({ x = x, y = 1, z = z }).name == 'default:dirt_with_grass' and
					core.find_node_near({ x = x, y = 1, z = z }, 1, 'default:water_source') then
				default.make_papyrus({ x = x, y = 2, z = z }, pr:next(2, 4))
			end
		end
	)
end

local function generate_cactuses(minp, maxp, seed)
	generate_by_cells(minp, maxp, seed, core.get_perlin(230, 3, 0.6, 100), 16,
		function(noise)
			return math.floor(noise * 6 - 3)
		end,
		function(pr, x, z)
			local ground_y = find_ground_y(x, z)
			-- If desert sand, make cactus
			if ground_y and core.get_node({ x = x, y = ground_y, z = z }).name == 'default:desert_sand' then
				default.make_cactus({ x = x, y = ground_y + 1, z = z }, pr:next(3, 4))
			end
		end
	)
end

local function generate_grass(minp, maxp, seed)
	generate_by_cells(minp, maxp, seed, core.get_perlin(329, 3, 0.6, 100), 16,
		function(noise)
			return math.floor(noise ^ 3 * 9)
		end,
		function(pr, x, z)
			local ground_y = find_ground_y(x, z)
			if not ground_y then
				return
			end

			local p   = { x = x, y = ground_y + 1, z = z }
			local def = core.registered_nodes[core.get_node(p).name]
			-- Check if the node can be replaced
			if not (def and def.buildable_to) then
				return
			end

			local nn = core.get_node({ x = x, y = ground_y, z = z }).name
			if nn == 'default:desert_sand' then
				-- If desert sand, add dry shrub
				core.set_node(p, { name = 'default:dry_shrub' })
			elseif nn == 'default:dirt_with_grass' then
				-- If dirt with grass, add grass
				core.set_node(p, { name = 'default:grass_' .. pr:next(1, 5) })
			end
		end
	)
end

core.register_on_generated(function(minp, maxp, seed)
	if maxp.y >= 2 and minp.y <= 0 then
		generate_papyrus(minp, maxp, seed)
		generate_cactuses(minp, maxp, seed)
		generate_grass(minp, maxp, seed)
	end

	-- Generate nyan cats
	generate_nyancats(seed, minp, maxp)
end)
