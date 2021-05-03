local SL = lord.require_intllib()
if mobs.mod and mobs.mod == "redo" then

local SPRITE_VERSION = false	-- set to true to use upright sprites instead of meshes

-- local variables
	local l_spawn_in		= {"default:water_source", "default:water_flowing", "default:river_water_source", "default:river_water_flowing"}
	local l_spawn_near		= {"default:sand","default:dirt","group:seaplants","group:seacoral"}
	local l_spawn_chance	= 10000
	local l_cc_hand			= 25
	local l_cc_net			= 80
	local l_water_level		= minetest.setting_get("water_level") - 1
	local l_anims = {
		speed_normal = 24,		speed_run = 24,
		stand_start = 1,		stand_end = 80,
		walk_start = 81,		walk_end = 155,
		run_start = 81,			run_end = 155
	}
	local l_visual = "mesh"
	local l_visual_size = {x=.75, y=.75}
	local l_clown_mesh = "animal_clownfish.b3d"
	local l_trop_mesh = "fish_blue_white.b3d"
	local l_clown_textures = {
		{"clownfish.png"},
		{"clownfish2.png"}
	}
	local l_trop_textures = {
		{"fish.png"},
		{"fish2.png"},
		{"fish3.png"}
	}

	if SPRITE_VERSION then
		l_visual = "upright_sprite"
		l_visual_size = {x=.5, y=.5}
		l_clown_mesh = nil
		l_trop_mesh = nil
		l_clown_textures = {{"animal_clownfish_clownfish_item.png"}}
		l_trop_textures = {{"animal_fish_blue_white_fish_blue_white_item.png"}}
	end

-- Clownfish
	mobs:register_mob("mobs_fish:clownfish", {
		type = "animal",
		passive = true,
		hp_min = 1,
		hp_max = 4,
		armor = 100,
		collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
		rotate = 270,
		visual = l_visual,
		mesh = l_clown_mesh,
		textures = l_clown_textures,
		visual_size = l_visual_size,
		makes_footstep_sound = false,
		stepheight = 0.1,
		fly = true,
		fly_in = "default:water_source",
		fall_speed = 0,
		view_range = 8,
		water_damage = 0,
		drops = {
			{name = "lottmobs:fish_raw", chance = 1, min = 1, max = 1},
		},
		lava_damage = 5,
		light_damage = 0,
		animation = l_anims,
		on_rightclick = function(self, clicker)
			mobs:capture_mob(self, clicker, l_cc_hand, l_cc_net, 0, true, nil)
		end
	})
	--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
	--mobs:spawn_specific("mobs_fish:clownfish", l_spawn_in, l_spawn_near, 5, 20, 30, l_spawn_chance, 1, -31000, l_water_level)
	mobs:register_egg("mobs_fish:clownfish", SL("Clownfish"), "animal_clownfish_clownfish_item.png", 0)

-- Tropical fish
	mobs:register_mob("mobs_fish:tropical", {
		type = "animal",
		passive = true,
		hp_min = 1,
		hp_max = 4,
		armor = 100,
		collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
		rotate = 270,
		visual = l_visual,
		mesh = l_trop_mesh,
		textures = l_trop_textures,
		visual_size = l_visual_size,
		makes_footstep_sound = false,
		stepheight = 0.1,
		fly = true,
		fly_in = "default:water_source",
		fall_speed = 0,
		view_range = 8,
		drops = {
			{name = "lottmobs:fish_raw", chance = 1, min = 1, max = 1},
		},
		water_damage = 0,
		lava_damage = 5,
		light_damage = 0,
		animation = l_anims,
		on_rightclick = function(self, clicker)
			mobs:capture_mob(self, clicker, l_cc_hand, l_cc_net, 0, true, nil)
		end
	})
	--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
	--mobs:spawn_specific("mobs_fish:tropical", l_spawn_in, l_spawn_near, 5, 20, 30, l_spawn_chance, 1, -31000, l_water_level)
	mobs:register_egg("mobs_fish:tropical", SL("Tropical fish"), "animal_fish_blue_white_fish_blue_white_item.png", 0)

end
