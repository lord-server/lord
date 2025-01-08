
mountgen = {}
mountgen.required_priv = 'server'

require('mountgen.algorithms.cone')
require('mountgen.algorithms.diamond_square')
require('mountgen.config')
require('mountgen.tools')



return {
	init = function(mod)
	end
}
