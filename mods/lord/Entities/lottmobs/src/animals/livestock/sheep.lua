

mobs:register_mob("lottmobs:sheep", {
	type = "animal",
	passive = true,
	hp_min = 8,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.5, -1, -0.5, 0.5, 0.3, 0.5},
	visual = "mesh",
	mesh = "mobs_sheep.b3d", -- from mods/_various/mobs
	textures = {
		{"mobs_sheep_base.png^mobs_sheep_wool.png"}, --White
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#663300a0)^[noalpha"}, --Brown
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#000000b0)^[noalpha"}, --Black
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#5b5b5bb0)^[noalpha"}, --Grey
	},
	gotten_texture = {"mobs_sheep_shaved.png"},
	gotten_mesh = "mobs_sheep_shaved.b3d", -- from mods/_various/mobs
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	drops = {
		{ name = "lottmobs:meat_raw", chance = 1, min = 1, max = 2 },
		{ name = "wool:white",        chance = 1, min = 1, max = 1 },
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

		if string.match(itemname, "^tools:dagger_") then
			if self.gotten ~= false
				or self.child ~= false
				or not minetest.get_modpath("wool") then
				return
			end
			self.gotten = true -- shaved
			local obj = minetest.add_item(
				self.object:get_pos(),
				ItemStack( "wool:white " .. math.random(1, 3) )
			)
			if obj then
				obj:set_velocity({
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
})

mobs:register_spawn("lottmobs:sheep",
	{"lord_ground:dirt_shire", "lord_ground:dirt_gondor", "lord_ground:dirt_dunland",
	 "lord_ground:dirt_ithilien"},
	20, 10, 10000, 1, 31000)
