--advtrains by orwell96, see readme.txt and license.txt
--crafting.lua
--registers crafting recipes

--tracks
-- minetest.register_craft({
-- 	output = 'advtrains:dtrack_placer 50',
-- 	recipe = {
-- 		{'default:steel_ingot', '', 'default:steel_ingot'},
-- 		{'default:steel_ingot', 'group:wood', 'default:steel_ingot'},
-- 		{'default:steel_ingot', '', 'default:steel_ingot'},
-- 	},
-- })

-- minetest.register_craft({
-- 	type = "shapeless",
-- 	output = 'advtrains:dtrack_slopeplacer 2',
-- 	recipe = {
-- 		"advtrains:dtrack_placer",
-- 		"advtrains:dtrack_placer",
-- 		"default:gravel",
-- 	},
-- })

-- minetest.register_craft({
-- 	output = 'advtrains:dtrack_bumper_placer 2',
-- 	recipe = {
-- 		{'group:wood', 'dye:red'},
-- 		{'default:steel_ingot', 'default:steel_ingot'},
-- 		{'advtrains:dtrack_placer', ''},
-- 	},
-- })

-- minetest.register_craft({
-- 	type="shapeless",
-- 	output = 'advtrains:dtrack_detector_off_placer',
-- 	recipe = {
-- 		"advtrains:dtrack_placer",
-- 		"mesecons:wire_00000000_off"
-- 	},
-- })

--signals
-- minetest.register_craft({
-- 	output = 'advtrains:retrosignal_off 2',
-- 	recipe = {
-- 		{'dye:red', 'default:steel_ingot', 'default:steel_ingot'},
-- 		{'', '', 'default:steel_ingot'},
-- 		{'', '', 'default:steel_ingot'},
-- 	},
-- })

--minetest.register_craft({
	--output = 'advtrains:signal_off 2',
	--recipe = {
		--{'', 'dye:red', 'default:steel_ingot'},
		--{'', 'dye:dark_green', 'default:steel_ingot'},
		--{'', '', 'default:steel_ingot'},
	--},
--})

--trackworker
-- minetest.register_craft({
-- 	output = 'advtrains:trackworker',
-- 	recipe = {
-- 		{'default:diamond'},
-- 		{'screwdriver:screwdriver'},
-- 		{'default:steel_ingot'},
-- 	},
-- })

--boiler
-- minetest.register_craft({
-- 	output = 'advtrains:boiler',
-- 	recipe = {
-- 		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
-- 		{'carts:steam_mechanism', 'lottpotion:cauldron_full', 'default:steel_ingot'},
-- 		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
-- 	},
-- })

--drivers'cab
-- minetest.register_craft({
-- 	output = 'advtrains:driver_cab',
-- 	recipe = {
-- 		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
-- 		{'default:bronze_ingot', '', 'default:glass'},
-- 		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
-- 	},
-- })

--wheel
-- minetest.register_craft({
-- 	output = 'advtrains:wheel',
-- 	recipe = {
-- 		{'', 'default:steel_ingot', 'dye:red'},
-- 		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
-- 		{'', 'default:steel_ingot', ''},
-- 	},
-- })

--wheel_pair
-- minetest.register_craft({
-- 	output = 'advtrains:wheel_pair',
-- 	recipe = {
-- 		{'advtrains:wheel', 'default:steel_ingot', 'advtrains:wheel'},
-- 	},
-- })

--trolley
-- minetest.register_craft({
-- 	output = 'advtrains:trolley',
-- 	recipe = {
-- 		{'default:steel_ingot', '', 'default:steel_ingot'},
-- 		{'advtrains:wheel_pair', 'default:steel_ingot', 'advtrains:wheel_pair'},
-- 	},
-- })

--chimney
-- minetest.register_craft({
-- 	output = 'advtrains:chimney',
-- 	recipe = {
-- 		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
-- 		{'', 'default:steel_ingot', ''},
-- 		{'', 'default:steel_ingot', ''},
-- 	},
-- })


--misc_nodes
--crafts for platforms see misc_nodes.lua
