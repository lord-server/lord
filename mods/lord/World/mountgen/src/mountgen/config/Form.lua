local Algorithm = require('mountgen.Algorithm')
local Config    = require('mountgen.Config')
local Builder   = require('mountgen.config.Form.Builder')

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
	--- @type string[] used for `method` dropdown
	algorithm_names     = nil,
	--- @private
	--- @type string[] used for `Coverage node` dropdown
	coverage_nodes_list = nil,
	--- @private
	--- @type string unique name of tool|node|... by which the form was opened
	opened_by           = nil,
}
Form = base_classes.Form:personal():extended(Form)

Form.event.Type.on_save     = 'on_save'
Form.event.Type.on_generate = 'on_generate'
Form.event.subscribers[Form.event.Type.on_save]     = {}
Form.event.subscribers[Form.event.Type.on_generate] = {}

--- @alias mountgen.config.Form.callback fun(form:mountgen.config.Form, config:table)

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

--- @protected
--- @return string[]
function Form:get_methods()
	if not self.algorithm_names then
		self.algorithm_names = Algorithm.get_names()
	end

	return self.algorithm_names
end

--- @static
--- @private
--- @param x         number
--- @param y         number
--- @param text      string
--- @param font_size string
--- @return string
function Form.title(x, y, text, font_size)
	return ''
		.. spec.style_type('label', { font = 'bold', font_size = font_size })
		.. spec.label(x, y, text)
		.. spec.style_type('label', { font = 'normal', font_size = '+0' })
end

--- @static
--- @private
--- @param label string
--- @param y_pos number
--- @param callback fun(y_pos:number):number,string
--- @return number, string
function Form.group(label, y_pos, callback)
	--- @type string
	local formspec
	local start_pos = y_pos

	y_pos = y_pos + 0.4
	y_pos, formspec = callback(y_pos)
	y_pos = y_pos + 0.2

	return
		y_pos,
		spec.style_type('label', { font_size = '-1', textcolor = '#ddd'  }) ..
		spec.label(0.05, start_pos - 0.6, label) ..
		spec.style_type('label', { font_size = '+0', textcolor = '#ddd'  }) ..
		spec.box(0, start_pos - 0.2, 6.8, y_pos - start_pos - 0.4, '#0003') ..
		formspec ..
		spec.style_type('label', { font_size = '+0', textcolor = '#fff' })
end

--- @param config table
--- @return string
function Form:get_spec(config)
	local formspec = ''
	local width = 7
	local y_pos = 0.2

	local group_spec

	formspec = formspec .. self.title(2, y_pos - 0.3, S('Mountain creation tool'), '+6')
	y_pos = y_pos + 0.4
	formspec = formspec .. self.title(2.5, y_pos - 0.3, colorize('#faa', S('Use with caution!')), '+3')
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

	formspec = spec.size(width, y_pos) .. formspec

	return formspec
end

-- TODO
--- @private
--- @param config table
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

--- @protected
--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function Form:handle(fields)
	local can_edit = minetest.get_player_privs(self.player_name)[mountgen.required_priv]
	if not can_edit then
		return
	end

	if not fields['save'] and not fields['generate'] and not fields['algorithm'] then
		return
	end

	local config         = {}
	config.algorithm     = fields['algorithm']
	config.angle         = tonumber(fields['angle']) or 0
	config.foot_height   = tonumber(fields['foot_height']) or 0
	config.snow_line     = tonumber(fields['snow_line']) or 0
	config.rk_big        = tonumber(fields['rk_big']) or 0
	config.rk_small      = tonumber(fields['rk_small']) or 0
	config.rk_thr        = tonumber(fields['rk_thr']) or 0
	config.coverage_node = fields['coverage_node']
	-- TODO validation
	if not self:is_valid(config) then
		-- TODO validation messages
		return
	end

	config = table.merge(
		Config.get_defaults(Algorithm.get(config.algorithm)),
		config
	)

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
