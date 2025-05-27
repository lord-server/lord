local tuning_fork = require('music_instruments.tuning_fork')
local music_node = require('music_instruments.music_node')

return {
	init = function()
		tuning_fork.register()
		music_node.register()
	end,
}
