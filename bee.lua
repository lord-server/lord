local S = minetest.get_mod_translator()

-- Bee by KrupnoPavel

legacy_mobs:register_mob('bees:bee', {
	type = "animal",
	passive = true,
	hp_min = 1,
	hp_max = 2,
	armor = 200,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_bee.x",
	textures = {
		{"mobs_bee.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_bee",
	},
	walk_velocity = 1,
	jump = true,
	drop = {""},
	--drops = {
		--{name = "bees:honey",
		--{name = "legacy_mobs:honey",
		--chance = 1, min = 1, max = 2},
	--},
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -3,
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
	},
	on_rightclick = function(self, clicker)
		legacy_mobs:capture_mob(self, clicker, 25, 80, 0, true, nil)
	end,
})

legacy_mobs:alias_mob('mobs:bee', 'bees:bee')
legacy_mobs:spawn_specific("bees:bee", {"group:flower"}, {"air"}, 10, 20, 30, 5000, 1, 0, 1000)
legacy_mobs:register_egg("bees:bee", S("Bee"), "mobs_bee_inv.png", 0)

-- honey
minetest.register_craftitem("bees:honey", {
	description = S("Honey"),
	inventory_image = "mobs_honey_inv.png",
	on_use = minetest.item_eat(6),
})

-- beehive (when placed spawns bee)
minetest.register_node("bees:beehive", {
	description = S("Beehive"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"mobs_beehive.png"},
	inventory_image = "mobs_beehive.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	groups = {oddly_breakable_by_hand = 3},
	sounds = default.node_sound_defaults(),
	drop = {""},
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "bees:beehive", param2 = 1})
			if math.random(1, 5) == 1 then
				minetest.add_entity(pos, "bees:bee")
			end
		end
	end,

})

--minetest.register_craft({
	--output = "bees:beehive",
	--recipe = {
		--{"bees:bee","bees:bee","bees:bee"},
	--}
--})

-- honey block
minetest.register_node("bees:honey_block", {
	description = S("Honey Block"),
	tiles = {"mobs_honey_block.png"},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_dirt_defaults(),
})

--minetest.register_craft({
	--output = "bees:honey_block",
	--recipe = {
		--{"bees:honey", "bees:honey", "bees:honey"},
		--{"bees:honey", "bees:honey", "bees:honey"},
		--{"bees:honey", "bees:honey", "bees:honey"},
	--}
--})

--minetest.register_craft({
	--output = "bees:honey 9",
	--recipe = {
		--{"bees:honey_block"},
	--}
--})

