local SL = lord.require_intllib()

local cube_sizes = {-1, -0.5, -0, 0.5}

local sizes = {-0.4375, -0.3125, -0.1875, -0.0625, 0.0625, 0.1875, 0.3125}

for i, size in ipairs(sizes) do
	local slice_h = i - 1
	local slice_b = i - 1
	local name_h
	local name_b
	local description_h
	local description_b
	local drop_h
	local drop_b
	local tiles_h
	local tiles_b
	
	if slice_h == 0 then
		name_h = "lottfarming:cake_honey"
		description_h = SL("Honey Cake")
		drop_h = nil
		tiles_h = {"lottfarming_cake_top.png", "lottfarming_cake_bottom.png", "lottfarming_hcake_side.png"}
	else
		name_h = "lottfarming:cake_honey_"..slice_h
		drop_h = ''
		tiles_h = {"lottfarming_cake_top.png", "lottfarming_cake_bottom.png", "lottfarming_hcake_side.png", "lottfarming_hcake_inner.png", "lottfarming_hcake_side.png", "lottfarming_hcake_side.png"}
	end

	if slice_b == 0 then
		name_b = "lottfarming:cake_berries"
		description_b = SL("Berry Cake")
		drop_b = nil
		tiles_b = {"lottfarming_cake_top.png", "lottfarming_cake_bottom.png", "lottfarming_bcake_side.png"}
	else
		name_b = "lottfarming:cake_berries_"..slice_b
		drop_b = ''
		tiles_b = {"lottfarming_cake_top.png", "lottfarming_cake_bottom.png", "lottfarming_bcake_side.png", "lottfarming_bcake_inner.png", "lottfarming_bcake_side.png", "lottfarming_bcake_side.png"}

	end
	
	minetest.register_node(name_h, {
		description = description_h,
		drop = drop_h,
		drawtype = "nodebox",
		tiles = tiles_h,
		paramtype = "light",
		is_ground_content = false,
		groups = {crumbly=3},
		--sounds = sounds,
		stack_max = 1,
		node_box = {
			type = "fixed",
			fixed = {
				{size, -0.5, -0.4375, 0.4375, 0, 0.4375},
			},
		},
		on_rightclick = function(pos, node, clicker, player)
			if minetest.is_protected(pos, player:get_player_name()) then
				else
					clicker:set_hp(clicker:get_hp() + 1)
			
					if i < #sizes then
						minetest.swap_node(pos, {name="lottfarming:cake_honey_"..i})
					else
						minetest.remove_node(pos)
					end
				end
			end
	})

	minetest.register_node(name_b, {
		description = description_b,
		drop = drop_b,
		drawtype = "nodebox",
		tiles = tiles_b,
		paramtype = "light",
		is_ground_content = false,
		groups = {crumbly=3},
		--sounds = sounds,
		stack_max = 1,
		node_box = {
			type = "fixed",
			fixed = {
				{size, -0.5, -0.4375, 0.4375, 0, 0.4375},
			}
		},
		on_rightclick = function(pos, node, clicker, player)
			if minetest.is_protected(pos, player:get_player_name()) then
				else
					clicker:set_hp(clicker:get_hp() + 1)
			
					if i < #sizes then
						minetest.swap_node(pos, {name="lottfarming:cake_berries_"..i})
					else
						minetest.remove_node(pos)
					end
				end
			end
	})
	
	minetest.register_craft({
		output = "lottfarming:cake_honey",
		recipe = {
			{"lottfarming:sugar"},
			{"bees:bottle_honey"},
			{"lottfarming:biscuit"},
		},
		replacements = {{"bees:bottle_honey", "vessels:glass_bottle"}},
	})

	minetest.register_craft({
		output = "lottfarming:cake_berries",
		recipe = {
			{"lottfarming:sugar"},
			{"lottfarming:berries"},
			{"lottfarming:biscuit"},
		}
	})
end

for i, size in ipairs(cube_sizes) do
	local slice_mel = i - 1
	local slice_cabb = i - 1
	local name_mel
	local name_cabb
	local description_mel
	local description_cabb
	local drop_mel
	local drop_cabb
	local tiles_mel
	local tiles_cabb

	if slice_mel == 0 then
		name_mel = "lottfarming:melon_3"
		description_mel = SL("Melon")
		drop_mel = "lottfarming:melon"
		tiles_mel = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png"}
	else
		name_mel = "lottfarming:melon_3_"..slice_mel
		drop_mel = "lottfarming:melon_3_"..slice_mel
		tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_inner.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"}
	end

	if slice_cabb == 0 then
		name_cabb = "lottfarming:cabbage"
		description_cabb = SL("Cabbage")
		drop_cabb = "lottfarming:cabbage"
		tiles_cabb = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png"}
	else
		name_cabb = "lottfarming:cabbage_"..slice_cabb
		drop_cabb = "lottfarming:cabbage_"..slice_cabb
		tiles_cabb = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_inner.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"}

	end
	
	minetest.register_node(name_mel, {
		description = description_mel,
		drop = drop_mel,
		drawtype = "nodebox",
		tiles = tiles_mel,
		paramtype = "light",
		is_ground_content = false,
		groups = {crumbly=3},
		--sounds = sounds,
		stack_max = 64,
		on_rightclick = function(pos, node, clicker, player)
			if minetest.is_protected(pos, player:get_player_name()) then
				else
					clicker:set_hp(clicker:get_hp() + 1)
			
					if i < #cube_sizes then
						minetest.swap_node(pos, {name="lottfarming:melon_3_"..i})
					else
						minetest.remove_node(pos)
					end
				end
			end
	})
end