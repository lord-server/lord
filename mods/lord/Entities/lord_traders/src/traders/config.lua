local SL = minetest.get_translator("lord_traders")

--- @class traders.config
--- @field goods    table<string,traders.config.good> key: stack_string, value: {price: stack_string, chance: percent}
--- @field names    string[] random names for traders
--- @field messages string[] random messages for traders

--- @class traders.config.good
--- @field price  string     stack_string
--- @field chance number|nil percent
--- @field stock  number|nil count of times of trades

--- @type traders.config[]
local trader_config = {}

--- @type table<string,traders.config.good>
trader_config.common_goods = {
	["lord_money:gold_coin 1"]    = { price = "lord_money:silver_coin 10", },
	["lord_money:silver_coin 1"]  = { price = "lord_money:copper_coin 10", },
	["lord_money:silver_coin 10"] = { price = "lord_money:gold_coin 1", },
	["lord_money:copper_coin 10"] = { price = "lord_money:silver_coin 1", },
}

--- @type traders.config
trader_config.dwarf  = {
	goods      = table.merge(trader_config.common_goods, {
		["lottthrowing:crossbow_silver 1"]  = { price = 90,  chance = 15, stock = 1 },
		["lottarmor:chestplate_mithril 1"]  = { price = 750, chance = 50, stock = 1 },
		["default:steel_ingot 99"]          = { price = 200, chance = 12, stock = 1 },
		["tools:sword_silver 1"]            = { price = 70,  chance = 10, stock = 1 },
		["default:bronze_ingot 25"]         = { price = 50,  chance = 15, stock = 1 },
		["lottblocks:small_lamp_pine 6"]    = { price = 20,  chance = 6,  stock = 1 },
		["lottblocks:dwarf_harp 1"]         = { price = 150, chance = 10, stock = 1 },
		["tools:dagger_mithril 1"]          = { price = 150, chance = 20, stock = 1 },
		["tools:sword_mithril 1"]           = { price = 350, chance = 30, stock = 1 },
		["tools:sword_steel 1"]             = { price = 50,  chance = 10, stock = 1 },
		["tools:battleaxe_silver 1"]        = { price = 100, chance = 18, stock = 1 },
		["lottblocks:dwarfstone_stripe 50"] = { price = 170, chance = 12, stock = 1 },
		["lottblocks:dwarfstone_black 99"]  = { price = 330, chance = 17, stock = 1 },
		["default:stonebrick 99"]           = { price = 250, chance = 14, stock = 1 },
		["lottblocks:dwarfstone_white 99"]  = { price = 330, chance = 17, stock = 1 },
	}),
	names      = {
		"Azaghâl", "Balbrin", "Borin", "Farin", "Flói", "Frerin",
		"Grór", "Lóni", "Náli", "Narvi", "Telchar", "Thion"
	},
	messages   = {
		SL("We have many treasures, and for the right price we might be willing to part with them..."),
		SL("Don't even think of stealing our treasure... If you do, heads shall roll."),
		SL("What are you doing here? What do you want from us?"),
		SL("Be careful when you enter our homes, a fall from the ladder could well prove deadly."),
		SL("If you want to mine, do so. There's plenty of iron to go around!"),
		SL("If you venture deep underground, beware! The monsters there are very powerful, and kill the unprepared instantly."), -- luacheck: no_max_line_length
	}
}
--- @type traders.config
trader_config.elf    = {
	goods      = table.merge(trader_config.common_goods, {
		["lottplants:mallorntree 10"]      = { price = 40,  chance = 5,  stock = 1 },
		["lottores:rough_rock 4"]          = { price = 300, chance = 17, stock = 1 },
		["lottother:blue_torch 10"]        = { price = 200, chance = 15, stock = 1 },
		["tools:spear_galvorn 1"]          = { price = 250, chance = 20, stock = 1 },
		["tools:battleaxe_silver 1"]       = { price = 180, chance = 14, stock = 1 },
		["tools:sword_galvorn 1"]          = { price = 250, chance = 25, stock = 1 },
		["lottplants:elanor 10"]           = { price = 20,  chance = 22, stock = 1 },
		["lottarmor:chestplate_galvorn 1"] = { price = 400, chance = 25, stock = 1 },
		["lottarmor:helmet_galvorn 1"]     = { price = 300, chance = 25, stock = 1 },
		["lottarmor:boots_galvorn 1"]      = { price = 250, chance = 25, stock = 1 },
		["lottarmor:leggings_galvorn 1"]   = { price = 350, chance = 25, stock = 1 },
		["lottplants:niphredil 12"]        = { price = 30,  chance = 14, stock = 1 },
		["lottblocks:mallorn_pillar 30"]   = { price = 70,  chance = 4,  stock = 1 },
		["lottplants:mallornsapling 3"]    = { price = 20,  chance = 17, stock = 1 },
		["lottplants:mallornwood 99"]      = { price = 100, chance = 5,  stock = 1 },
	}),
	names      = {
		"Annael", "Anairë", "Curufin", "Erestor", "Gwindor", "Irimë",
		"Oropher", "Maglor", "Quennar", "Rúmil", "Orgof", "Voronwë"
	},
	messages   = {
		SL("Welcome to our lovely forest home, weary traveler. Refresh yourself here."),
		SL("Sauron grows in power. Shall we be able to vanquish him again?"),
		SL("We are a peace loving people, but if we are angered, our wrath is terrible!"),
		SL("Rest among us and prepare yourself, for war is imminent."),
		SL("If you wish to buy goods from us, there are certain traders who wander our land."),
		SL("Beware! Our society, and all societies, are on the edge of a knife blade - one false move and all will end, and Sauron will rule supreme."), -- luacheck: no_max_line_length
	}
}
--- @type traders.config
trader_config.hobbit = {
	goods = table.merge(trader_config.common_goods, {
		["lottfarming:pipe 1"]             = { price = 20,  chance = 5,  stock = 1 },
		["lottfarming:pipeweed_cooked 50"] = { price = 170, chance = 10, stock = 1 },
		["lottpotion:beer 10"]             = { price = 70,  chance = 8,  stock = 1 },
		["lottpotion:cider 15"]            = { price = 110, chance = 13, stock = 1 },
		["lottpotion:wine 8"]              = { price = 180, chance = 14, stock = 1 },
		["lottfarming:tomatoes 25"]        = { price = 230, chance = 25, stock = 1 },
		["lottfarming:potato 30"]          = { price = 100, chance = 22, stock = 1 },
		["lottfarming:brown_mushroom 40"]  = { price = 400, chance = 25, stock = 1 },
		["lottfarming:corn_seed 12"]       = { price = 300, chance = 25, stock = 1 },
		["farming:hoe_bronze 1"]           = { price = 250, chance = 25, stock = 1 },
		["lord_books:brewing_book 1"]      = { price = 350, chance = 25, stock = 1 },
		["lottfarming:barley_seed 5"]      = { price = 30,  chance = 14, stock = 1 },
		["lottfarming:berries 15"]         = { price = 70,  chance = 4,  stock = 1 },
		["lottplants:firsapling 2"]        = { price = 20,  chance = 17, stock = 1 },
		["default:apple 10"]               = { price = 100, chance = 5,  stock = 1 },
	}),
	names      = {
		"Adalgrim", "Bodo", "Cotman", "Doderic", "Falco", "Gormadoc",
		"Hobson", "Ilberic", "Largo", "Madoc", "Orgulas", "Rorimac"
	},
	messages   = {
		SL("Ah, what a lovely land we have, so peaceful, so beautiful."),
		SL("There's nothing quite like the smell of pipe smoke rising on a cold October morning, is there?"),
		SL("If you are in need of any food, there are traders who wander around and they usually have a good stock."),
		SL("If you are thinking that you'll find adventures here, think again! Good day!"),
		SL("We hear tales of war, but they cannot be more than tales - like that of the Oliphaunt."),
		SL("Food is meant to be enjoyed, not rushed. Don't just eat a little here and a little there, sit down for a proper meal sometimes..."), -- luacheck: no_max_line_length
	}
}
--- @type traders.config
trader_config.man  = {
	goods      = table.merge(trader_config.common_goods, {
		["default:sandstone 40"]          = { price = 100, chance = 12, stock = 1 },
		["lord_boats:sail_boat 1"]             = { price = 40,  chance = 14, stock = 1 },
		["lottarmor:shield_bronze 1"]     = { price = 200, chance = 20, stock = 1 },
		["farming:bread 12"]              = { price = 20,  chance = 5,  stock = 1 },
		["lottblocks:marble_brick 35"]    = { price = 120, chance = 10, stock = 1 },
		["default:desert_stone 30"]       = { price = 80,  chance = 12, stock = 1 },
		["lottblocks:lamp_alder 5"]       = { price = 40,  chance = 8,  stock = 1 },
		["lottarmor:chestplate_bronze 1"] = { price = 300, chance = 30, stock = 1 },
		["lottarmor:boots_bronze 1"]      = { price = 120, chance = 18, stock = 1 },
		["lottblocks:lamp_lebethron 7"]   = { price = 60,  chance = 11, stock = 1 },
		["lottblocks:door_alder 6"]       = { price = 20,  chance = 18, stock = 1 },
		["lottores:marble 99"]            = { price = 330, chance = 18, stock = 1 },
		["lottarmor:helmet_bronze 1"]     = { price = 200, chance = 24, stock = 1 },
		["default:brick 30"]              = { price = 100, chance = 17, stock = 1 },
		["lottarmor:leggings_bronze 1"]   = { price = 250, chance = 34, stock = 1 },
	}),
	names      = {
		"Aratan", "Arvegil", "Belegorn", "Celepharn", "Dúnhere", "Elatan",
		"Gilraen", "Írimon", "Minardil", "Oromendil", "Tarcil", "Vorondil"
	},
	messages   = {
		SL("War comes swiftly... We are preparing, but are we doing enough?"),
		SL("The noble race of man rises in the world! Even the dwarves are starting to show interest in some of our goods."),
		SL("Are you willing to fight with us? We have much to lose, but much to gain also! We must rally together."),
		SL("Don't listen to those who say that all this talk of war will come to nothing, for we are at war now."),
		SL("We suffer raids from orcs, and other evil things, yet we do nothing! We must act, and act with force!"),
		SL("Life here is far from normal. We wish for peace, yet the only way we can get peace is through war..."),
	}
}
trader_config.orc    = {
	names    = {
		"Azog", "Balcmeg", "Boldog", "Bolg", "Golfimbul", "Gorbag", "Gorgol",
		"Grishnákh", "Lagduf", "Lug", "Lugdush", "Mauhúr", "Muzgash", "Orcobal",
		"Othrod", "Radbug", "Shagrat", "Ufthak", "Uglúk"
	},
	messages = {
		SL("DIE!!!, Urrrrrrrrrrrrrghhhhhhhhhhhhhhhhhhh!!"),
		SL("Arrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!, KILL! KILL! KILL!")
	},
}

return trader_config
