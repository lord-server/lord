local Type = require('item_rank.Type')

--- @type table<string,item_rank.Rank>
local config = {
	[Type.COMMON] = {
        discription = '',
        title = '',
		code  = Type.COMMON,
		color = '#88AACC',
	},

	[Type.ADVANCED] = {
        discription = '',
        title = '',
		code  = Type.ADVANCED,
		color = '#3CB960'
	},

	[Type.RARE] = {
        discription = '',
        title = '',
		code  = Type.RARE,
		color = '#44AAFF',
	},

	[Type.EPIC] = {
        discription = '',
        title = '',
		code  = Type.EPIC,
		color = '#9966FF',
	},

	[Type.LEGENDARY] = {
        discription = '',
        title = '',
		code  = Type.LEGENDARY,
		color = '#FF9933',
	},
}


return config
