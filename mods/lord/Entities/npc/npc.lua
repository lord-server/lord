local S = minetest.get_translator("npc")
local esc = minetest.formspec_escape

npc = {
	["required_priv"] = "server",
	["player_mobs"] = {},
}

local function can_place(definition, playername)
	local allowed = minetest.get_player_privs(playername)[npc.required_priv]
	if definition.can_place then
		allowed = allowed or definition.can_place(playername)
	end
	return allowed
end

local function can_edit(self, playername)
	local allowed = minetest.get_player_privs(playername)[npc.required_priv]
	if self.definition.can_edit then
		allowed = allowed or self.definition.can_edit(self, playername)
	end
	return allowed
end

local function build_main_form(self)
	local width = self.width
	local bw = width - 0.5
	local pos = 0
	local formspec = ""

	-- show greeting
	formspec = formspec.."textarea[0.5,"..pos..";"..bw..",1.5;;;"..esc(self.greeting).."]"
	pos = pos + 1.5

	-- show mob content
	local content, newpos = self:user_mob_content(width, pos)
	formspec = formspec..content
	pos = newpos

	-- show Close button
	pos = pos + 0.2
	formspec = formspec.."button_exit[0.25,"..pos..";"..bw..",1;close_form;"..esc(S("Close")).."]"
	pos = pos + 1
	formspec = "size["..width..","..pos.."]"..formspec
	return formspec
end

local function build_edit_header(self, formspec, pos, bw)
    -- show mobname and greeting editable fields
	formspec = formspec.."field[0.5,"..pos..";"..bw..",0.5;edit_name;;"..esc(self.mobname).."]"
	pos = pos + 1
	formspec = formspec.."field[0.5,"..pos..";"..bw..",0.5;edit_color;;"..esc(self.color).."]"
	pos = pos + 1
	formspec = formspec.."field[0.5,"..pos..";"..bw..",0.5;edit_texture;;"..esc(self.texture).."]"
	pos = pos + 1
    formspec = formspec.."textarea[0.5,"..pos..";"..bw..",1.5;edit_greeting;;"..esc(self.greeting).."]"
	pos = pos + 1.5
	return formspec, pos
end

local function build_main_form_editable(self)
	local width = self.width
	local bw = width - 0.5
	local pos = 0.5
	local formspec = ""

    if self.build_edit_header == nil then
        formspec, pos = build_edit_header(self, formspec, pos, bw)
    else
        formspec, pos = self:build_edit_header(formspec, pos, bw)
    end

	-- show mob content (editable)
	local content, newpos = self:admin_mob_content(width, pos)
	formspec = formspec..content
	pos = newpos

	-- show Take and Close buttons
	pos = pos + 0.5
	formspec = formspec.."button[0.25,"..pos..";"..bw..",1;save_main;"..esc(S("Save")).."]"
	pos = pos + 1
	formspec = formspec.."button_exit[0.25,"..pos..";"..bw..",1;take_mob;"..esc(S("Take")).."]"
	pos = pos + 1
	formspec = formspec.."button_exit[0.25,"..pos..";"..bw..",1;close_form;"..esc(S("Close")).."]"
	pos = pos + 1
	formspec = "size["..width..","..pos.."]"..formspec
	return formspec
end

local function show_main(self, clicker)
	local player = clicker:get_player_name()

	if can_edit(self, player) and not clicker:get_player_control().aux1 then
        local can_edit_mobname = true
        if self.definition.can_edit_mobname ~= nil then
            can_edit_mobname = self.definition.can_edit_mobname
        end
		minetest.show_formspec(player, "npc:main_form", build_main_form_editable(self, can_edit_mobname))
	else
		minetest.show_formspec(player, "npc:main_form", build_main_form(self))
	end
end

minetest.register_on_player_receive_fields(function(clicker, formname, fields)
	local player = clicker:get_player_name()

	local self = npc.player_mobs[player]
	if self == nil then
		return
	end

	local player_can_edit = can_edit(self, player)
	if formname == "npc:main_form" then
		-- handling main form
		if fields["save_main"] ~= nil then
			-- save mob name and greeting
            if self.header_form_handler then
                self:header_form_handler(fields)
            else
			    self.mobname  = fields["edit_name"]
			    self.color    = fields["edit_color"]
			    self.greeting = fields["edit_greeting"]
			    self.texture  = fields["edit_texture"]
			    self.object:set_properties({
				    nametag       = self.mobname,
				    nametag_color = self.color,
				    textures      = {self.texture},
			    })
            end
			self:show_main(clicker)
		elseif fields["take_mob"] ~= nil then
			-- take mob to inventory
			local inventory = clicker:get_inventory()
			if inventory:room_for_item("main", self.name) then
				local new_stack = ItemStack(self.name.."_egg")

				local data_str = self:get_staticdata()
				new_stack:set_metadata(data_str)

				local inv = clicker:get_inventory()
				if inv:room_for_item("main", new_stack) then
					inv:add_item("main", new_stack)
				else
					minetest.add_item(clicker:get_pos(), new_stack)
				end

				self.object:remove()
				npc.player_mobs[player] = nil
			end
		elseif fields["close_form"] ~= nil then
			-- form will close automatically
			npc.player_mobs[player] = nil
		else
			-- call mob content
			self:main_form_handle(clicker, fields, player_can_edit)
		end
	else
		-- handle mob content
		self:form_handle(clicker, formname, fields, player_can_edit)
	end
end)

