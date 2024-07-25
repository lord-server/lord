local S = minetest.get_translator('clan_node')

---
--- @class clan_node.chest.node.Form: base_classes.Form.Base
---
--- @field node_position Position
--- @field player_name   string
local Form = base_classes.Form:personal():for_node():extended({
	--- @const
	--- @type string
	NAME = "clan_node:chest",
})


Form.on_open(function(self)
	local node_pos = self.node_position
	local sound    = minetest.registered_nodes[minetest.get_node(node_pos).name].sound_open
	if not sound then return end
	minetest.sound_play(sound, { gain = 0.3, pos = node_pos, max_hear_distance = 10}, true)
end)

--- @public
Form.on_close(function(self)
	local node_pos = self.node_position
	local sound    = minetest.registered_nodes[minetest.get_node(node_pos).name].sound_close
	if not sound then return end
	minetest.sound_play(sound, { gain = 0.3, pos = node_pos, max_hear_distance = 10}, true)
end)

--- @private
function Form:get_spec()
	local pos  = self.node_position

	local clan_info = ""
	local is_admin = minetest.check_player_privs(self.player_name, "server")
	if is_admin then
		local clan_name = minetest.get_meta(self.node_position):get_string("owned_clan")
		local is_online = clans.clan_is_online(clan_name)
		clan_info = "label[0,4.3;" ..
			S("Clan:") .. " " .. clan_name ..
			" (" .. (is_online and S("online") or S("offline")) .. ")" ..
		"]"
	end
	local str_pos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec = "size[8,9]" ..
		"list[nodemeta:" .. str_pos .. ";main;0,0.3;8,4;]" ..
		clan_info ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. str_pos .. ";main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,4.85)

	return formspec
end


return Form
