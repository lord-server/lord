local message = "Сервер L.O.R.D. приветствует тебя! Будь как дома, путник."
local mobname = "Меродок"

local questions =
{
	{
		["enabled"]		= true,
		["label"]		= "howto_craft",
		["question"]	= "Как узнать рецепты крафта?",
		["answer"]		= "Нужно собрать книгу крафта.\n"..
						  "Рецепт сборки книги нарисован на табло."
	},
	{
		["enabled"]		= true,
		["label"]		= "where_components",
		["question"]	= "Я не знаю, где мне взять компоненты.",
		["answer"]		= "Часть компонентов можно срубить неподалеку.\n\n"..
						  "Что до других...\n"..
						  "Я слышал, моему товарищу нужна помощь.\n"..
						  "Может быть у него взамен найдутся нужные вам компоненты."
	}
}

local function build_form()
	local formspec = "size[8,4]"..
					 "label[0,0;"..message.."]"
	local pos = 0.5
	for _, item in ipairs(questions) do
		if item["enabled"] then
			formspec = formspec.."button[0,"..pos..";5,1;"..item["label"]..";"..item["question"].."]"
			pos = pos + 1
		end
	end
	return formspec
end

local function show_main(clicker)
	local player = clicker:get_player_name()
	minetest.show_formspec(player, "npc:static_guide_select", build_form())
end

local function show_answer(clicker, answer)
	local player = clicker:get_player_name()
	local formspec = "size[8,5]label[0,0;"..answer.."]button[0,4;5,1;return_to_main;Назад]"
	minetest.show_formspec(player, "npc:static_guide_answer", formspec)
end

minetest.register_on_player_receive_fields(function(clicker, formname, fields)
	if formname == "npc:static_guide_select" then
		for _, item in ipairs(questions) do
			if fields[item["label"]] ~= nil then
				show_answer(clicker, item["answer"])
				break
			end
		end
	elseif formname == "npc:static_guide_answer" then
		if fields["return_to_main"] ~= nil then
			show_main(clicker)
		end
	end
end)

minetest.register_entity("npc:info_mob", {
	physical = true,
	textures = {"lottmobs_rohan_guard_2.png"},
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	mobname = mobname,
	color = "#FFBB00",

	on_rightclick = function(self, clicker)
		show_main(clicker)
	end,
	on_activate = function(self, staticdata)
		self.object:set_properties({
			nametag = self.mobname,
			nametag_color = self.color,
		})
	end,
})
