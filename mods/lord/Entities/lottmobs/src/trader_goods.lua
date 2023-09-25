--Item table format:
--{thing selling, price (in gold ingots), chance that it won't appear in the trader's inventory}
local SL        = minetest.get_translator("lottmobs")

--- @class TraderConfig
--- @field items    table<string,{price:string,chance:number}> key: stack_string, price: stack_string, chance: percent
--- @field names    string[] random names for traders
--- @field messages string[] random messages for traders

--- @type TraderConfig[]
local trader_config = {}

--- @type TraderConfig
trader_config.dwarf  = {
	items      = {
		["lord_money:gold_coin 1"]          = { price = "lord_money:silver_coin 10", chance = 5 },
		["lord_money:silver_coin 1"]        = { price = "lord_money:copper_coin 10", chance = 5 },
		["lord_money:silver_coin 10"]       = { price = "lord_money:gold_coin 1",    chance = 5 },
		["lord_money:copper_coin 10"]       = { price = "lord_money:silver_coin 1",  chance = 5 },
		["lottthrowing:crossbow_silver 1"]  = { price = "lord_money:silver_coin 9",  chance = 15 },
		["lottarmor:chestplate_mithril 1"]  = { price = "lord_money:silver_coin 75", chance = 50 },
		["default:steel_ingot 99"]          = { price = "lord_money:silver_coin 20", chance = 12 },
		["tools:sword_silver 1"]            = { price = "lord_money:silver_coin 7",  chance = 10 },
		["default:bronze_ingot 25"]         = { price = "lord_money:silver_coin 5",  chance = 15 },
		["lottblocks:small_lamp_pine 6"]    = { price = "lord_money:silver_coin 2",  chance = 6 },
		["lottblocks:dwarf_harp 1"]         = { price = "lord_money:silver_coin 15", chance = 10 },
		["tools:dagger_mithril 1"]          = { price = "lord_money:silver_coin 15", chance = 20 },
		["tools:sword_mithril 1"]           = { price = "lord_money:silver_coin 35", chance = 30 },
		["tools:sword_steel 1"]             = { price = "lord_money:silver_coin 5",  chance = 10 },
		["tools:battleaxe_silver 1"]        = { price = "lord_money:silver_coin 10", chance = 18 },
		["lottblocks:dwarfstone_stripe 50"] = { price = "lord_money:silver_coin 17", chance = 12 },
		["lottblocks:dwarfstone_black 99"]  = { price = "lord_money:silver_coin 33", chance = 17 },
		["default:stonebrick 99"]           = { price = "lord_money:silver_coin 25", chance = 14 },
		["lottblocks:dwarfstone_white 99"]  = { price = "lord_money:silver_coin 33", chance = 17 },
	},
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
--- @type TraderConfig
trader_config.elf    = {
	items      = {
		["lord_money:gold_coin 1"]         = { price = "lord_money:silver_coin 10", chance = 5 },
		["lord_money:silver_coin 1"]       = { price = "lord_money:copper_coin 10", chance = 5 },
		["lord_money:silver_coin 10"]      = { price = "lord_money:gold_coin 1",    chance = 5 },
		["lord_money:copper_coin 10"]      = { price = "lord_money:silver_coin 1",  chance = 5 },
		["lottplants:mallorntree 10"]      = { price = "lord_money:silver_coin 4",  chance = 5 },
		["lottores:rough_rock 4"]          = { price = "lord_money:silver_coin 30", chance = 17 },
		["lottother:blue_torch 10"]        = { price = "lord_money:silver_coin 20", chance = 15 },
		["tools:spear_galvorn 1"]          = { price = "lord_money:silver_coin 25", chance = 20 },
		["tools:battleaxe_silver 1"]       = { price = "lord_money:silver_coin 18", chance = 14 },
		["tools:sword_galvorn 1"]          = { price = "lord_money:silver_coin 25", chance = 25 },
		["lottplants:elanor 10"]           = { price = "lord_money:silver_coin 2",  chance = 22 },
		["lottarmor:chestplate_galvorn 1"] = { price = "lord_money:silver_coin 40", chance = 25 },
		["lottarmor:helmet_galvorn 1"]     = { price = "lord_money:silver_coin 30", chance = 25 },
		["lottarmor:boots_galvorn 1"]      = { price = "lord_money:silver_coin 25", chance = 25 },
		["lottarmor:leggings_galvorn 1"]   = { price = "lord_money:silver_coin 35", chance = 25 },
		["lottplants:niphredil 12"]        = { price = "lord_money:silver_coin 3",  chance = 14 },
		["lottblocks:mallorn_pillar 30"]   = { price = "lord_money:silver_coin 7",  chance = 4 },
		["lottplants:mallornsapling 3"]    = { price = "lord_money:silver_coin 2",  chance = 17 },
		["lottplants:mallornwood 99"]      = { price = "lord_money:silver_coin 10", chance = 5 },
	},
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
--- @type TraderConfig
trader_config.hobbit = {
	items = {
		["lord_money:gold_coin 1"]         = { price = "lord_money:silver_coin 10", chance = 5 },
		["lord_money:silver_coin 1"]       = { price = "lord_money:copper_coin 10", chance = 5 },
		["lord_money:silver_coin 10"]      = { price = "lord_money:gold_coin 1",    chance = 5 },
		["lord_money:copper_coin 10"]      = { price = "lord_money:silver_coin 1",  chance = 5 },
		["lottfarming:pipe 1"]             = { price = "lord_money:silver_coin 2",  chance = 5 },
		["lottfarming:pipeweed_cooked 50"] = { price = "lord_money:silver_coin 17", chance = 10 },
		["lottpotion:beer 10"]             = { price = "lord_money:silver_coin 7",  chance = 8 },
		["lottpotion:cider 15"]            = { price = "lord_money:silver_coin 11", chance = 13 },
		["lottpotion:wine 8"]              = { price = "lord_money:silver_coin 18", chance = 14 },
		["lottfarming:tomatoes 25"]        = { price = "lord_money:silver_coin 23", chance = 25 },
		["lottfarming:potato 30"]          = { price = "lord_money:silver_coin 10", chance = 22 },
		["lottfarming:brown_mushroom 40"]  = { price = "lord_money:silver_coin 40", chance = 25 },
		["lottfarming:corn_seed 12"]       = { price = "lord_money:silver_coin 30", chance = 25 },
		["farming:hoe_bronze 1"]           = { price = "lord_money:silver_coin 25", chance = 25 },
		["lord_books:brewing_book 1"]      = { price = "lord_money:silver_coin 35", chance = 25 },
		["lottfarming:barley_seed 5"]      = { price = "lord_money:silver_coin 3",  chance = 14 },
		["lottfarming:berries 15"]         = { price = "lord_money:silver_coin 7",  chance = 4 },
		["lottplants:firsapling 2"]        = { price = "lord_money:silver_coin 2",  chance = 17 },
		["default:apple 10"]               = { price = "lord_money:silver_coin 10", chance = 5 },
	},
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
--- @type TraderConfig
trader_config.human  = {
	items      = {
		["lord_money:gold_coin 1"]        = { price = "lord_money:silver_coin 10", chance = 5 },
		["lord_money:silver_coin 1"]      = { price = "lord_money:copper_coin 10", chance = 5 },
		["lord_money:silver_coin 10"]     = { price = "lord_money:gold_coin 1",    chance = 5 },
		["lord_money:copper_coin 10"]     = { price = "lord_money:silver_coin 1",  chance = 5 },
		["default:sandstone 40"]          = { price = "lord_money:silver_coin 10", chance = 12 },
		["boats:sail_boat 1"]             = { price = "lord_money:silver_coin 4",  chance = 14 },
		["lottarmor:shield_bronze 1"]     = { price = "lord_money:silver_coin 20", chance = 20 },
		["farming:bread 12"]              = { price = "lord_money:silver_coin 2",  chance = 5 },
		["lottblocks:marble_brick 35"]    = { price = "lord_money:silver_coin 12", chance = 10 },
		["default:desert_stone 30"]       = { price = "lord_money:silver_coin 8",  chance = 12 },
		["lottblocks:lamp_alder 5"]       = { price = "lord_money:silver_coin 4",  chance = 8 },
		["lottarmor:chestplate_bronze 1"] = { price = "lord_money:silver_coin 30", chance = 30 },
		["lottarmor:boots_bronze 1"]      = { price = "lord_money:silver_coin 12", chance = 18 },
		["lottblocks:lamp_lebethron 7"]   = { price = "lord_money:silver_coin 6",  chance = 11 },
		["lottblocks:door_alder 6"]       = { price = "lord_money:silver_coin 2",  chance = 18 },
		["lottores:marble 99"]            = { price = "lord_money:silver_coin 33", chance = 18 },
		["lottarmor:helmet_bronze 1"]     = { price = "lord_money:silver_coin 20", chance = 24 },
		["default:brick 30"]              = { price = "lord_money:silver_coin 10", chance = 17 },
		["lottarmor:leggings_bronze 1"]   = { price = "lord_money:silver_coin 25", chance = 34 },
	},
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