local function face_pos(self, pos)
	local s = self.object:get_pos()
	local vec = {x=pos.x-s.x, y=pos.y-s.y, z=pos.z-s.z}
	local yaw = math.atan2(vec.z,vec.x)-math.pi/2
	if self.drawtype == "side" then
		yaw = yaw+(math.pi/2)
	end
	self.object:set_yaw(yaw)
	return yaw
end


local function interact_infomob(self, clicker)
	local player = clicker:get_player_name()
	if can_edit(self, player) or self.face_user then
		face_pos(self, clicker:get_pos())
	end
	npc.player_mobs[player] = self
	self:show_main(clicker)
end

local function default_user_mob_content(self, width, pos)
	return "", pos
end

local function default_admin_mob_content(self, width, pos)
	return "", pos
end

local function default_main_form_handle(self, clicker, fields, player_can_edit)
end

local function default_form_handle(self, clicker, formname, fields, player_can_edit)
end

local function default_init_from_staticdata(self, mobdata)
end

local function default_init_new(self)
end

local function default_configure_placed(self, playername)
end

local function default_get_mobdata(self)
	return minetest.serialize({})
end

local function on_activate(self, staticdata)
	local data = minetest.deserialize(staticdata)
	if data ~= nil then
		if data["mobdata"] ~= nil then
			self:init_from_staticdata(data["mobdata"])
		else
			self:init_new()
		end

		if data["mobname"] ~= nil then
			self.mobname = data["mobname"]
		else
			self.mobname = self.definition.mobname
		end

		if data["color"] ~= nil then
			self.color = data["color"]
		else
			self.color = self.definition.color
		end

		if data["greeting"] ~= nil then
			self.greeting = data["greeting"]
		else
			self.greeting = self.definition.message
		end

		if data["texture"] ~= nil then
			self.texture = data["texture"]
		else
			self.texture = self.definition.texture
		end
	else
		self.mobname  = self.definition.mobname
		self.color    = self.definition.color
		self.greeting = self.definition.message
		self.texture  = self.definition.texture
		self:init_new()
	end

	self.object:set_armor_groups({immortal = 1})
	self.object:set_properties({
		nametag       = self.mobname,
		nametag_color = self.color,
		textures      = {self.texture},
	})
end

local function get_staticdata(self)
	local data = {
		["mobname"] = self.mobname,
		["color"] = self.color,
		["texture"] = self.texture,
		["greeting"] = self.greeting,
		["mobdata"] = self:get_mobdata(),
	}
	return minetest.serialize(data)
end

function npc:register_mob(name, definition)
	minetest.register_entity(name, {
		definition = definition,
		physical = true,

		collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
		visual = "mesh",
		mesh = "human_model.x",

		texture = definition.texture or "lottmobs_rohan_guard_2.png",
		mobname = definition.mobname or "Меродок",
		greeting = definition.greeting or "Привет! Как дела, что делаешь?",
		color = definition.color or "#FFBB00",
		face_user = definition.face_user or false,
		width = definition.width or 8,

		on_rightclick = interact_infomob,
		on_punch = interact_infomob,
		show_main = show_main,

		-- mob content functions
		user_mob_content = definition.user_mob_content or default_user_mob_content,
		admin_mob_content = definition.admin_mob_content or default_admin_mob_content,
		main_form_handle = definition.main_form_handle or default_main_form_handle,
		form_handle = definition.form_handle or default_form_handle,
		init_from_staticdata = definition.init_from_staticdata or default_init_from_staticdata,
		init_new = definition.init_new or default_init_new,
		get_mobdata = definition.get_mobdata or default_get_mobdata,
        configure_placed = definition.configure_placed or default_configure_placed,
        build_edit_header = definition.build_edit_header,
        header_form_handler = definition.header_form_handler,

		on_activate = on_activate,
		get_staticdata = get_staticdata,
	})

    local description = name.." egg"
    if definition.description then
        description = definition.description
    end

	minetest.register_craftitem(name.."_egg", {

		description = description,
		inventory_image = "npc_info_mob.png",
		groups = {not_in_creative_inventory = 1},
		stack_max = 1,

		on_place = function(itemstack, placer, pointed_thing)
			local player = placer:get_player_name()
			if not can_place(definition, player) then
				return
			end

			local pos = pointed_thing.above

			-- am I clicking on something with existing on_rightclick function?
			local under = minetest.get_node(pointed_thing.under)
			local def = minetest.registered_nodes[under.name]
			if def and def.on_rightclick then
				return def.on_rightclick(pointed_thing.under, under, placer, itemstack)
			end

			if pos
			and within_limits(pos, 0)
			and not minetest.is_protected(pos, player) then
				pos.y            = pos.y + 0.5

				local data       = itemstack:get_metadata()
				local entity     = minetest.add_entity(pos, name, data)
				local lua_entity = entity:get_luaentity()

				if not lua_entity then
					entity:remove()
					return
				end

				-- since mob is unique we remove egg once spawned
				itemstack:take_item()

                lua_entity:configure_placed(player)
			end

			return itemstack
		end,
	})
end
