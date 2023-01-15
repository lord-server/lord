--Item table format:
--{thing selling, price (in gold ingots), chance that it won't appear in the trader's inventory}
local SL = lord.require_intllib()


lottmobs.dwarf = {
	items = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10", 5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10", 5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1", 5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1",	5},
		{"lottthrowing:crossbow_silver 1",	"lord_money:silver_coin 9",	15},
		{"lottarmor:chestplate_mithril 1",	"lord_money:silver_coin 75", 50},
		{"default:steel_ingot 99",			"lord_money:silver_coin 20", 12},
		{"tools:sword_silver 1",			"lord_money:silver_coin 7",	10},
		{"default:bronze_ingot 25",			"lord_money:silver_coin 5",	15},
		{"lottblocks:small_lamp_pine 6",	"lord_money:silver_coin 2",	6},
		{"lottblocks:dwarf_harp 1",			"lord_money:silver_coin 15", 10},
		{"tools:dagger_mithril 1",	"lord_money:silver_coin 15", 20},
		{"tools:sword_mithril 1",			"lord_money:silver_coin 35", 30},
		{"tools:sword_steel 1",			"lord_money:silver_coin 5",	10},
		{"tools:battleaxe_silver 1",	"lord_money:silver_coin 10", 18},
		{"lottblocks:dwarfstone_stripe 50",	"lord_money:silver_coin 17", 12},
		{"lottblocks:dwarfstone_black 99",	"lord_money:silver_coin 33", 17},
		{"default:stonebrick 99",			"lord_money:silver_coin 25", 14},
		{"lottblocks:dwarfstone_white 99",	"lord_money:silver_coin 33", 17},
	},
	items_race = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10", 5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10", 5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1", 5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1",	5},
		{"lottthrowing:crossbow_silver 1",	"lord_money:silver_coin 7",	15},
		{"lottarmor:chestplate_mithril 1",	"lord_money:silver_coin 72", 50},
		{"default:steel_ingot 99",			"lord_money:silver_coin 22", 12},
		{"tools:sword_silver 1",			"lord_money:silver_coin 5",	10},
		{"default:bronze_ingot 25",			"lord_money:silver_coin 4",	15},
		{"lottblocks:small_lamp_pine 6",	"lord_money:silver_coin 2",	6},
		{"lottblocks:dwarf_harp 1",			"lord_money:silver_coin 12", 10},
		{"tools:dagger_mithril 1",	"lord_money:silver_coin 14", 20},
		{"tools:sword_mithril 1",			"lord_money:silver_coin 32", 30},
		{"tools:sword_steel 1",			"lord_money:silver_coin 4",	10},
		{"tools:battleaxe_silver 1",	"lord_money:silver_coin 9",	18},
		{"lottblocks:dwarfstone_stripe 50",	"lord_money:silver_coin 14", 12},
		{"lottblocks:dwarfstone_black 99",	"lord_money:silver_coin 30", 17},
		{"default:stonebrick 99",			"lord_money:silver_coin 22", 14},
		{"lottblocks:dwarfstone_white 99",	"lord_money:silver_coin 30", 17},
	},
	names = {
		"Azaghâl", "Balbrin", "Borin", "Farin", "Flói", "Frerin",
		"Grór", "Lóni", "Náli", "Narvi", "Telchar", "Thion"
	},
	messages = {
		SL("We have many treasures, and for the right price we might be willing to part with them..."),
		SL("Don't even think of stealing our treasure... If you do, heads shall roll."),
		SL("What are you doing here? What do you want from us?"),
		SL("Be careful when you enter our homes, a fall from the ladder could well prove deadly."),
		SL("If you want to mine, do so. There's plenty of iron to go around!"),
		SL("If you venture deep underground, beware! The monsters there are very powerful, and kill the unprepared instantly."), -- luacheck: no_max_line_length
	}
}

