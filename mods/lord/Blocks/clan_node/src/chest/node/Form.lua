
---
--- @class clan_node.chest.node.Form
---
local Form = {
	--- @const
	--- @type string
	NAME = "clan_node:chest",
	--- @static
	--- @type table<string,clan_node.chest.node.Form>
	opened_for = {},

	--- @private
	--- @type Position
	node_position = nil,
	--- @type string
	player_name   = nil,
}

--- Constructor
--- @public
--- @param pos Position
--- @param player Player
--- @return clan_node.chest.node.Form
function Form:new(pos, player)
	local class = self
	self = {}

	self.node_position = pos
	self.player_name   = player:get_player_name()

	return setmetatable(self, {__index = class})
end

--- @public
--- @static
--- @param player Player
--- @return clan_node.chest.node.Form
function Form.get_opened_for(player)
	return Form.opened_for[player:get_player_name()]
end

--- @public
function Form:open()
	local player_name = self.player_name
	self.opened_for[player_name] = self;

	local node_pos = self.node_position
	local sound    = minetest.registered_nodes[minetest.get_node(node_pos).name].sound_open
	if not sound then return end
	minetest.sound_play(sound, { gain = 0.3, pos = node_pos, max_hear_distance = 10}, true)
	minetest.show_formspec(player_name, self.NAME, self:get_spec())
end

--- @public
function Form:close()
	self.opened_for[self.player_name] = nil

	local node_pos = self.node_position
	local sound    = minetest.registered_nodes[minetest.get_node(node_pos).name].sound_close
	if not sound then return end
	minetest.sound_play(sound, { gain = 0.3, pos = node_pos, max_hear_distance = 10}, true)
end

--- @private
function Form:get_spec()
	local pos  = self.node_position

	local str_pos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec = "size[8,9]" ..
		"list[nodemeta:" .. str_pos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. str_pos .. ";main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,4.85)

	return formspec
end

--- @static
--- @param player Player
--- @param form_name string
--- @param fields table
function Form.handler(player, form_name, fields)
	if form_name ~= Form.NAME then
		return
	end

	local form = Form.get_opened_for(player)
	if not form then return end

	if fields.quit then
		form:close()
	end
end

minetest.register_on_leaveplayer(function(player, timed_out)
	local form = Form.get_opened_for(player);
	if form then
		form:close()
	end
end)


return Form
