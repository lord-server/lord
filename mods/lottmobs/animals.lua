local SL = lord.require_intllib()

mobs:register_arrow("lottmobs:egg_entity", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"lottmobs_egg.png"},
	velocity = 9,

	hit_player = function(self, player)
		player:punch(minetest.get_player_by_name(self.playername) or self.object, 1.0, {
			full_punch_interval = 0.7,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(minetest.get_player_by_name(self.playername) or self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_node = function(self, pos, node)
		if math.random(1, 10) > 1 then
			return
		end

		pos.y = pos.y + 1

		local node = minetest.get_node_or_nil(pos)
		if not node then
			return
		end

		local node_def = minetest.registered_nodes[node.name]

		if not node_def or node_def.walkable then
			return
		end

		minetest.add_entity(pos, "lottmobs:chicken")
	end
})


-- egg throwing item

local EGG_GRAVITY = 9
local EGG_VELOCITY = 19

local mobs_shoot_egg = function(item, player, pointed_thing)
	local playerpos = player:getpos()

	minetest.sound_play("default_place_node_hard", {
		pos = playerpos,
		gain = 1.0,
		max_hear_distance = 5,
	})

	local obj = minetest.add_entity({
		x = playerpos.x,
		y = playerpos.y + 1.5,
		z = playerpos.z
	}, "lottmobs:egg_entity")

	local ent = obj:get_luaentity()
	local dir = player:get_look_dir()

	ent.velocity = EGG_VELOCITY -- needed for api internal timing
	ent.switch = 1 -- needed so that egg doesn't despawn straight away

	obj:setvelocity({
		x = dir.x * EGG_VELOCITY,
		y = dir.y * EGG_VELOCITY,
		z = dir.z * EGG_VELOCITY
	})

	obj:setacceleration({
		x = dir.x * -3,
		y = -EGG_GRAVITY,
		z = dir.z * -3
	})

	-- pass player name to egg for chick ownership
	local ent2 = obj:get_luaentity()
	ent2.playername = player:get_player_name()

	item:take_item()

	return item
end

minetest.register_node("lottmobs:egg", {
	description = SL("Chicken Egg"),
	tiles = {"lottmobs_egg.png"},
	inventory_image  = "lottmobs_egg.png",
	visual_scale = 0.7,
	drawtype = "plantlike",
	wield_image = "lottmobs_egg.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {snappy = 2, dig_immediate = 3},
	on_use = mobs_shoot_egg
})

mobs:register_mob("lottmobs:chicken", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.3,0,-0.3, 0.3,0.8,0.3},
	textures = {
		{"lottmobs_chicken.png"},
	},
	sounds = {
		random = "mobs_chicken",
	},
	visual = "mesh",
	mesh = "chicken_model.x",
	visual_size = {x=1.5, y=1.5, z=1.5,},
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 300,
		drops = {
		{name = "lottmobs:chicken_raw",
		chance = 1,
		min = 0,
		max = 1,},
		{name = "lottmobs:egg",
		chance = 1,
		min = 0,
		max = 1,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	animation = {
		speed_normal = 10,
		speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		sit_start = 1,
		sit_end = 9,
		walk_start = 10,
		walk_end = 50,
	},
	follow = {"farming:wheat0", "lottother:beast_ring"},
	view_range = 5,
	jump = true,
	step=1,
	passive = true,
	
	sounds = {
	},
})

--[[mobs:register_mob("lottmobs:sheep", {
	type = "animal",
	passive = true,
	hp_min = 8,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.5, -1, -0.5, 0.5, 0.3, 0.5},
	visual = "mesh",
	mesh = "mobs_sheep.b3d",
	textures = {
		{"mobs_sheep_base.png^mobs_sheep_wool.png"}, --White
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#663300a0)"}, --Black
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#000000b0)"}, --Brown
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#5b5b5bb0)"}, --Grey
	},
	gotten_texture = {"mobs_sheep_shaved.png"},
	gotten_mesh = "mobs_sheep_shaved.b3d",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	drops = {
		{name = "lottmobs:meat_raw", chance = 1, min = 1, max = 2},
		{name = "wool:white", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 81,
		walk_end = 100,
	},
	follow = {"farming:wheat", "default:grass_5"},
	view_range = 8,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "air",
	replace_offset = -1,
	fear_height = 3,

	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then
			if self.gotten == false then
				self.object:set_properties({
					textures = {"mobs_sheep_base.png^mobs_sheep_wool.png"},
					mesh = "mobs_sheep.b3d",
				})
			end
			return
		end

		local item = clicker:get_wielded_item()
		local itemname = item:get_name()

		if itemname == "mobs:shears" then
			if self.gotten ~= false
			or self.child ~= false
			or not minetest.get_modpath("wool") then
				return
			end
			self.gotten = true -- shaved
			local obj = minetest.add_item(
				self.object:getpos(),
				ItemStack( "wool:" .. col[1] .. " " .. math.random(1, 3) )
			)
			if obj then
				obj:setvelocity({
					x = math.random(-1, 1),
					y = 5,
					z = math.random(-1, 1)
				})
			end
			item:add_wear(650) -- 100 uses
			clicker:set_wielded_item(item)
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.b3d",
			})
			return
		end
	end
})]]--

--[[mobs:register_spawn("lottmobs:sheep",
    {"lottmapgen:shire_grass", "lottmapgen:gondor_grass", "lottmapgen:dunland_grass",
	"lottmapgen:ithilien_grass"},
    20, 10, 10000, 1, 31000)]]--

mobs:register_mob("lottmobs:bunny", {
	type = "animal",
	passive = true,
	reach = 1,
	hp_min = 1,
	hp_max = 4,
	armor = 200,
	collisionbox = {-0.268, -0.5, -0.268,  0.268, 0.167, 0.268},
	visual = "mesh",
	mesh = "mobs_bunny.b3d",
	drawtype = "front",
	textures = {
		{"mobs_bunny_grey.png"},
		{"mobs_bunny_brown.png"},
		{"mobs_bunny_white.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	drops = {
		{name = "lottmobs:rabbit_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 15,
		stand_start = 1,
		stand_end = 15,
		walk_start = 16,
		walk_end = 24,
		punch_start = 16,
		punch_end = 24,
	},
	follow = {"lottfarming:carrot_item", "lottother:beast_ring"},
	view_range = 8,
	replace_rate = 1,
	replace_what = { {"lottfarming:carrot", "air", 0}, {"lottfarming:cabbage_1", "air", 0}}
})

--[[mobs:register_mob("lottmobs:rat", {
	type = "animal",
	passive = true,
	hp_min = 1,
	hp_max = 4,
	armor = 200,
	collisionbox = {-0.2, -1, -0.2, 0.2, -0.8, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.b3d",
	textures = {
		{"mobs_rat.png"},
		{"mobs_rat2.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_rat",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
})
mobs:register_spawn("lottmobs:rat", {"default:stone"}, 20, 5, 15000, 2, 0)]]--
