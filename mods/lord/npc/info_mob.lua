local S = minetest.get_translator("npc")
local esc = minetest.formspec_escape

local required_priv = "server"
local message = "Сервер L.O.R.D. приветствует тебя! Будь как дома, путник."
local mobname = "Меродок"

local player_mobs = {}

local function build_main_form(self)
	local h = table.getn(self.questions)+0.5
	local formspec = "size[8,"..h.."]"..
					 "label[0,0;"..self.greeting.."]"
	local pos = 0.5
	for _, item in ipairs(self.questions) do
		if item["enabled"] then
			formspec = formspec.."button[0,"..pos..";7.5,1;"..item["label"]..";"..item["question"].."]"
			pos = pos + 1
		end
	end
	return formspec
end

local function build_main_form_editable(self)
	local h = table.getn(self.questions)+4.5
	local formspec = "size[8,"..h.."]"
	formspec = formspec.."field[0.5,0.5;7.5,0.5;edit_name;;"..self.mobname.."]"
	formspec = formspec.."textarea[0.5,1;7.5,1.5;edit_greeting;;"..self.greeting.."]"
	local pos = 2.5
	for _, item in ipairs(self.questions) do
		formspec = formspec.."button[0.25,"..pos..";7.5,1;"..item["label"]..";"..item["question"].."]"
		pos = pos + 1
	end
	formspec = formspec.."button[0.25,"..pos..";7.5,1;new_question;+]"
	pos = pos + 1
	formspec = formspec.."button[0.25,"..pos..";7.5,1;save_main;"..esc(S("Save")).."]"
	return formspec
end

local function show_main(self, clicker)
	local player = clicker:get_player_name()
	local can_edit = minetest.get_player_privs(player)[required_priv]
	if can_edit then
		minetest.show_formspec(player, "npc:static_guide_select", build_main_form_editable(self))
	else
		minetest.show_formspec(player, "npc:static_guide_select", build_main_form(self))
	end
end

local function show_answer(clicker, item)
	local player = clicker:get_player_name()
	local formspec = "size[8,5]label[0.25,0;"..item.answer.."]button[0.25,4;7.5,1;return_to_main;"..esc(S("Back")).."]"
	minetest.show_formspec(player, "npc:static_guide_answer", formspec)
end

local function edit_answer(clicker, item)
	local player = clicker:get_player_name()
	local formspec = "size[8,9]"
	formspec = formspec.."field[0.5,0.0;0,0;old_label;;"..item["label"]..";]"
	formspec = formspec.."field[0.5,0.5;7.5,1;edit_label;;"..item["label"]..";]"
	formspec = formspec.."field[0.5,1.5;7.5,1;edit_question;;"..item["question"]..";]"
	formspec = formspec.."textarea[0.5,2.5;7.5,2.75;edit_answer;;"..item["answer"]..";]"
	formspec = formspec.."button[0.25,5;7.5,1;return_to_main;"..esc(S("Back")).."]"
	formspec = formspec.."button[0.25,6;7.5,1;save_question;"..esc(S("Save")).."]"
	formspec = formspec.."button[0.25,7;7.5,1;delete_question;"..esc(S("Delete")).."]"
	if item["enabled"] then
		formspec = formspec.."button[0.25,8;7.5,1;hide_question;"..esc(S("Hide")).."]"
	else
		formspec = formspec.."button[0.25,8;7.5,1;show_question;"..esc(S("Show")).."]"
	end
	minetest.show_formspec(player, "npc:edit_guide_answer", formspec)
end

