
Voxrame = Voxrame or {}

--- @module 'Voxrame.map'
Voxrame.map = {
	--- @type Voxrame.map.Room
	Room = require('map.Room'),
	--- @type Voxrame.map.Corridor
	Corridor = require('map.Corridor'),
	--- @namespace Voxrame.map.room
	room = {
		--- @type Voxrame.map.room.Wall
		Wall  = require('map.room.Wall'),
		--- @namespace Voxrame.map.room.wall
		wall  = {
			Type = require('map.room.wall.Type')
		},
		Walls = require('map.room.Walls'),
		Exit  = require('map.room.Exit'),
	},
}
