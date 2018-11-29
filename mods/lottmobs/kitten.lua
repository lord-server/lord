
local S = mobs.intllib
local hairball = minetest.settings:get("mobs_hairball")

-- Kitten by Jordach / BFD

mobs:register_mob("lottmobs:kitten", {
stepheight = 0.6,
	type = "animal",
	specific_attack = {"lottmobs:rat"},
	damage = 1,
	attack_type = "dogfight",
	attack_animals = true, -- so it can attack rat
	attack_players = false,
	reach = 1,
	passive = false,
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "mobs_kitten.b3d",
	textures = {
		{"mobs_kitten_striped.png"},
		{"mobs_kitten_splotchy.png"},
		{"mobs_kitten_ginger.png"},
		{"mobs_kitten_sandy.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_kitten",
	},
	walk_velocity = 0.6,
	walk_chance = 15,
	run_velocity = 2,
	runaway = true,
	jump = false,
	drops = {
		{name = "farming:string", chance = 1, min = 0, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	fear_height = 3,
	animation = {
		speed_normal = 42,
		stand_start = 97,
		stand_end = 192,
		walk_start = 0,
		walk_end = 96,
		stoodup_start = 0,
		stoodup_end = 0,
	},
	follow = {"lottmobs:rat", "ethereal:fish_raw", "mobs_fish:clownfish", "mobs_fish:tropical"},
	view_range = 8,

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 50, 50, 90, false, nil) then return end

		-- by right-clicking owner can pet the cat
		if self.owner and self.owner == clicker:get_player_name() then
			self.object:set_velocity({x = 0, y = 0, z = 0})
			minetest.sound_play("mobs_kitten", {
				pos = pos,
				gain = 1.0,
				max_hear_distance = 5,
		})


		end
	end,

	do_custom = function(self, dtime)

		if hairball == "false" then
			return
		end

		self.hairball_timer = (self.hairball_timer or 0) + dtime
		if self.hairball_timer < 10 then
			return
		end
		self.hairball_timer = 0

		if self.child
		or math.random(1, 250) > 1 then
			return
		end

		local pos = self.object:get_pos()

		minetest.add_item(pos, "lottmobs:hairball")

		minetest.sound_play("default_dig_snappy", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
	end,
})



if minetest.get_modpath("ethereal") then
	spawn_on = "ethereal:grove_dirt"
end

mobs:spawn({
	name = "lottmobs:kitten",
	nodes = {"lottmapgen:dunland_grass"},
	neighbors = {"group:grass"},
	min_light = 14,
	interval = 6,
	chance = 10000, -- 22000
	min_height = -5,
	max_height = 150,
	day_toggle = true,
})

mobs:spawn({
	name = "lottmobs:kitten",
	nodes = {"lottmapgen:gondor_grass"},
	neighbors = {"group:grass"},
	min_light = 14,
	interval = 6,
	chance = 10000, -- 22000
	min_height = -5,
	max_height = 150,
	day_toggle = true,
})


mobs:register_egg("lottmobs:kitten", S("Kitten"), "mobs_kitten_inv.png", 0)


local hairball_items = {
	"default:stick", "default:coal_lump", "default:dry_shrub", "flowers:rose",
	"mobs:rat", "default:grass_1", "farming:seed_wheat", "dye:green", "",
	"farming:seed_cotton", "default:flint", "default:sapling", "dye:white", "",
	"default:clay_lump", "default:paper", "default:dry_grass_1", "dye:red", "",
	"farming:string", "mobs:chicken_feather", "default:acacia_bush_sapling", "",
	"default:bush_sapling", "default:copper_lump", "default:iron_lump", "",
	"dye:black", "dye:brown", "default:obsidian_shard", "default:tin_lump"
}

minetest.register_craftitem("lottmobs:hairball", {
	description = S("Hairball"),
	inventory_image = "mobs_hairball.png",
	on_use = function(itemstack, user, pointed_thing)

		local pos = user:get_pos()
		local dir = user:get_look_dir()
		local newpos = {x = pos.x + dir.x, y = pos.y + dir.y + 1.5, z = pos.z + dir.z}
		local item = hairball_items[math.random(1, #hairball_items)]

		if item ~= "" then
			minetest.add_item(newpos, {name = item})
		end

		minetest.sound_play("default_place_node_hard", {
			pos = newpos,
			gain = 1.0,
			max_hear_distance = 5,
		})

		itemstack:take_item()

		return itemstack
	end,
})
