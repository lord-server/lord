

-- Таблица с константами: для каждого смещения задаём название ноты и значение pitch
--- @type table<number, {note: string, pitch: number}>
local instruments = {
	kalimba = {
		name = 'Kalimba',
		description = 'Kalimba description',
		drawtype = 'mesh',
		mesh = 'music_instruments_kalimba.obj',
		tiles = {'music_instruments_kalimba_metallophon.png'},
		sound = 'kalimba_c5',
		notes = {
			[-12] = { note = 'C4',  pitch = 0.500 },
			[-11] = { note = 'C#4', pitch = 0.531 },
			[-10] = { note = 'D4',  pitch = 0.562 },
			[ -9] = { note = 'D#4', pitch = 0.595 },
			[ -8] = { note = 'E4',  pitch = 0.630 },
			[ -7] = { note = 'F4',  pitch = 0.667 },
			[ -6] = { note = 'F#4', pitch = 0.707 },
			[ -5] = { note = 'G4',  pitch = 0.749 },
			[ -4] = { note = 'G#4', pitch = 0.794 },
			[ -3] = { note = 'A4',  pitch = 0.841 },
			[ -2] = { note = 'A#4', pitch = 0.891 },
			[ -1] = { note = 'B4',  pitch = 0.943 },
			[  0] = { note = 'C5',  pitch = 1.000 },
			[  1] = { note = 'C#5', pitch = 1.059 },
			[  2] = { note = 'D5',  pitch = 1.122 },
			[  3] = { note = 'D#5', pitch = 1.189 },
			[  4] = { note = 'E5',  pitch = 1.260 },
			[  5] = { note = 'F5',  pitch = 1.335 },
			[  6] = { note = 'F#5', pitch = 1.414 },
			[  7] = { note = 'G5',  pitch = 1.498 },
			[  8] = { note = 'G#5', pitch = 1.587 },
			[  9] = { note = 'A5',  pitch = 1.682 },
			[ 10] = { note = 'A#5', pitch = 1.782 },
			[ 11] = { note = 'B5',  pitch = 1.888 },
			[ 12] = { note = 'C6',  pitch = 2.000 },
		}
	},

	metallophone = {
		name = 'Metallophone',
		description = 'metallophone description',
		drawtype = 'mesh',
		mesh = 'music_instruments_metallophone.obj',
		tiles = {'music_instruments_kalimba_metallophon.png'},
		sound = 'metallophone_c7',
		notes = {
			[-12] = { note = 'C6',  pitch = 0.500 },
			[-11] = { note = 'C#6', pitch = 0.531 },
			[-10] = { note = 'D6',  pitch = 0.562 },
			[ -9] = { note = 'D#6', pitch = 0.595 },
			[ -8] = { note = 'E6',  pitch = 0.630 },
			[ -7] = { note = 'F6',  pitch = 0.667 },
			[ -6] = { note = 'F#6', pitch = 0.707 },
			[ -5] = { note = 'G6',  pitch = 0.749 },
			[ -4] = { note = 'G#6', pitch = 0.794 },
			[ -3] = { note = 'A6',  pitch = 0.841 },
			[ -2] = { note = 'A#6', pitch = 0.891 },
			[ -1] = { note = 'B6',  pitch = 0.943 },
			[  0] = { note = 'C7',  pitch = 1.000 },
			[  1] = { note = 'C#7', pitch = 1.059 },
			[  2] = { note = 'D7',  pitch = 1.122 },
			[  3] = { note = 'D#7', pitch = 1.189 },
			[  4] = { note = 'E7',  pitch = 1.260 },
			[  5] = { note = 'F7',  pitch = 1.335 },
			[  6] = { note = 'F#7', pitch = 1.414 },
			[  7] = { note = 'G7',  pitch = 1.498 },
			[  8] = { note = 'G#7', pitch = 1.587 },
			[  9] = { note = 'A7',  pitch = 1.682 },
			[ 10] = { note = 'A#7', pitch = 1.782 },
			[ 11] = { note = 'B7',  pitch = 1.888 },
			[ 12] = { note = 'C8',  pitch = 2.000 },
		}
	},
}


return {
	instruments = instruments,
	max_offset = 12,
	min_offset = -12
}
