local Algorithm              = require('mountgen.Algorithm')
local ConeAlgorithm          = require('mountgen.algorithm.Cone')
local DiamondSquareAlgorithm = require('mountgen.algorithm.DiamondSquare')
local tools                  = require('mountgen.tools')


mountgen = {}

local function register_api()
	mountgen.required_priv = 'server'
end

local function register_algorithms()
	Algorithm
		.register(ConeAlgorithm)
		.register(DiamondSquareAlgorithm)
end


return {
	init = function(mod)
		register_api()

		register_algorithms()

		tools.register_stick()
	end
}
