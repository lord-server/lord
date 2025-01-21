local Algorithm = require('mountgen.Algorithm')
local Generator = require('mountgen.Generator')
local Config    = require('mountgen.Config')
local Form      = require('mountgen.config.Form')

local S        = minetest.get_mod_translator()
local Logger   = minetest.get_mod_logger()
local colorize = minetest.colorize


local function register_stick()
	minetest.register_tool('mountgen:mount_tool', {
		description = S('Mountain tool'),
		inventory_image = 'mountgen_tool.png',
		on_use = function(itemstack, placer, pointed_thing)
			local user_name = placer:get_player_name()
			local can_access = minetest.get_player_privs(user_name)[mountgen.required_priv]
			if not can_access then
				return
			end

			local config = itemstack:get_meta():get('config')
			config = config
				and minetest.deserialize(config)
				or  Config.get_defaults()
			Form:new(placer, 'wielded:mountgen:mount_tool'):open(config)

			return itemstack
		end,
		group = {},
		on_drop = function(itemstack, dropper, pos)
			return
		end,
	})

	--- @param wield_item ItemStack
	--- @param config     mountgen.ConfigValues
	--- @return string
	local function build_tool_description(wield_item, config)
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

	Form.on_save(function(form, config)
		if form:get_opened_by() ~= 'wielded:mountgen:mount_tool' then
			return
		end

		local player = minetest.get_player_by_name(form.player_name)
		local wield_item = player:get_wielded_item()
		local meta = wield_item:get_meta()

		meta:set_string('config', minetest.serialize(config))
		meta:set_string('description', build_tool_description(wield_item, config))
		player:set_wielded_item(wield_item)
	end)

	Form.on_generate(function(form, config)
		local top_position = form:player():get_pos()
		Logger.action('use mount stick at ' .. minetest.pos_to_string(top_position))
		Logger.action('parameters: ' .. dump(config))
		Generator:new(top_position, config):run()
	end)
end


return {
	register_stick = register_stick
}
