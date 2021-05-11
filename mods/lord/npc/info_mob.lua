local S = minetest.get_translator("npc")
local esc = minetest.formspec_escape

local function show_answer(clicker, item)
	local player = clicker:get_player_name()
	local formspec = "size[8,5]"
	formspec = formspec.."textarea[0.5,0;7.5,4;;;"..esc(item.answer).."]"
	formspec = formspec.."button[0.25,4;7.5,1;return_to_main;"..esc(S("Back")).."]"
	minetest.show_formspec(player, "npc:static_guide_answer", formspec)
end

local function edit_answer(clicker, item)
	local player = clicker:get_player_name()
	local formspec = "size[8,9]"
	formspec = formspec.."field[0.5,0.0;0,0;old_label;;"..item["label"].."]"
	formspec = formspec.."field[0.5,0.5;7.5,1;edit_label;;"..item["label"].."]"
	formspec = formspec.."field[0.5,1.5;7.5,1;edit_question;;"..esc(item["question"]).."]"
	formspec = formspec.."textarea[0.5,2.5;7.5,2.75;edit_answer;;"..esc(item["answer"]).."]"
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

local function user_mob_content(self, width, pos)
	local formspec = ""
	local bw = width - 0.5
	for _, item in ipairs(self.questions) do
		if item["enabled"] then
			formspec = formspec.."button[0.25,"..pos..";"..bw..",1;"..item["label"]..";"..item["question"].."]"
			pos = pos + 1
		end
	end
	return formspec, pos
end

local function admin_mob_content(self, width, pos)
	local bw = width - 0.5
	local formspec = ""
	for _, item in ipairs(self.questions) do
		formspec = formspec.."button[0.25,"..pos..";"..bw..",1;"..item["label"]..";"..esc(item["question"]).."]"
		pos = pos + 1
	end
	formspec = formspec.."button[0.25,"..pos..";"..bw..",1;new_question;+]"
	pos = pos + 1
	return formspec, pos
end

local function main_form_handle(self, clicker, fields, can_edit)
	if fields["new_question"] ~= nil then
		-- create new question
		table.insert(self.questions, {
			["enabled"]		= true,
			["label"]		= "new_label_"..self.new_question_index,
			["question"]	= "???",
			["answer"]		= "Ответ",
		})
		self.new_question_index = self.new_question_index + 1
		self:show_main(clicker)
	else
		-- goto question show or edit
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
end

local function form_handle(self, clicker, formname, fields, can_edit)
	if formname == "npc:static_guide_answer" then
		-- return to main menu from question show
		if fields["return_to_main"] ~= nil then
			self:show_main(clicker)
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
			self:show_main(clicker)
		elseif fields["delete_question"] ~= nil then
			-- delete question
			for index, item in ipairs(self.questions) do
				if item["label"] == oldlabel then
					table.remove(self.questions, index)
					self:show_main(clicker)
					break
				end
			end
		elseif fields["hide_question"] ~= nil then
			-- hide question from players
			for _, item in ipairs(self.questions) do
				if item["label"] == oldlabel then
					item["enabled"] = false
					self:show_main(clicker)
					break
				end
			end
		elseif fields["show_question"] ~= nil then
			-- show question to players
			for _, item in ipairs(self.questions) do
				if item["label"] == oldlabel then
					item["enabled"] = true
					self:show_main(clicker)
					break
				end
			end
		elseif fields["return_to_main"] ~= nil then
			-- return to main menu from question edit
			self:show_main(clicker)
		end
	end
end

local function init_from_staticdata(self, mobdata)
	local data = minetest.deserialize(mobdata)
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
end

local function init_new(self)
	self.questions = {}
	self.new_question_index = 0
end

local function get_mobdata(self)
	local data = {
		["questions"] = self.questions,
		["new_question_index"] = self.new_question_index,
	}
	return minetest.serialize(data)
end

npc:register_mob("npc:info_mob", {
	user_mob_content = user_mob_content,
	admin_mob_content = admin_mob_content,
	main_form_handle = main_form_handle,
	form_handle = form_handle,
	init_from_staticdata = init_from_staticdata,
	init_new = init_new,
	get_mobdata = get_mobdata,
})
