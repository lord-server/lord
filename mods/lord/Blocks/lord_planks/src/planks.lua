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

	-- TODO: ??? for _, trunk in pairs(tree.trunks.get_nodes()) do ??? if possible
	api.register_planks("lord_planks:alder",     2, "lord_trees:alder_tree")
	api.register_planks("lord_planks:birch",     3, "lord_trees:birch_tree")
	api.register_planks("lord_planks:beech",     2, "lord_trees:beech_tree")
	api.register_planks("lord_planks:cherry",    3, "lord_trees:cherry_tree")
	api.register_planks("lord_planks:culumalda", 3, "lord_trees:culumalda_tree")
	api.register_planks("lord_planks:elm",       2, "lord_trees:elm_tree")
	api.register_planks("lord_planks:fir",       3, "lord_trees:fir_tree")
	api.register_planks("lord_planks:hardwood",  1, nil, { flammable = 1 })
	api.register_planks("lord_planks:lebethron", 1, "lord_trees:lebethron_tree")
	api.register_planks("lord_planks:mallorn",   1, "lord_trees:mallorn_tree")
	api.register_planks("lord_planks:pine",      3, "lord_trees:pine_tree")
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
