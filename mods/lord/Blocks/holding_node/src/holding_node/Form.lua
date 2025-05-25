local S = minetest.get_mod_translator()
local spec = minetest.formspec


--- @class holding_node.node.Form: base_classes.Form.Base
--- @field node_position Position
--- @field node_meta NodeMetaRef
local Form = base_classes.Form:personal():for_node():extended({
	NAME = 'holding_node:holding_node_config',
})

--- @private
--- @return string
function Form:get_spec()
	local str_pos = self.node_position.x .. ',' .. self.node_position.y .. ',' .. self.node_position.z

	return ''
		.. spec.formspec_version(4)
		.. spec.size(12,11)
		.. spec.field(1, 1, 3, 1, 'input_name',S('Name'), self.node_meta:get_string('name'))
		.. spec.button_exit(4.5, 1, 2, 1, 'save', S('Save'))
		.. spec.label(1, 2.75, S('Reward'))
		.. spec.list('nodemeta:' .. str_pos, 'reward', 1, 3, 8, 1)
		.. spec.list('current_player', 'main', 1, 5, 8, 4)
end

--- @param fields table
function Form:handle(fields)
	if fields.input_name and fields.save then
		if self.node_meta then
			self.node_meta:set_string('name', fields.input_name)
		end
	end
end


return Form:register()
