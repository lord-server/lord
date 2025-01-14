local Algorithm = require('mountgen.Algorithm')
local Generator = require('mountgen.Generator')
local Config    = require('mountgen.Config')

local S        = minetest.get_mod_translator()
local Logger   = minetest.get_mod_logger()
local spec     = minetest.formspec
local colorize = minetest.colorize


local DEFAULT_MOD_DIRTS = {
	'default:dirt',
	'default:dirt_with_grass',
	'default:dirt_with_grass_footsteps',
	'default:dirt_with_dry_grass',
	'default:dirt_with_rainforest_litter',
	'default:dirt_with_coniferous_litter',
	'default:dirt_with_snow',
	'default:dry_dirt',
	'default:dry_dirt_with_dry_grass',
}

--- @class mountgen.config.Form: base_classes.Form.Base
--- @field new fun(player:Player,meta:MetaDataRef|string) @`meta` - metadata of Node or string `for_wielded_item`
local Form = {
	--- @const
	--- @type string
	NAME = 'mountgen:configure',
	--- @private
	--- @type string[] used for `method` dropdown
	algorithm_names = nil,
	--- @private
	--- @type string[] used for `Coverage node` dropdown
	coverage_nodes_list = nil,
	--- @private
	--- @type MetaDataRef|string meta data of Item or Node to get config from, and save to
	thing_meta = nil,
}
Form = base_classes.Form:personal():extended(Form)

function Form:instantiate(player, meta)
	self.thing_meta = meta
end

--- @protected
--- @return MetaDataRef
function Form:get_thing_meta()
	return self.thing_meta == 'for_wielded_item'
		and minetest.get_player_by_name(self.player_name):get_wielded_item():get_meta()
		or  self.thing_meta
end

--- @protected
--- @return string[]
function Form:get_methods()
	if not self.algorithm_names then
		self.algorithm_names = Algorithm.get_names()
	end

	return self.algorithm_names
end

--- @return string[]
function Form:get_coverage_variants()
	if not self.coverage_nodes_list then
		if minetest.global_exists('ground') and ground.dirt and ground.dirt.get_nodes then
			self.coverage_nodes_list = {}
			for node_name, node in pairs(ground.dirt.get_nodes()) do -- also contains dirts from `default`
				table.insert(self.coverage_nodes_list, node_name)
			end
		else -- `default` mod not in optional dependencies
			self.coverage_nodes_list = DEFAULT_MOD_DIRTS
		end
	end

	return self.coverage_nodes_list
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

--- @return string
function Form:get_spec()
	local config = self:get_thing_meta():get('config')
	config = config
		and minetest.deserialize(config)
		or  Config.get_defaults()

	local formspec = ''
	local width = 7
	local bw = 4
	local y_pos = 0.1

	local group_spec

	formspec = formspec .. self.title(2, y_pos - 0.3, S('Mountain creation tool'), '+6')
	y_pos = y_pos + 0.4
	formspec = formspec .. self.title(2.5, y_pos - 0.3, colorize('#faa', S('Use with caution!')), '+3')
	y_pos = y_pos + 0.8

	y_pos, group_spec = self.group(S('Basic Options:'), y_pos, function(pos_y)
		local f_spec = ''
		-- TODO #1932
		-- метод
		local methods = self:get_methods()
		local selected_method = table.key_value_swap(methods)[config.algorithm]
		f_spec = f_spec .. spec.label(0.3, pos_y - 0.3, S('Method'))
		f_spec = f_spec .. spec.dropdown_W(3 - 0.295, pos_y - 0.45, bw + 0.190, 'edit_method', methods, selected_method)
		pos_y = pos_y + 0.8
		-- основание
		f_spec = f_spec .. spec.label(0.3, pos_y - 0.3, S('Foot height'))
		f_spec = f_spec .. spec.field(3, pos_y, bw, 0.5, 'edit_base', '', config.foot_height)
		pos_y = pos_y + 0.8
		-- угол горы
		f_spec = f_spec .. spec.label(0.3, pos_y - 0.3, S('Angle'))
		f_spec = f_spec .. spec.field(3, pos_y, bw, 0.5, 'edit_angle', '', config.angle)
		pos_y = pos_y + 0.8

		return pos_y, f_spec
	end)
	formspec = formspec .. group_spec

	y_pos, group_spec = self.group(S('Algorithm Options:'), y_pos, function(pos_y)
		local f_spec = ''

		-- TODO #1932
		local config_fields = Algorithm.get(config.algorithm).get_config_fields()
		for _, config_field in pairs(config_fields) do
			f_spec = f_spec .. spec.label(0.3, pos_y - 0.3, config_field.label)
			f_spec = f_spec .. spec.field(3, pos_y, bw, 0.5, 'edit_' .. config_field.name, '', config[config_field.name])
			pos_y = pos_y + 0.8
		end

		return pos_y, f_spec
	end)
	formspec = formspec .. group_spec

	y_pos, group_spec = self.group(S('Content Options:'), y_pos, function(pos_y)
		local f_spec = ''
		-- TODO #1932
		-- снежная линия
		f_spec = f_spec .. spec.label(0.3, pos_y - 0.3, S('Snow line '))
		f_spec = f_spec .. spec.field(3, pos_y, bw, 0.5, 'edit_snow_line', '', config.snow_line)
		pos_y = pos_y + 0.8
		-- грунт сверху
		local covers = self:get_coverage_variants()
		local selected_cover = table.key_value_swap(covers)[config.top_cover]
		f_spec = f_spec .. spec.label(0.3, pos_y - 0.3, S('Coverage node'))
		f_spec = f_spec .. spec.dropdown_W(3 - 0.295, pos_y - 0.45, bw + 0.190, 'edit_top_cover', covers, selected_cover)
		pos_y = pos_y + 0.8

		return pos_y, f_spec
	end)
	formspec = formspec .. group_spec


	formspec = formspec .. spec.button(0.5, y_pos - 0.3, 3, 1, 'save', S('Save'))
	formspec = formspec .. spec.button(3.5, y_pos - 0.3, 3, 1, 'generate', S('Generate'))
	y_pos = y_pos + 0.6

	formspec = spec.size(width, y_pos) .. formspec

	return formspec
