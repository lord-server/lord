local SL = lord.require_intllib()

if not lottmobs.dragon then
        lottmobs.dragon = {}
end

-- Functions
-- Table cloning to reduce code repetition
lottmobs.deepclone = function(t) -- deep-copy a table -- from https://gist.github.com/MihailJP/3931841
	if type(t) ~= "table" then return t end

	local target = {}

	for k, v in pairs(t) do
		if k ~= "__index" and type(v) == "table" then -- omit circular reference
			target[k] = lottmobs.deepclone(v)
		else
			target[k] = v
		end
	end
	return target
end

lottmobs.dragon.ride = function(self, clicker)
    if self.tamed and self.owner == clicker:get_player_name() then
        local inv = clicker:get_inventory()
            if self.driver and clicker == self.driver then
                object_detach(self, clicker, {x=1, y=0, z=1})
                if inv:room_for_item("main", "mobs:saddle") then
                    inv:add_item("main", "mobs:saddle")
                else
                    minetest.add_item(clicker.getpos(), "mobs:saddle")
                end
                elseif not self.driver then
                    if clicker:get_wielded_item():get_name() == "mobs:saddle" then
                        object_attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
                        inv:remove_item("main", "mobs:saddle")
                    end
            end
    end
end

-- Objects
local gdragon_base = {
	type = "monster",
	passive = false,
	attacks_monsters = false,
	damage = 5,
	reach = 4,
	attack_type = "dogshoot",
	shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max = 1,
--	arrow = "dmobs:lightning",
	arrow = "lottmobs:fireball",
	shoot_offset = 0,
	hp_min = 140,
	hp_max = 180,
	armor = 220,
	collisionbox = {-0.6, -1.4, -0.6, 0.6, 0.6, 0.6},
	visual = "mesh",
	mesh = "dragon.b3d",
	textures = {
	  {"lottmobs_dragon_great.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2.5, y=2.5},
	makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	pathfinding = true,
	fall_damage = 0,
	sounds = {
		shoot_attack = "mobs_fireball",
		random = "roar",
	},
	walk_velocity = 3,
	run_velocity = 5,
	jump = true,
	fly = true,
	drops = {
		{name = "lottother:stony_green_gem", chance = 0.7, min = 0, max = 1},
		{name = "lottother:stony_blue_gem", chance = 0.7, min = 0, max = 1},
		{name = "lottother:stony_red_gem", chance = 0.7, min = 0, max = 1},
		{name = "lottother:stony_white_gem", chance = 0.7, min = 0, max = 1},
	},
	fall_speed = 0,
	stepheight = 10,
	water_damage = 2,
	lava_damage = 0,
	light_damage = 0,
	view_range = 20,
	animation = {
		speed_normal = 10,
		speed_run = 20,
		walk_start = 1,
		walk_end = 22,
		stand_start = 1,
		stand_end = 22,
		run_start = 1,
		run_end = 22,
		punch_start = 22,
		punch_end = 47,
	},
	knock_back = 4,
}

mobs:register_mob("lottmobs:dragon_great", lottmobs.deepclone(gdragon_base) )

gdragon_base.type = "npc"
gdragon_base.attacks_monsters = true

gdragon_base.on_rightclick = lottmobs.dragon.ride

--gdragon_base.do_custom = dmobs.dragon.do_custom

mobs:register_mob("lottmobs:dragon_great_tame", lottmobs.deepclone(gdragon_base) )

--mobs:register_egg("lottmobs:dragon_great", "Boss Dragon", "mobs_dragon_egg.png", 1)
--mobs:register_egg("lottmobs:dragon_great_tame", "Great Dragon", "default_lava_source_animated.png", 1)
