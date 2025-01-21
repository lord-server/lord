local Algorithm = require('mountgen.Algorithm')
local Config    = require('mountgen.Config')
local Builder   = require('mountgen.config.Form.Builder')
local FieldType = require('mountgen.config.FieldType')

local S        = minetest.get_mod_translator()
local spec     = minetest.formspec
local colorize = minetest.colorize


--- @class mountgen.config.Form: base_classes.Form.Base
--- @field new fun(player:Player,opened_by:string) @`opened_by` - name of tool|node (ex:`wielded:mountgen:mount_tool`)
local Form = {
	--- @const
	--- @type string
	NAME                = 'mountgen:configure',
	--- @private
	--- @type string unique name of tool|node|... by which the form was opened
	opened_by           = nil,
}
Form = base_classes.Form:personal():extended(Form)

Form.event.Type.on_save     = 'on_save'
Form.event.Type.on_generate = 'on_generate'
Form.event.subscribers[Form.event.Type.on_save]     = {}
Form.event.subscribers[Form.event.Type.on_generate] = {}

--- @alias mountgen.config.Form.callback fun(form:mountgen.config.Form, config:mountgen.ConfigValues)

--- @type fun(callback:mountgen.config.Form.callback)
Form.on_save     = Form.event:on(Form.event.Type.on_save, Form.event)
--- @type fun(callback:mountgen.config.Form.callback)
Form.on_generate = Form.event:on(Form.event.Type.on_generate, Form.event)


--- @protected
--- @param player    Player
--- @param opened_by string
function Form:instantiate(player, opened_by)
	self.opened_by = opened_by
end

--- @public
--- @return string unique name of tool|node|... by which the form was opened (you must set it by yourself via `:new()`)
function Form:get_opened_by()
	return self.opened_by
end

--- @param config mountgen.ConfigValues
--- @return string
function Form:get_spec(config)
	local formspec = ''
	local y_pos = 0.2

	local group_spec

	formspec = formspec .. Builder.title(2, y_pos - 0.3, S('Mountain creation tool'), '+6')
	y_pos = y_pos + 0.4
	formspec = formspec .. Builder.title(2.5, y_pos - 0.3, colorize('#faa', S('Use with caution!')), '+3')
	y_pos = y_pos + 0.8

	y_pos, group_spec = Builder.render_group(Config.get_group('basic'), y_pos, config)
	formspec = formspec .. group_spec

	local algorithm = Algorithm.get(config.algorithm)
	local algorithm_group = {
		label       = S('Algorithm Options:'),
		description = algorithm.get_description and algorithm.get_description(),
		definitions = algorithm.get_config_fields()
	}
	y_pos, group_spec = Builder.render_group(algorithm_group, y_pos, config)
	formspec = formspec .. group_spec

	y_pos, group_spec = Builder.render_group(Config.get_group('content'), y_pos, config)
	formspec = formspec .. group_spec

	formspec = formspec .. spec.button(0.5, y_pos - 0.3, 3, 1, 'save', S('Save'))
	formspec = formspec .. spec.button(3.5, y_pos - 0.3, 3, 1, 'generate', S('Generate'))
	y_pos = y_pos + 0.6

	formspec = Builder.size(y_pos) .. formspec

	return formspec
end

-- TODO
--- @private
--- @param config mountgen.ConfigValues
--- @return boolean
function Form:is_valid(config)
	for k, v in pairs(config) do
		if v == nil then
			return false
		end
	end
	if config.angle < 15 or config.angle > 90 then
		return false
	end
	return true
end

--- @private
--- @param fields    table
--- @param algorithm mountgen.AlgorithmInterface
function Form:cast_fields(fields, algorithm)
	local algo_definitions = algorithm.get_config_fields()
	for name, value in pairs(fields) do
		local def = Config.get_definition(name) or algo_definitions[name]
		if def.type == FieldType.NUMBER then
			fields[name] = tonumber(fields[name])
		end
	end

	return fields
end

--- @protected
--- @param fields table|mountgen.ConfigValues table with fields comes from client form
--- @return nil|boolean return `true` for stop propagation of handling
function Form:handle(fields)
	local can_edit = minetest.get_player_privs(self.player_name)[mountgen.required_priv]
	if not can_edit then
		return
	end

	if not fields['save'] and not fields['generate'] and not fields['algorithm'] then
		return
	end

	local algorithm = Algorithm.get(fields.algorithm)
	local defaults  = Config.get_defaults(algorithm)
	local config_fields = self:cast_fields(
		table.only(fields, table.keys(defaults)),
		algorithm
	)

	-- TODO #1964 validation
	if not self:is_valid(config_fields) then
		-- TODO #1964 validation messages
		return
	end

	local config = table.merge(defaults, config_fields)

	if fields['algorithm'] and not fields['save'] and not fields['generate'] then
		self:open(config)

		return
	end

	if fields['save'] then
		self.event:trigger(self.event.Type.on_save, self, config)
	end

	if fields['generate'] then
		self.event:trigger(self.event.Type.on_generate, self, config)
	end

	self:close()
end


Form:register()


return Form
