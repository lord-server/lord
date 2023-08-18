ghost = {}

function ghost.make_ghost_name(name)
	return "defaults:"..string.gsub(name, ":", "_")
end

function ghost.register_ghost_material(name)
	local orig_node = minetest.registered_nodes[name]

	if orig_node == nil then
		minetest.log("error", "Unknown original node")
	end

	if (orig_node.groups ~= nil and orig_node.groups.ghostly ~= nil) then
		-- эта нода уже призрачная
		return
	end

	local orig_name = orig_node.name
	local ghost_name = ghost.make_ghost_name(orig_name)

	if minetest.registered_nodes[ghost_name] ~= nil then
		-- уже зарегали
		return
	end

	local node = table.copy(orig_node)

	node.name = ghost_name
	node.walkable = false
	if node.description ~= nil then
		node.description = "Ghost "..node.description
	end
	if node.groups == nil then
		node.groups = {}
	end
	node.groups.not_in_creative_inventory = 1
	node.groups.ghostly = 1
	-- for replace ABM
	-- New stairs has no "upside_down" nodes variant anymore,
	-- but mod have ABM to replace old ones with group `slabs_replace` to new ones with name `replace_name`.
	-- So old ghost "upside_down" stairs need to be replaced to new ghost stairs.
	if node.groups.slabs_replace then
		node.replace_name = ghost_name:gsub("upside_down", "")
	end
	if type(node.drop) == "string" then
		node.drop = {
			maxitems = 1,
			items = {
				{items = {node.drop, 'default:mese_crystal 8'}},
			}
		}
	elseif type(node.drop) == "table" then
		-- TODO: add mese to table
		node.drop = {
			maxitems = 1,
			items = {
				{items = {orig_name, 'default:mese_crystal 8'}},
			}
		}
	else
		node.drop = {
			maxitems = 1,
			items = {
				{items = {orig_name, 'default:mese_crystal 8'}},
			}
		}
	end
	minetest.register_node(ghost_name, node)
end


ghost.has_crystals = function(crystalstack)
	if (crystalstack:get_count() < 8) then
		return false
	end
	local item_name = crystalstack:get_name()
	if (item_name ~= "default:mese_crystal") then
		return false
	end
	return true
end


minetest.register_tool("defaults:ghost_tool", {
	description = "Призрачный посох",
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, user, pointed_thing)
		local pt = pointed_thing
		local creative = minetest.is_creative_enabled(user)
		local USES=152

		if (pt.type == "node") then
			local node = minetest.get_node(pt.under)
			local pos  = pt.under

			if minetest.is_protected(pos, user:get_player_name()) then
				minetest.record_protection_violation(pos, user:get_player_name())
				return
			end

			local name = node.name
			local ghost_name = ghost.make_ghost_name(name)
			if minetest.registered_nodes[ghost_name] == nil then
				minetest.log("action", "can not convert node "..name.." to ghost")
				return itemstack
			end
			if (not creative) then
				local crystalstack = user:get_inventory():get_stack("main", user:get_wield_index()+1)
				if (ghost.has_crystals(crystalstack) == false) then
					return itemstack
				end
				node.name = ghost_name
				minetest.swap_node(pos, node)
				crystalstack:take_item(8);
				user:get_inventory():set_stack("main", user:get_wield_index()+1, crystalstack)
				itemstack:add_wear(65535 / (USES - 1))
			else
				minetest.remove_node(pos)
				minetest.add_node(pos, {name=ghost_name})
			end
		end


		return itemstack
	end
})

minetest.register_craft({
	output = "defaults:ghost_tool",
	recipe = {
		{"default:mese_crystal"},
		{"lottother:ringsilver_ingot"},
		{"lottother:ringsilver_ingot"},
	},
})


local forbidden_groups = { "ghostly", "door", }
local accepted_groups = {
	"stone", "tree", "wood", "leaves", "cracky", "crumbly", "wool", "need_ghost_variant", "slabs_replace",
}

-- TODO: move into helpers, use something like "table:containsOneOf()"
--- @param node_definition NodeDefinition
local function has_forbidden_group(node_definition)
	for _, g in ipairs(forbidden_groups) do
		if node_definition.groups[g] ~= nil then
			return true
		end
	end
	return false
end
--- @param node_definition NodeDefinition
local function has_accepted_group(node_definition)
	for _, g in ipairs(accepted_groups) do
		if node_definition.groups[g] ~= nil then
			return true
		end
	end
	return false
end

local now_registered_nodes = table.copy(minetest.registered_nodes)
for name, def in pairs(now_registered_nodes) do
	if def.groups ~= nil then
		if not has_forbidden_group(def) and has_accepted_group(def) then
			ghost.register_ghost_material(name)
		end
	end
end
