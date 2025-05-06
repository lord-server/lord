

--- @class icicles.Nodes
local Nodes = {}

--- @private
--- @static
--- @param rock_name       string         tech name of rock node.
--- @param rock_definition NodeDefinition node definition of rock.
--- @return string
function Nodes.get_drop_item(rock_name, rock_definition)
	--- @type string|table
	local drop = rock_definition.drop

	if not drop then
		return rock_name
	elseif type(drop) == 'string' then
		return drop
	elseif type(drop) == 'table' and drop.items and drop.items.items and drop.items.items[1] then
		return type(drop.items.items[1]) == 'string'
			and drop.items.items[1]
			or  rock_name
	end
end

--- @static
--- @param rock_name string tech name of material node
function Nodes.register(rock_name)
	local rock_definition = minetest.registered_nodes[rock_name]
	assert(rock_definition and type(rock_definition) == 'table', 'undefined rock: ' .. rock_name)


	local node_name_prefix = 'icicles:' .. rock_name:replace(':', '_')
	for i = 1, 4 do
		minetest.register_node(node_name_prefix .. '_' .. i, {
			description       = 'Icicle ' .. i,
			groups            = {
				cracky = 3, icicle = 1, oddly_breakable_by_hand = 4 - i, drop_on_dig = 1, attached_node = 1
			},
			tiles             = rock_definition.tiles,
			is_ground_content = true,
			sounds            = rock_definition.sounds,
			drop              = {
				max_items = 1,
				items     = {
					{
						items  = { Nodes.get_drop_item(rock_name, rock_definition) },
						rarity = 5 - i,
					},
				},
			},
			drawtype          = 'nodebox',
			paramtype         = 'light',
			paramtype2        = 'wallmounted',
			node_box          = {
				type  = 'fixed',
				fixed = { -i / 10, -0.5, -i / 10, i / 10, 0.5, i / 10 }
			},
			selection_box     = {
				type  = 'fixed',
				fixed = { -i / 10, -0.5, -i / 10, i / 10, 0.5, i / 10 }
			},
		})
	end
end


return Nodes
