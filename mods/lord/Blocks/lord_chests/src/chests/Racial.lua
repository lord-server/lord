local S = minetest.get_mod_translator()
local Logger = minetest.get_mod_logger()


--- @static
--- @class chests.Racial
local Racial = {
	--- @public
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {},
}

--- @public
--- @static
--- @param node_name    string technical node name ('<mod>:<node>').
--- @param title        string node title
--- @param texture_type string uses as name part for textures & icon. See `chests.config.Racial` class description
--- @param race         string which race can open this chest.
--- @param craft        string|table node name to craft from, or table with own recipe.
--- @see chests.config.Racial
function Racial.register(node_name, title, texture_type, race, craft)
	local mod_name = node_name:split(':')[1]
	local texture_prefix = mod_name .. '_racial_' .. texture_type
	local form_icon = texture_type .. '_chest_form-icon.png'

	-- bin/minetest --info 2>&1 | grep 'use texture'
	Logger.info('use texture: ' .. texture_prefix .. '_top.png at ' .. __FILE_LINE__())
	Logger.info('use texture: ' .. texture_prefix .. '_bottom.png at ' .. __FILE_LINE__())
	Logger.info('use texture: ' .. texture_prefix .. '_front.png at ' .. __FILE_LINE__())
	Logger.info('use texture: ' .. texture_prefix .. '_side.png at ' .. __FILE_LINE__())
	Logger.info('use texture: ' .. form_icon .. ' at ' .. __FILE_LINE__())

	minetest.register_node(node_name, {
		description           = title,
		tiles                 = {
			texture_prefix .. '_top.png',
			texture_prefix .. '_bottom.png',
			texture_prefix .. '_side.png',
			texture_prefix .. '_side.png',
			texture_prefix .. '_side.png',
			texture_prefix .. '_front.png',
		},
		paramtype2            = 'facedir',
		groups                = { choppy = 2, flammable = 3, wooden = 1, chest = 1 },
		legacy_facedir_simple = true,
		is_ground_content     = false,
		sounds                = default.node_sound_wood_defaults(),
		on_construct          = function(pos, node, active_object_count, active_object_count_wider)
			local meta = minetest.get_meta(pos)
			meta:set_string('infotext', title)
			local inv = meta:get_inventory()
			inv:set_size('main', 8 * 4)
		end,
		on_rightclick         = function(pos, node, clicker, itemstack)
			local player_name           = clicker:get_player_name()
			local opened, expected_race = races.can_open_stuff(race, clicker, itemstack)
			if opened then
				minetest.show_formspec(player_name, node_name, default.chest.get_chest_formspec(pos, nil, form_icon))
			elseif expected_race ~= nil then
				minetest.chat_send_player(player_name, S('Only @1 can open this kind of chest!', expected_race))
			end
		end,
		can_dig               = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv  = meta:get_inventory()
			return inv:is_empty('main')
		end,
		on_punch              = function(pos, player)
			local meta = minetest.get_meta(pos)
			meta:set_string('infotext', title)
			meta:set_string('formspec', '')
		end,
	})

	Racial.nodes[node_name]      = minetest.registered_nodes[node_name]

	local recipe = type(craft) == 'string'
		and {
			{ craft, craft, craft },
			{ craft, '', craft },
			{ craft, craft, craft },
		}
		or (type(craft) == 'table'
			and craft
			or  nil
		)

	if recipe then
		minetest.register_craft({ output = node_name, recipe = recipe, })
	end
end


return Racial
