--- @class remains.drop.config.entry
--- @field item   string|table technical item name with quantity (`"mod:item"|"mod:item N"`) or array of them.
--- @field rarity number       chance 1 to `rarity`. use `100/<percent>` to define in percents.

--- @alias remains.drop.config remains.drop.config.entry[]

--- @type remains.drop.config
local items_ancient_miner = {
	{ item = 'lottother:vilya',           rarity = 100/0.5 },
	{ item = 'lottother:narya',           rarity = 100/2 },
	{ item = 'tools:pick_mithril',        rarity = 100/3 },
	{ item = 'tools:shovel_mithril',      rarity = 100/3 },
	{ item = 'lord_money:diamond_coin',   rarity = 100/5 },
	{ item = 'lottores:mithril_lump 3',   rarity = 100/5 },
	{ item = 'lottores:white_gem',        rarity = 100/5 },
	{ item = 'lottores:blue_gem',         rarity = 100/5 },
	{ item = 'lottores:red_gem',          rarity = 100/5 },
	{ item = 'default:gold_lump 6',       rarity = 100/10 },
	{ item = 'lottores:lead_lump 10',     rarity = 100/10 },
	{ item = 'lottores:silver_lump 6',    rarity = 100/10 },
	{ item = 'tools:pick_galvorn',        rarity = 100/12 },
	{ item = 'tools:shovel_galvorn',      rarity = 100/12 },
	{ item = 'lord_money:gold_coin 2',    rarity = 100/20 },
	{ item = 'default:copper_lump 5',     rarity = 100/33 },
	{ item = 'lottores:tin_lump 10',      rarity = 100/33 },
	{ item = 'default:iron_lump 15',      rarity = 100/33 },
	{ item = 'lord_money:silver_coin 10', rarity = 100/50 },
	{ item = 'lord_money:copper_coin 20', rarity = 100/100 },
}
--- @type remains.drop.config
local tools_acnient_miner = {
	{ item = {
		'tools:pick_bronze',
		'tools:pick_copper',
		'tools:pick_steel',
		'tools:pick_gold',
		'tools:pick_silver',
		'tools:pick_stone',
		'tools:pick_wood',
		'tools:pick_tin',
		},                                rarity = 100/74 },
	{ item = {
		'tools:shovel_bronze',
		'tools:shovel_copper',
		'tools:shovel_steel',
		'tools:shovel_gold',
		'tools:shovel_silver',
		'tools:shovel_stone',
		'tools:shovel_wood',
		'tools:shovel_tin',
		},                                rarity = 100/74 },
}

--- @type remains.drop.config
local skull_pick = items_ancient_miner
for item, drop in pairs(tools_acnient_miner) do
	table.insert(skull_pick, drop)
end
table.sort( skull_pick, function (a,b) return a.rarity > b.rarity end )


return {
	--- @type remains.drop.config
	skull_bones = items_ancient_miner,
	--- @type remains.drop.config
	skull_pick = skull_pick
}
