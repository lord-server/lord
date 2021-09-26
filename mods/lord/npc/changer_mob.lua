local esc = minetest.formspec_escape

local function user_mob_content(self, width, pos)
	local formspec = ""
	formspec = formspec.."list[detached:"..self.id..";receive;0.25,"..pos..";1,1]"
	formspec = formspec.."list[detached:"..self.id..";give;1.25,"..pos..";1,1]"
	pos = pos + 1.5

	formspec = formspec.."list[current_player;main;0,"..pos..";8,1;]"
	pos = pos + 1.2
	formspec = formspec.."list[current_player;main;0,"..pos..";8,3;8]"
	pos = pos + 3

	return formspec, pos
end

local function admin_mob_content(self, width, pos)
	local formspec = ""
	formspec = formspec.."list[detached:"..self.id..";admin_receive;0.25,"..pos..";1,1]"
	formspec = formspec.."list[detached:"..self.id..";admin_give;1.25,"..pos..";1,1]"
	pos = pos + 1.5
	formspec = formspec.."list[current_player;main;0.25,"..pos..";8,1;]"
	pos = pos + 1
	return formspec, pos
end

local function main_form_handle(self, clicker, fields, can_edit)
end

local function form_handle(self, clicker, formname, fields, can_edit)
end


-- inventory functions
local function allow_put(inv, listname, index, stack, player)
	if listname == "give" then
		return 0
	end
	return stack:get_count()
end

local function allow_take(inv, listname, index, stack, player)
	return stack:get_count()
end

local function allow_move(inv, from_list, from_index, to_list, to_index, count, player)
	if to_list == "give" then
		return 0
	end
	return count
end

local function update_changer(self, inv)
	self.give = inv.get_stack(inv, "admin_give", 1):get_name()
	self.give_qty = inv.get_stack(inv, "admin_give", 1):get_count()
	self.receive = inv.get_stack(inv, "admin_receive", 1):get_name()
	self.receive_qty = inv.get_stack(inv, "admin_receive", 1):get_count()
	minetest.log("Changer receive: "..self.receive.." "..self.receive_qty)
	minetest.log("Changer give: "..self.give.." "..self.give_qty)
end

local function update_takeout(self, inv)
	local received     = inv:get_stack("receive", 1):get_name()
	local received_qty = inv:get_stack("receive", 1):get_count()

	local name = self.give
	local count = self.give_qty
	inv:remove_item("give", {name=name, count=count})

	if received == self.receive and received_qty >= self.receive_qty then
		-- put good
		inv:add_item("give", {name=self.give, count=self.give_qty})
	end
end

local function take_fee(self, inv)
	local received     = inv.get_stack(inv, "receive", 1):get_name()
	if received ~= self.receive then
		return
	end

	inv:remove_item("receive", {name=self.receive, count=self.receive_qty})
end

local function on_put(inv, listname, index, stack, player)
	local playername = player:get_player_name()
	local self = npc.player_mobs[playername]
	if self == nil then
		return
	end

	if listname == "admin_receive" then
		update_changer(self, inv)
	elseif listname == "admin_give" then
		update_changer(self, inv)
	elseif listname == "receive" then
		update_takeout(self, inv)
	elseif listname == "give" then
		minetest.log("error", "put to GIVE!")
	end
end

local function on_take(inv, listname, index, stack, player)
	local playername = player:get_player_name()
	local self = npc.player_mobs[playername]
	if self == nil then
		return
	end

	if listname == "admin_receive" then
		update_changer(self, inv)
	elseif listname == "admin_give" then
		update_changer(self, inv)
	elseif listname == "receive" then
		update_takeout(self, inv)
	elseif listname == "give" then
		take_fee(self, inv)
	end
end

local function create_inventory(self, id)
	self.inventory = minetest.get_inventory({type="detached", name=id})
	if self.inventory ~= nil then
		return
	end

	local move_put_take = {
		allow_put = allow_put,
		allow_take = allow_take,
		allow_move = allow_move,
		on_put = on_put,
		on_take = on_take
	}
	self.inventory = minetest.create_detached_inventory(id, move_put_take)
	self.inventory:set_size("admin_receive", 1)
	self.inventory:set_size("admin_give", 1)
	self.inventory:set_size("receive", 1)
	self.inventory:set_size("give", 1)

	self.inventory:set_stack("admin_give", 1, self.give.." "..self.give_qty)
	self.inventory:set_stack("admin_receive", 1, self.receive.." "..self.receive_qty)
end

local function init_from_staticdata(self, mobdata)
	local data = minetest.deserialize(mobdata)
	if data["receive"] ~= nil then
		self.receive = data["receive"]
		self.receive_qty = data["receive_qty"]
	else
		self.receive = "default:dirt"
		self.receive_qty = 1
	end

	if data["give"] ~= nil then
		self.give = data["give"]
		self.give_qty = data["give_qty"]
	else
		self.give = "default:stone"
		self.give_qty = 1
	end

	if data["id"] ~= nil then
		self.id = data["id"]
	else
		self.id = esc(self.mobname..self.name..math.random(1, 1000))
	end

	create_inventory(self, self.id)
end

local function init_new(self)
	self.id = esc(self.mobname..self.name..math.random(1, 1000))
	self.receive = "default:dirt"
	self.receive_qty = 1
	self.give = "default:stone"
	self.give_qty = 1
	create_inventory(self, self.id)
end

local function get_mobdata(self)
	local data = {
		["id"] = self.id,
		["receive"] = self.receive,
		["receive_qty"] = self.receive_qty,
		["give"] = self.give,
		["give_qty"] = self.give_qty,
	}
	return minetest.serialize(data)
end

npc:register_mob("npc:changer_mob", {
	user_mob_content = user_mob_content,
	admin_mob_content = admin_mob_content,
	main_form_handle = main_form_handle,
	form_handle = form_handle,
	init_from_staticdata = init_from_staticdata,
	init_new = init_new,
	get_mobdata = get_mobdata,
	face_user = true,
	width = 8.5,
})