end

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

--- @private
--- @param wield_item ItemStack
--- @param config     table
--- @return string
function Form:build_tool_description(wield_item, config)
	local base_description = wield_item:get_definition().description
	local default_config   = Config.get_defaults(Algorithm.get(config.algorithm))

	local config_strings = {}
	for name, value in pairs(config) do
		local list_item = colorize('#bbb', S(name)) .. ':   ' ..
			(value ~= default_config[name] and colorize('#f66', value) or value)
		config_strings[#config_strings+1] = '  • ' .. list_item
	end

	return base_description ..'\n\n' ..
		colorize('#ee8', S('Configuration')) .. ':\n' ..
		table.concat(config_strings, '\n')
end

--- @protected
--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function Form:handle(fields)
	local can_edit = minetest.get_player_privs(self.player_name)[mountgen.required_priv]
	if not can_edit then
		return
	end

	-- TODO #1932  refresh form on algo change

	if fields['save'] == nil and fields['generate'] == nil then
		return
	end

	local config       = {}
	config.algorithm   = fields['edit_method']
	config.angle       = tonumber(fields['edit_angle']) or 0
	config.foot_height = tonumber(fields['edit_base']) or 0
	config.snow_line   = tonumber(fields['edit_snow_line']) or 0
	config.rk_big      = tonumber(fields['edit_rk_big']) or 0
	config.rk_small    = tonumber(fields['edit_rk_small']) or 0
	config.rk_thr      = tonumber(fields['edit_rk_thr']) or 0
	config.top_cover   = fields['edit_top_cover']
	-- TODO validation
	if not self:is_valid(config) then
		-- TODO validation messages
		return
	end

	config = table.merge(
		Config.get_defaults(Algorithm.get(config.algorithm)),
		config
	)

	if fields['save'] then
		if self.thing_meta == 'for_wielded_item' then
			local player = minetest.get_player_by_name(self.player_name)
			local wield_item = player:get_wielded_item()
			local meta = wield_item:get_meta()

			meta:set_string('config', minetest.serialize(config))
			meta:set_string('description', self:build_tool_description(wield_item, config))
			player:set_wielded_item(wield_item)
		else -- for Node
			self:get_thing_meta():set_string('config', minetest.serialize(config))
		end
	end

	if fields['generate'] then
		local top_position = minetest.get_player_by_name(self.player_name):get_pos()
		Logger.action('use mount stick at ' .. minetest.pos_to_string(top_position))
		Logger.action('parameters: ' .. dump(config))
		Generator:new(top_position, config):run()
	end

	self:close()
end


return Form:register()
