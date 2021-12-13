-- dye/init.lua

-- У нас краски можно получать из листвы
-- (!) сделано без циклов, чтобы выдавалось в поиске по проекту
minetest.register_craft({
	output = "dye:white 4",
	recipe = {
		{"group:leaves,color_white"}
	},
})

minetest.register_craft({
	output = "dye:grey 4",
	recipe = {
		{"group:leaves,color_grey"}
	},
})

minetest.register_craft({
	output = "dye:dark_grey 4",
	recipe = {
		{"group:leaves,color_dark_grey"}
	},
})

minetest.register_craft({
	output = "dye:black 4",
	recipe = {
		{"group:leaves,color_black"}
	},
})

minetest.register_craft({
	output = "dye:violet 4",
	recipe = {
		{"group:leaves,color_violet"}
	},
})

minetest.register_craft({
	output = "dye:blue 4",
	recipe = {
		{"group:leaves,color_blue"}
	},
})

minetest.register_craft({
	output = "dye:cyan 4",
	recipe = {
		{"group:leaves,color_cyan"}
	},
})

minetest.register_craft({
	output = "dye:dark_green 4",
	recipe = {
		{"group:leaves,color_dark_green"}
	},
})

minetest.register_craft({
	output = "dye:green 4",
	recipe = {
		{"group:leaves,color_green"}
	},
})

minetest.register_craft({
	output = "dye:yellow 4",
	recipe = {
		{"group:leaves,color_yellow"}
	},
})

minetest.register_craft({
	output = "dye:brown 4",
	recipe = {
		{"group:leaves,color_brown"}
	},
})

minetest.register_craft({
	output = "dye:orange 4",
	recipe = {
		{"group:leaves,color_orange"}
	},
})

minetest.register_craft({
	output = "dye:red 4",
	recipe = {
		{"group:leaves,color_red"}
	},
})

minetest.register_craft({
	output = "dye:magenta 4",
	recipe = {
		{"group:leaves,color_magenta"}
	},
})

minetest.register_craft({
	output = "dye:pink 4",
	recipe = {
		{"group:leaves,color_pink"}
	},
})

-- Крафт коричневой краски из земли (`default:dirt`)
minetest.register_craft({
  type = "shapeless",
  output = "dye:brown 4",
  recipe = {"default:dirt"},
})

-- Крафт зеленой краски из травы ('default:grass_1')
minetest.register_craft({
  type = "shapeless",
	output = "dye:green 4",
	recipe = {"default:grass_1"},
})

-- Крафт зеленой краски из травы ('lottplants:lorien_grass_1'), возможно стоит от него отказаться
minetest.register_craft({
  type = "shapeless",
	output = "dye:green 4",
	recipe = {"lottplants:lorien_grass_1"},
})
