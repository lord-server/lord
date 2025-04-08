

local spec = minetest.formspec


--- @class holding_node.node.Form: base_classes.Form.Base
--- @field node_position Position
--- @field node_meta NodeMetaRef
local Form = base_classes.Form:for_node():extended({
	NAME = 'holding_node:holding_node_config',
})

--- @private
function Form:get_spec()
local str_pos = minetest.pos_to_string(self.node_position)

local is_admin = minetest.check_player_privs(self.player_name, "server")
	if is_admin then
		return ''
		.. spec.size(8,9)
		.. spec.field(1, 1, 3, 1, 'input_name','Name', '')	-- X
		.. spec.button_exit(1, 2, 3, 1, 'save', 'Save')
		.. spec.list('nodemeta:' .. str_pos, 'reward', 1, 3, 4, 1)     -- Z
	end
end

function Form:handle(fields)
	if fields.save then
		self.node_meta:set_string('name', fields.input_name)  -- X

		-- сохранять не нужно (это делает движок, почему-то)
		self.node_meta:get_inventory():get_list('reward') --   <-- как обратиться/достать
	end
end

return Form