minetest.register_on_player_receive_fields(function(clicker, formname, fields)
	local player = clicker:get_player_name()
	local self = player_mobs[player]
	if self == nil then
		return
	end

	if formname == "npc:static_guide_select" then
		-- handling main form
		if fields["new_question"] ~= nil then
			-- create new question
			table.insert(self.questions, {
				["enabled"]		= true,
				["label"]		= "new_label_"..self.new_question_index,
				["question"]	= "Новый вопрос",
				["answer"]		= "Ответ",
			})
			self.new_question_index = self.new_question_index + 1
			show_main(self, clicker)
		elseif fields["save_main"] ~= nil then
			-- save mob name and greeting
			self.mobname = fields["edit_name"]
			self.greeting = fields["edit_greeting"]
			self.object:set_properties({
				nametag = self.mobname,
				nametag_color = self.color,
			})
			show_main(self, clicker)
		else
			-- goto question show or edit
			local can_edit = minetest.get_player_privs(player)[required_priv]
			for _, item in ipairs(self.questions) do
				if fields[item["label"]] ~= nil then
					if can_edit then
						edit_answer(clicker, item)
					else
						show_answer(clicker, item)
					end
					break
				end
			end
		end
	elseif formname == "npc:static_guide_answer" then
		-- return to main menu from question show
		if fields["return_to_main"] ~= nil then
			show_main(self, clicker)
		end
	elseif formname == "npc:edit_guide_answer" then
		-- edit question
		local oldlabel = fields["old_label"]
		local label = fields["edit_label"]
		local question = fields["edit_question"]
		local answer = fields["edit_answer"]
		if fields["save_question"] ~= nil then
			-- save question
			for _, item in ipairs(self.questions) do
				if item["label"] == oldlabel then
					item["label"] = label
					item["question"] = question
					item["answer"] = answer
				end
			end
			show_main(self, clicker)
		elseif fields["delete_question"] ~= nil then
			-- delete question
			for index, item in ipairs(self.questions) do
				if item["label"] == oldlabel then
					table.remove(self.questions, index)
					show_main(self, clicker)
					break
				end
			end
		elseif fields["hide_question"] ~= nil then
			-- hide question from players
			for _, item in ipairs(self.questions) do
				if item["label"] == oldlabel then
					item["enabled"] = false
					show_main(self, clicker)
					break
				end
			end
		elseif fields["show_question"] ~= nil then
			-- show question to players
			for _, item in ipairs(self.questions) do
				if item["label"] == oldlabel then
					item["enabled"] = true
					show_main(self, clicker)
					break
				end
			end
		elseif fields["return_to_main"] ~= nil then
			-- return to main menu from question edit
			show_main(self, clicker)
		end
	end
end)

local function face_pos(self, pos)
	local s = self.object:getpos()
	local vec = {x=pos.x-s.x, y=pos.y-s.y, z=pos.z-s.z}
	local yaw = math.atan2(vec.z,vec.x)-math.pi/2
	if self.drawtype == "side" then
		yaw = yaw+(math.pi/2)
	end
	self.object:setyaw(yaw)
	return yaw
end

minetest.register_entity("npc:info_mob", {
	physical = true,
	textures = {"lottmobs_rohan_guard_2.png"},
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	mobname = mobname,
	color = "#FFBB00",
	questions = {},

	on_rightclick = function(self, clicker)
		local player = clicker:get_player_name()
		face_pos(self, clicker:getpos())
		player_mobs[player] = self
		show_main(self, clicker)
	end,
	on_activate = function(self, staticdata)
		local data = minetest.deserialize(staticdata)
		if data ~= nil then
			if data["questions"] ~= nil then
				self.questions = data["questions"]
			else
				self.questions = {}
			end

			if data["new_question_index"] ~= nil then
				self.new_question_index = data["new_question_index"]
			else
				self.new_question_index = 0
			end

			if data["mobname"] ~= nil then
				self.mobname = data["mobname"]
			else
				self.mobname = mobname
			end

			if data["greeting"] ~= nil then
				self.greeting = data["greeting"]
			else
				self.greeting = message
			end

		else
			self.questions = {}
			self.new_question_index = 0
			self.mobname = mobname
			self.greeting = message
		end

		self.object:set_armor_groups({immortal = 1})
		self.object:set_properties({
			nametag = self.mobname,
			nametag_color = self.color,
		})
	end,
	get_staticdata = function(self)
		local data = {
			["questions"] = self.questions,
			["new_question_index"] = self.new_question_index,
			["mobname"] = self.mobname,
			["greeting"] = self.greeting,
		}
		return minetest.serialize(data)
	end,
})