lottmobs.elf = {
	items = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10", 5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10", 5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1", 5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1", 5},
		{"lottplants:mallorntree 10",		"lord_money:silver_coin 4",	5},
		{"lottores:rough_rock 4",			"lord_money:silver_coin 30", 17},
		{"lottother:blue_torch 10",			"lord_money:silver_coin 20", 15},
		{"tools:spear_galvorn 1",			"lord_money:silver_coin 25", 20},
		{"tools:battleaxe_silver 1",		"lord_money:silver_coin 18", 14},
		{"tools:sword_galvorn 1",			"lord_money:silver_coin 25", 25},
		{"lottplants:elanor 10",			"lord_money:silver_coin 2",	22},
		{"lottarmor:chestplate_galvorn 1",	"lord_money:silver_coin 40", 25},
		{"lottarmor:helmet_galvorn 1",		"lord_money:silver_coin 30", 25},
		{"lottarmor:boots_galvorn 1",		"lord_money:silver_coin 25", 25},
		{"lottarmor:leggings_galvorn 1",	"lord_money:silver_coin 35", 25},
		{"lottplants:niphredil 12",			"lord_money:silver_coin 3",	14},
		{"lottblocks:mallorn_pillar 30",	"lord_money:silver_coin 7",	4},
		{"lottplants:mallornsapling 3",		"lord_money:silver_coin 2",	17},
		{"lottplants:mallornwood 99",		"lord_money:silver_coin 10", 5},
	},
	items_race = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10", 5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10", 5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1", 5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1", 5},
		{"lottplants:mallorntree 10",		"lord_money:silver_coin 4",	5},
		{"lottores:rough_rock 4",			"lord_money:silver_coin 28", 17},
		{"lottother:blue_torch 10",			"lord_money:silver_coin 18", 15},
		{"tools:spear_galvorn 1",			"lord_money:silver_coin 22", 20},
		{"tools:battleaxe_silver 1",		"lord_money:silver_coin 15", 14},
		{"tools:sword_galvorn 1",			"lord_money:silver_coin 21", 25},
		{"lottplants:elanor 10",			"lord_money:silver_coin 2",	22},
		{"lottarmor:chestplate_galvorn 1",	"lord_money:silver_coin 37", 25},
		{"lottarmor:helmet_galvorn 1",		"lord_money:silver_coin 28", 25},
		{"lottarmor:boots_galvorn 1",		"lord_money:silver_coin 23", 25},
		{"lottarmor:leggings_galvorn 1",	"lord_money:silver_coin 32", 25},
		{"lottplants:niphredil 12",			"lord_money:silver_coin 3",	14},
		{"lottblocks:mallorn_pillar 30",	"lord_money:silver_coin 6",	4},
		{"lottplants:mallornsapling 3",		"lord_money:silver_coin 2",	17},
		{"lottplants:mallornwood 99",		"lord_money:silver_coin 8",	5},
	},
	names = {
		"Annael", "Anairë", "Curufin", "Erestor", "Gwindor", "Irimë",
		"Oropher", "Maglor", "Quennar", "Rúmil", "Orgof", "Voronwë"
	},
	messages = {
		SL("Welcome to our lovely forest home, weary traveler. Refresh yourself here."),
		SL("Sauron grows in power. Shall we be able to vanquish him again?"),
		SL("We are a peace loving people, but if we are angered, our wrath is terrible!"),
		SL("Rest among us and prepare yourself, for war is imminent."),
		SL("If you wish to buy goods from us, there are certain traders who wander our land."),
		SL("Beware! Our society, and all societies, are on the edge of a knife blade - one false move and all will end, and Sauron will rule supreme."), -- luacheck: no_max_line_length
	}
}

