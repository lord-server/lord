-- dye/init.lua

-- У нас краски можно получать из листвы
-- (!) сделано без циклов, чтобы выдавалось в поиске по проекту
local leaves_color = {
	{"dye:white",      "color_white"},
	{"dye:grey",       "color_grey"},
	{"dye:dark_grey",  "color_dark_grey"},
	{"dye:black",      "color_black"},
	{"dye:violet",     "color_violet"},
	{"dye:blue",       "color_blue"},
	{"dye:cyan",       "color_cyan"},
	{"dye:dark_green", "color_dark_green"},
	{"dye:green",      "color_green"},
	{"dye:yellow",     "color_yellow"},
	{"dye:brown",      "color_brown"},
	{"dye:orange",     "color_orange"},
	{"dye:red",        "color_red"},
	{"dye:magenta",    "color_magenta"},
	{"dye:pink",       "color_pink"},
}

for _, row in ipairs(leaves_color) do
	minetest.register_craft({
		output = row[1] .. " 4",
		recipe = {
			{"group:leaves," .. row[2]}
		},
	})
end

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
