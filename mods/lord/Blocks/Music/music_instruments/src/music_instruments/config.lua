

-- Таблица с константами: для каждого смещения задаём название ноты и значение pitch
--- @type table<number, {note: string, pitch: number}>
local note_names = {
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

local instruments = {
	kalimba = {
		name = 'Kalimba',
		description = 'Kalimba description',
		tiles = {'no_texture.png'},
		--drawtype = 'mesh',
		--mesh = 'music_instruments.kalimba.obj',
		sound = 'kalimba_c5',
		notes = note_names
	},
	-- Пример добавления нового инструмента:
	flute = {
		name = 'Flute',
		description = 'Flute description',
		tiles = {'no_texture.png'},
		--drawtype = 'mesh',
		--mesh = 'music_instruments.flute.obj',
		sound = 'flute_c5',
		sound_long = 'flute_c5_long',
		notes = note_names
	}
}


return {
	instruments = instruments,
	max_offset = 12,
	min_offset = -12
}
