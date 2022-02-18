local SL = lord.require_intllib()

-- I could depend on WorldEdit for this, but you need to have the 'worldedit'
-- permission to use those commands and you don't have
-- /area_pos{1,2} [X Y Z|X,Y,Z].
-- Since this is mostly copied from WorldEdit it is mostly
-- licensed under the AGPL. (select_area is a exception)

areas.marker1 = {}
areas.marker2 = {}
areas.set_pos = {}
areas.pos1 = {}
areas.pos2 = {}

minetest.register_chatcommand("select_area", {
	params = "<ID>",
	description = SL("Select a area by id."),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local id = tonumber(param)
		if not id then
			return false, SL("Invalid usage, see").." /help select_area."
		end
		if not areas.areas[id] then
			return false, SL("The area").." "..id.." "..SL("does not exist.")
		end

		areas:setPos1(name, areas.areas[id].pos1)
		areas:setPos2(name, areas.areas[id].pos2)
		return true, SL("Area").." "..id.." "..SL("selected.")
	end,
})

minetest.register_chatcommand("area_pos1", {
	params = "[X Y Z|X,Y,Z]",
	description = SL("Set area protection region position 1 to your"
		.." location or the one specified"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local pos = nil
		local found, _, x, y, z = param:find(
				"^(-?%d+)[, ](-?%d+)[, ](-?%d+)$")
		if found then
			pos = {x=tonumber(x), y=tonumber(y), z=tonumber(z)}
		elseif param == "" then
			local player = minetest.get_player_by_name(name)
			if player then
				pos = player:get_pos()
			else
				return false, SL("Unable to get position.")
			end
		else
			return false, SL("Invalid usage, see").." /help area_pos1."
		end
		pos = vector.round(pos)
		areas:setPos1(name, pos)
		return true, SL("Area position 1 set to").." "..minetest.pos_to_string(pos)
	end,
})

minetest.register_chatcommand("area_pos2", {
	params = "[X Y Z|X,Y,Z]",
	description = SL("Set area protection region position 2 to your"
		.." location or the one specified"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local pos = nil
		local found, _, x, y, z = param:find(
				"^(-?%d+)[, ](-?%d+)[, ](-?%d+)$")
		if found then
			pos = {x=tonumber(x), y=tonumber(y), z=tonumber(z)}
		elseif param == "" then
			local player = minetest.get_player_by_name(name)
			if player then
				pos = player:get_pos()
			else
				return false, SL("Unable to get position.")
			end
		else
			return false, SL("Invalid usage, see").." /help area_pos2."
		end
		pos = vector.round(pos)
		areas:setPos2(name, pos)
		return true, SL("Area position 2 set to").." "..minetest.pos_to_string(pos)
	end,
})


minetest.register_chatcommand("area_pos", {
	params = "set/set1/set2/get",
	description = SL("Set area protection region, position 1, or position 2"
		.." by punching nodes, or display the region"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		if param == "set" then -- Set both area positions
			areas.set_pos[name] = "pos1"
			return true, SL("Select positions by punching two nodes.")
		elseif param == "set1" then -- Set area position 1
			areas.set_pos[name] = "pos1only"
			return true, SL("Select position 1 by punching a node.")
		elseif param == "set2" then -- Set area position 2
			areas.set_pos[name] = "pos2"
			return true, SL("Select position 2 by punching a node.")
		elseif param == "get" then -- Display current area positions
			local pos1str, pos2str = SL("Position").." 1: ", SL("Position").." 2: "
			if areas.pos1[name] then
				pos1str = pos1str..minetest.pos_to_string(areas.pos1[name])
			else
				pos1str = pos1str.."<not set>"
			end
			if areas.pos2[name] then
				pos2str = pos2str..minetest.pos_to_string(areas.pos2[name])
			else
				pos2str = pos2str.."<not set>"
			end
			return true, pos1str.."\n"..pos2str
		else
			return false, SL("Unknown subcommand")..": "..param
		end
	end,
})

function areas:getPos(playerName)
	local pos1, pos2 = areas.pos1[playerName], areas.pos2[playerName]
	if not (pos1 and pos2) then
		return nil
	end
	-- Copy positions so that the area table doesn't contain multiple
	-- references to the same position.
	pos1, pos2 = vector.new(pos1), vector.new(pos2)
	return areas:sortPos(pos1, pos2)
end

function areas:setPos1(playerName, pos)
	areas.pos1[playerName] = pos
	areas.markPos1(playerName)
end

function areas:setPos2(playerName, pos)
	areas.pos2[playerName] = pos
	areas.markPos2(playerName)
end


minetest.register_on_punchnode(function(pos, node, puncher)
	local name = puncher:get_player_name()
	-- Currently setting position
	if name ~= "" and areas.set_pos[name] then
		if areas.set_pos[name] == "pos1" then
			areas.pos1[name] = pos
			areas.markPos1(name)
			areas.set_pos[name] = "pos2"
			minetest.chat_send_player(name,
					SL("Position").." 1 "..SL("set to").." "..minetest.pos_to_string(pos))
		elseif areas.set_pos[name] == "pos1only" then
			areas.pos1[name] = pos
			areas.markPos1(name)
			areas.set_pos[name] = nil
			minetest.chat_send_player(name,
					SL("Position").." 1 "..SL("set to").." "..minetest.pos_to_string(pos))
		elseif areas.set_pos[name] == "pos2" then
			areas.pos2[name] = pos
			areas.markPos2(name)
			areas.set_pos[name] = nil
			minetest.chat_send_player(name,
					SL("Position").." 2 "..SL("set to").." "..minetest.pos_to_string(pos))
		end
	end
end)

-- Modifies positions `pos1` and `pos2` so that each component of `pos1`
-- is less than or equal to its corresponding component of `pos2`,
-- returning the two positions.
function areas:sortPos(pos1, pos2)
	if pos1.x > pos2.x then
		pos2.x, pos1.x = pos1.x, pos2.x
	end
	if pos1.y > pos2.y then
		pos2.y, pos1.y = pos1.y, pos2.y
	end
	if pos1.z > pos2.z then
		pos2.z, pos1.z = pos1.z, pos2.z
	end
	return pos1, pos2
end

-- Marks area position 1
areas.markPos1 = function(name)
	local pos = areas.pos1[name]
	if areas.marker1[name] ~= nil then -- Marker already exists
		areas.marker1[name]:remove() -- Remove marker
		areas.marker1[name] = nil
	end
	if pos ~= nil then -- Add marker
		areas.marker1[name] = minetest.add_entity(pos, "areas:pos1")
		areas.marker1[name]:get_luaentity().active = true
	end
end

-- Marks area position 2
areas.markPos2 = function(name)
	local pos = areas.pos2[name]
	if areas.marker2[name] ~= nil then -- Marker already exists
		areas.marker2[name]:remove() -- Remove marker
		areas.marker2[name] = nil
	end
	if pos ~= nil then -- Add marker
		areas.marker2[name] = minetest.add_entity(pos, "areas:pos2")
		areas.marker2[name]:get_luaentity().active = true
	end
end

minetest.register_entity("areas:pos1", {
	initial_properties = {
		visual = "cube",
		visual_size = {x=1.1, y=1.1},
		textures = {"areas_pos1.png", "areas_pos1.png",
		            "areas_pos1.png", "areas_pos1.png",
		            "areas_pos1.png", "areas_pos1.png"},
		collisionbox = {-0.55, -0.55, -0.55, 0.55, 0.55, 0.55},
	},
	on_step = function(self, dtime)
		if self.active == nil then
			self.object:remove()
		end
	end,
	on_punch = function(self, hitter)
		self.object:remove()
		local name = hitter:get_player_name()
		areas.marker1[name] = nil
	end,
})

minetest.register_entity("areas:pos2", {
	initial_properties = {
		visual = "cube",
		visual_size = {x=1.1, y=1.1},
		textures = {"areas_pos2.png", "areas_pos2.png",
		            "areas_pos2.png", "areas_pos2.png",
		            "areas_pos2.png", "areas_pos2.png"},
		collisionbox = {-0.55, -0.55, -0.55, 0.55, 0.55, 0.55},
	},
	on_step = function(self, dtime)
		if self.active == nil then
			self.object:remove()
		end
	end,
	on_punch = function(self, hitter)
		self.object:remove()
		local name = hitter:get_player_name()
		areas.marker2[name] = nil
	end,
})
