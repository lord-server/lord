
Voxrame = Voxrame or {}

--- @module 'Voxrame.map'
Voxrame.map = {
	--- @type Voxrame.map.Room
	Room = require('map.Room'),
	--- @namespace Voxrame.map.room
	room = {
		Wall  = require('map.room.Wall'),
		--- @namespace Voxrame.map.room.wall
		wall  = {
			Type = require('map.room.wall.Type')
		},
		Walls = require('map.room.Walls'),
		-- TODO: Exit  = require('map.room.Exit'),
	},
}
