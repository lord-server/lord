minetest.clear_craft({output = "hopper:hopper"})

minetest.register_craft({
	output = "hopper:hopper",
	recipe = {
		{"lottores:lead_ingot", "carts:gear",  "lottores:lead_ingot"},
		{"lottores:lead_ingot", "default:chest", "lottores:lead_ingot"},
		{"", "lottores:lead_ingot", ""}
	}
})

minetest.register_craft({
	output = "hopper:hopper",
	recipe = {{"hopper:hopper_side"}}
})

minetest.clear_craft({output = "hopper:hopper_void"})

-- TODO: for future
-- minetest.register_craft({
-- 	output = "hopper:hopper_void",
-- 	recipe = {
-- 		{"lottores:lead_ingot", "carts:steam_mechanism",  "lottores:lead_ingot"},
-- 		{"lottores:lead_ingot", "default:chest", "lottores:lead_ingot"},
-- 		{"", "lottores:mithril_block", ""}
-- 	}
-- })

hopper:add_container({
	-- ### protector_lott ###
	{"void", "protector_lott:chest", "main"},
	{"bottom", "protector_lott:chest", "main"},
	{"side", "protector_lott:chest", "main"},

	-- ### technic_chests ###
	{"top", "technic:copper_chest",  "main"},
	{"top", "technic:iron_chest",    "main"},
	{"top", "technic:silver_chest",  "main"},
	{"top", "technic:gold_chest",    "main"},
	{"top", "technic:mithril_chest", "main"},

	{"side", "technic:copper_chest",  "main"},
	{"side", "technic:iron_chest",    "main"},
	{"side", "technic:silver_chest",  "main"},
	{"side", "technic:gold_chest",    "main"},
	{"side", "technic:mithril_chest", "main"},

	{"bottom", "technic:copper_chest",  "main"},
	{"bottom", "technic:iron_chest",    "main"},
	{"bottom", "technic:silver_chest",  "main"},
	{"bottom", "technic:gold_chest",    "main"},
	{"bottom", "technic:mithril_chest", "main"},

	{"void", "technic:copper_chest",  "main"},
	{"void", "technic:iron_chest",    "main"},
	{"void", "technic:silver_chest",  "main"},
	{"void", "technic:gold_chest",    "main"},
	{"void", "technic:mithril_chest", "main"},

	-- locked: only input
	{"side", "technic:copper_locked_chest",  "main"},
	{"side", "technic:iron_locked_chest",    "main"},
	{"side", "technic:silver_locked_chest",  "main"},
	{"side", "technic:gold_locked_chest",    "main"},
	{"side", "technic:mithril_locked_chest", "main"},

	{"bottom", "technic:copper_locked_chest",  "main"},
	{"bottom", "technic:iron_locked_chest",    "main"},
	{"bottom", "technic:silver_locked_chest",  "main"},
	{"bottom", "technic:gold_locked_chest",    "main"},
	{"bottom", "technic:mithril_locked_chest", "main"},

	{"void", "technic:copper_locked_chest",  "main"},
	{"void", "technic:iron_locked_chest",    "main"},
	{"void", "technic:silver_locked_chest",  "main"},
	{"void", "technic:gold_locked_chest",    "main"},
	{"void", "technic:mithril_locked_chest", "main"},

	-- ### workbench ###
	{"void", "workbench:workbench", "src"},
	{"bottom", "workbench:workbench", "src"},
	{"side", "workbench:workbench", "src"},
	{"top", "workbench:workbench", "dst"},

	-- ### bees ###
	{"void", "bees:extractor", "frames_filled"},
	{"bottom", "bees:extractor", "frames_filled"},
	{"side", "bees:extractor", "bottles_empty"},
	{"top", "bees:extractor", "wax"},
	{"top", "bees:extractor", "bottles_full"},
	{"top", "bees:extractor", "frames_emptied"},

	-- ### laboratory ###
	{"void", "laboratory:laboratory",        "src"},
	{"void", "laboratory:laboratory_active", "src"},
	{"bottom", "laboratory:laboratory",        "src"},
	{"bottom", "laboratory:laboratory_active", "src"},
	{"side", "laboratory:laboratory",        "fuel"},
	{"side", "laboratory:laboratory_active", "fuel"},
	{"top", "laboratory:laboratory",        "dst"},
	{"top", "laboratory:laboratory_active", "dst"},

	-- ### barrel ###
	{"void", "barrel:barrel",        "src"},
	{"void", "barrel:barrel_active", "src"},
	{"bottom", "barrel:barrel",        "src"},
	{"bottom", "barrel:barrel_active", "src"},
	{"side", "barrel:barrel",        "fuel"},
	{"side", "barrel:barrel_active", "fuel"},
	{"top", "barrel:barrel",        "dst"},
	{"top", "barrel:barrel_active", "dst"},

	-- ### grinder ###
	{"void", "grinder:grinder",        "src"},
	{"void", "grinder:grinder_active", "src"},
	{"bottom", "grinder:grinder",        "src"},
	{"bottom", "grinder:grinder_active", "src"},
	{"side", "grinder:grinder",        "fuel"},
	{"side", "grinder:grinder_active", "fuel"},
	{"top", "grinder:grinder",        "dst"},
	{"top", "grinder:grinder_active", "dst"},

	-- ### lord_money ###
	{"void", "lord_money:shop", "stock"},
	{"bottom", "lord_money:shop", "stock"},
	{"side", "lord_money:shop", "stock"},
	{"top", "lord_money:shop", "customers_gave"},
})
