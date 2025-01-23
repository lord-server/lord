local Algorithm              = require('mountgen.Algorithm')
local ConeAlgorithm          = require('mountgen.algorithm.Cone')
local ParabolaAlgorithm      = require('mountgen.algorithm.Parabola')
local DiamondSquareAlgorithm = require('mountgen.algorithm.DiamondSquare')
local Form                   = require('mountgen.config.Form')
local Generator              = require('mountgen.Generator')
local tools                  = require('mountgen.tools')


mountgen = {} -- luacheck: ignore unused global variable mountgen

local function register_api()
	_G.mountgen = {
		required_priv      = 'server',
		register_algorithm = Algorithm.register,
		Form               = Form,
		--- @param top_position Position
		--- @param config       mountgen.ConfigValues
		generate           = function(top_position, config)
			Generator:new(top_position, config):run()
		end,
	}
end

local function register_algorithms()
	Algorithm
		.register(ConeAlgorithm)
		.register(ParabolaAlgorithm)
		.register(DiamondSquareAlgorithm)
end


return {
	init = function(mod)
		register_api()

		register_algorithms()

		tools.register_stick()
	end
}
