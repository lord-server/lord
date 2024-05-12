local trunks   = require('tree.trunks')
local leaves   = require('tree.leaves')
local saplings = require('tree.saplings')

require('tree.trunks.slabs')
require('tree.fruits')
require('tree.leaves.decay')

tree = {}

local function register_api()
	_G.tree = {
		trunks   = trunks,
		leaves   = leaves,
		saplings = saplings,
	}
end

return {
	init = function()
		register_api()
	end
}
