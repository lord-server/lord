local api = require("planks.api")


local function register_api()
	_G.planks = api
end

local function register_lord_planks()
	--- Also we use:
	---  - Apple tree planks from MTG (default:wood)
	---  - Jungle tree planks from MTG (default:junglewood)
	api.add_existing("default:wood")
	api.add_existing("default:junglewood")

	for trunk_name, trunk in pairs(tree.trunks.get_nodes()) do
		local planks_name = trunk_name:replace("^lord_trees:", "lord_planks:"):replace("_tree$", "")
		api.register_planks(planks_name, trunk.groups.choppy or 2, trunk_name)
		-- bin/minetest --info 2>&1 | grep 'use node'
		minetest.log("info", "use node: " .. trunk_name .. " at " .. __FILE_LINE__())
	end

	api.register_planks("lord_planks:hardwood",  1, nil, { flammable = 1 })
end

local function register_additional_crafts()
	-- additional craft from young mallorn
	minetest.register_craft({
		output = 'lord_planks:mallorn 2',
		recipe = {
			{ 'lord_trees:mallorn_young_tree' },
		}
	})
	-- different crafts for hardwood
	minetest.register_craft({
		output = 'lord_planks:hardwood 2',
		recipe = {
			{"default:wood", "default:junglewood"},
			{"default:junglewood", "default:wood"},
		}
	})
	minetest.register_craft({
		output = 'lord_planks:hardwood 2',
		recipe = {
			{"default:junglewood", "default:wood"},
			{"default:wood", "default:junglewood"},
		}
	})

	-- hardwood burned slower, than group:wood
	minetest.register_craft({
		type = "fuel",
		recipe = "lord_planks:hardwood",
		burntime = 28,
	})
end


return {
	init = function()
		register_api()
		register_lord_planks()
		register_additional_crafts()
	end,
}
