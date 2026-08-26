local Type = require('item_rank.Type')
local S = core.get_mod_translator()

--- @type table<string,item_rank.Rank>
local config = {
	[Type.COMMON] = {
		discription = S('Basic items, crafted from common resources. Minimal stats.'),
		title = S('Common'),
		code  = Type.COMMON,
		color = '#88AACC',
	},

	[Type.ADVANCED] = {
		discription = S('Requires rare materials or advanced crafting. Balanced stats.'),
		title = S('Advanced'),
		code  = Type.ADVANCED,
		color = '#3CB960'
	},

	[Type.RARE] = {
		discription =
			S('Require special conditions or components with a low drop rate')..'\n'..
			S('They possess enhanced stats and beneficial properties.'),
		title = S('Rare'),
		code  = Type.RARE,
		color = '#44AAFF',
	},

	[Type.EPIC] = {
		discription = S('Hard to craft, needs elite resources. High-tier stats.'),
		title = S('Epic'),
		code  = Type.EPIC,
		color = '#9966FF',
	},

	[Type.LEGENDARY] = {
		discription = S('Peak of craftsmanship. Very hard to obtain/craft. Best-in-slot performance.'),
		title = S('Legendary'),
		code  = Type.LEGENDARY,
		color = '#FF9933',
	},

	[Type.MYTHICAL] = {
		discription =
			S('One-of-a-kind items—legends among gear.')..'\n'.. 
			S('They boast exceptional stats and transform your playstyle'),
		title = S('Mythical'),
		code  = Type.MYTHICAL,
		color = '#EE2222',
	},
}


return config