lottmobs.hobbit = {
	items = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10",	5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10",	5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1",		5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1",		5},
		{"lottfarming:pipe 1",				"lord_money:silver_coin 2",		5},
		{"lottfarming:pipeweed_cooked 50",	"lord_money:silver_coin 17",	10},
		{"lottpotion:beer "..math.random(5,15),					"lord_money:silver_coin 7",		8},
		{"lottpotion:cider "..math.random(10,20),				"lord_money:silver_coin 11",	13},
		{"lottpotion:wine "..math.random(5,10),					"lord_money:silver_coin 18",	14},
		{"lottfarming:tomatoes "..math.random(20,30),			"lord_money:silver_coin 23",	25},
		{"lottfarming:potato "..math.random(25,35),				"lord_money:silver_coin 10",	22},
		{"lottfarming:brown_mushroom ".. math.random(40,45),	"lord_money:silver_coin 40",	25},
		{"lottfarming:corn_seed 12",			"lord_money:silver_coin 30",	25},
		{"farming:hoe_bronze 1",			"lord_money:silver_coin 25",	25},
		{"lottinventory:brewing_book 1",	"lord_money:silver_coin 35",	25},
		{"lottfarming:barley_seed "..math.random(5,10),				"lord_money:silver_coin 3",	14},
		{"lottfarming:berries "..math.random(15,20),			"lord_money:silver_coin 7",	4},
		{"lottplants:firsapling 2",			"lord_money:silver_coin 2",		17},
		{"default:apple "..math.random(5,20),	"lord_money:silver_coin 10",	5},
	},
	items_race = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10",	5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10",	5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1",		5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1",		5},
		{"lottfarming:pipe 1",				"lord_money:silver_coin 2",		5},
		{"lottfarming:pipeweed_cooked 50",	"lord_money:silver_coin 14",	10},
		{"lottpotion:beer "..math.random(5,15),				"lord_money:silver_coin 5",		8},
		{"lottpotion:cider "..math.random(10,20),			"lord_money:silver_coin 9",		13},
		{"lottpotion:wine "..math.random(5,10),				"lord_money:silver_coin 16",	14},
		{"lottfarming:tomatoes "..math.random(20,30),		"lord_money:silver_coin 20",	25},
		{"lottfarming:potato "..math.random(25,35),			"lord_money:silver_coin 7",		22},
		{"lottfarming:brown_mushroom "..math.random(40,45),	"lord_money:silver_coin 35",	25},
		{"lottfarming:corn_seed 12",			"lord_money:silver_coin 27",	25},
		{"farming:hoe_bronze 1",			"lord_money:silver_coin 22",	25},
		{"lottinventory:brewing_book 1",	"lord_money:silver_coin 32",	25},
		{"lottfarming:barley_seed "..math.random(5,10),		"lord_money:silver_coin 3",	14},
		{"lottfarming:berries "..math.random(15,20),	"lord_money:silver_coin 6",	4},
		{"lottplants:firsapling 2",			"lord_money:silver_coin 2",		17},
		{"default:apple "..math.random(5,20),	"lord_money:silver_coin 8",	5},
	},
	names = {
		"Adalgrim", "Bodo", "Cotman", "Doderic", "Falco", "Gormadoc",
		"Hobson", "Ilberic", "Largo", "Madoc", "Orgulas", "Rorimac"
	},
	messages = {
		SL("Ah, what a lovely land we have, so peaceful, so beautiful."),
		SL("There's nothing quite like the smell of pipe smoke rising on a cold October morning, is there?"),
		SL("If you are in need of any food, there are traders who wander around and they usually have a good stock."),
		SL("If you are thinking that you'll find adventures here, think again! Good day!"),
		SL("We hear tales of war, but they cannot be more than tales - like that of the Oliphaunt."),
		SL("Food is meant to be enjoyed, not rushed. Don't just eat a little here and a little there, sit down for a proper meal sometimes..."), -- luacheck: no_max_line_length
	}
}

lottmobs.human = {
	items = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10",	5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10",	5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1",		5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1",		5},
		{"default:sandstone 40",			"lord_money:silver_coin 10",	12},
		{"boats:sail_boat 1",				"lord_money:silver_coin 4",		14},
		{"lottarmor:shield_bronze 1",		"lord_money:silver_coin 20",	20},
		{"farming:bread 12",				"lord_money:silver_coin 2",		5},
		{"lottblocks:marble_brick 35",		"lord_money:silver_coin 12",	10},
		{"default:desert_stone 30",			"lord_money:silver_coin 8",		12},
		{"lottblocks:lamp_alder 5",			"lord_money:silver_coin 4",		8},
		{"lottarmor:chestplate_bronze 1",	"lord_money:silver_coin 30",	30},
		{"lottarmor:boots_bronze 1",		"lord_money:silver_coin 12",	18},
		{"lottblocks:lamp_lebethron 7",		"lord_money:silver_coin 6",		11},
		{"lottblocks:door_alder 6",			"lord_money:silver_coin 2",		18},
		{"lottores:marble 99",				"lord_money:silver_coin 33",	18},
		{"lottarmor:helmet_bronze 1",		"lord_money:silver_coin 20",	24},
		{"default:brick 30",				"lord_money:silver_coin 10",	17},
		{"lottarmor:leggings_bronze 1",		"lord_money:silver_coin 25",	34},
	},
	items_race = {
		{"lord_money:gold_coin 1",			"lord_money:silver_coin 10",	5},
		{"lord_money:silver_coin 1",		"lord_money:copper_coin 10",	5},
		{"lord_money:silver_coin 10",		"lord_money:gold_coin 1",		5},
		{"lord_money:copper_coin 10",		"lord_money:silver_coin 1",		5},
		{"default:sandstone 40",			"lord_money:silver_coin 8",		12},
		{"boats:sail_boat 1",				"lord_money:silver_coin 3",		14},
		{"lottarmor:shield_bronze 1",		"lord_money:silver_coin 18",	20},
		{"farming:bread 12",				"lord_money:silver_coin 2",		5},
		{"lottblocks:marble_brick 35",		"lord_money:silver_coin 11",	10},
		{"default:desert_stone 30",			"lord_money:silver_coin 7",		12},
		{"lottblocks:lamp_alder 5",			"lord_money:silver_coin 3",		8},
		{"lottarmor:chestplate_bronze 1",	"lord_money:silver_coin 27",	30},
		{"lottarmor:boots_bronze 1",		"lord_money:silver_coin 10",	18},
		{"lottblocks:lamp_lebethron 7",		"lord_money:silver_coin 5",		11},
		{"lottblocks:door_alder 6",			"lord_money:silver_coin 2",		18},
		{"lottores:marble 99",				"lord_money:silver_coin 30",	18},
		{"lottarmor:helmet_bronze 1",		"lord_money:silver_coin 18",	24},
		{"default:brick 30",				"lord_money:silver_coin 9",		17},
		{"lottarmor:leggings_bronze 1",		"lord_money:silver_coin 21",	34},
	},
	names = {
		"Aratan", "Arvegil", "Belegorn", "Celepharn", "Dúnhere", "Elatan",
		"Gilraen", "Írimon", "Minardil", "Oromendil", "Tarcil", "Vorondil"
	},
	messages = {
		SL("War comes swiftly... We are preparing, but are we doing enough?"),
		SL("The noble race of man rises in the world! Even the dwarves are starting to show interest in some of our goods."),
		SL("Are you willing to fight with us? We have much to lose, but much to gain also! We must rally together."),
		SL("Don't listen to those who say that all this talk of war will come to nothing, for we are at war now."),
		SL("We suffer raids from orcs, and other evil things, yet we do nothing! We must act, and act with force!"),
		SL("Life here is far from normal. We wish for peace, yet the only way we can get peace is through war..."),
	}
}
lottmobs.orc = {
        names = {
                "Azog", "Balcmeg", "Boldog", "Bolg", "Golfimbul", "Gorbag", "Gorgol",
                "Grishnákh", "Lagduf", "Lug", "Lugdush", "Mauhúr", "Muzgash", "Orcobal",
                "Othrod", "Radbug", "Shagrat", "Ufthak", "Uglúk"
        },
        messages = {
                SL("DIE!!!, Urrrrrrrrrrrrrghhhhhhhhhhhhhhhhhhh!!"),
                SL("Arrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!, KILL! KILL! KILL!")
        },
}
