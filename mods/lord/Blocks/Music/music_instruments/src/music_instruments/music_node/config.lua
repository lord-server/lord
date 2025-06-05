local S = minetest.get_mod_translator()


--[[
	Частота звука (pitch) рассчитывается по формуле:
	pitch = 2^(n/12), где n — смещение в полутонах.

	Например, нота на октаву выше (n=12) будет иметь pitch = 2.0
]]

-- Таблица с константами: для каждого смещения задаём название ноты и значение pitch
--- @type table<number, {note: string, pitch: number}>
local instruments = {
	kalimba = {
		name = S('Kalimba'),
		description =   S('The kalimba is a magical instrument') .. '\n' ..
						S('that can turn even the most hopeless') .. '\n' ..
						S('musical attempts') .. '\n' ..
						S('into something resembling a melody.'),
		drawtype = 'mesh',
		mesh = 'music_instruments_kalimba.obj',
		tiles = {'music_instruments_kalimba_metallophon.png'},
		sound = 'kalimba_c5',
		notes = {
			-- Октава 4 (C4-B4)
			[-12] = { note = 'C4',      pitch = 2^(-12/12) },
			[-11] = { note = 'C♯4/D♭4', pitch = 2^(-11/12) },
			[-10] = { note = 'D4',      pitch = 2^(-10/12) },
			[-9]  = { note = 'D♯4/E♭4', pitch = 2^(-9/12)  },
			[-8]  = { note = 'E4',      pitch = 2^(-8/12)  },
			[-7]  = { note = 'F4',      pitch = 2^(-7/12)  },
			[-6]  = { note = 'F♯4/G♭4', pitch = 2^(-6/12)  },
			[-5]  = { note = 'G4',      pitch = 2^(-5/12)  },
			[-4]  = { note = 'G♯4/A♭4', pitch = 2^(-4/12)  },
			[-3]  = { note = 'A4',      pitch = 2^(-3/12)  },
			[-2]  = { note = 'A♯4/B♭4', pitch = 2^(-2/12)  },
			[-1]  = { note = 'B4',      pitch = 2^(-1/12)  },

			-- Октава 5 (C5-B5)
			[0]   = { note = 'C5',      pitch = 1.0        },  -- (базовая нота)
			[1]   = { note = 'C♯5/D♭5', pitch = 2^(1/12)   },
			[2]   = { note = 'D5',      pitch = 2^(2/12)   },
			[3]   = { note = 'D♯5/E♭5', pitch = 2^(3/12)   },
			[4]   = { note = 'E5',      pitch = 2^(4/12)   },
			[5]   = { note = 'F5',      pitch = 2^(5/12)   },
			[6]   = { note = 'F♯5/G♭5', pitch = 2^(6/12)   },
			[7]   = { note = 'G5',      pitch = 2^(7/12)   },
			[8]   = { note = 'G♯5/A♭5', pitch = 2^(8/12)   },
			[9]   = { note = 'A5',      pitch = 2^(9/12)   },
			[10]  = { note = 'A♯5/B♭5', pitch = 2^(10/12)  },
			[11]  = { note = 'B5',      pitch = 2^(11/12)  },

			-- Октава 6 часть (C6-E6)
			[12]  = { note = 'C6',      pitch = 2^(12/12)  },
			[13]  = { note = 'C♯6/D♭6', pitch = 2^(13/12)  },
			[14]  = { note = 'D6',      pitch = 2^(14/12)  },
			[15]  = { note = 'D♯6/E♭6', pitch = 2^(15/12)  },
			[16]  = { note = 'E6',      pitch = 2^(16/12)  },
		},
		recipe = {
			{'default:steel_ingot', ''                            , 'default:steel_ingot', },
			{'default:steel_ingot', 'music_instruments:music_base', 'default:steel_ingot', },
			{'default:steel_ingot', ''                            , 'default:steel_ingot', },
		},
		min_offset = -12,
		max_offset = 16,
	},

	metallophone = {
		name = S('Metallophone'),
		description =   S('The metallophone can sound') .. '\n' ..
						S('like an angelic choir,') .. '\n' ..
						S('if struck gently,') .. '\n' ..
						S('or like a china shop fight') .. '\n' ..
						S('if approached with enthusiasm.'),
		drawtype = 'mesh',
		mesh = 'music_instruments_metallophone.obj',
		tiles = {'music_instruments_kalimba_metallophon.png'},
		sound = 'metallophone_c6',
		notes = {
			-- Октава 6 (C6–B6)
			[0]  = { note = 'C6',  pitch = 1.0       },
			[1]  = { note = 'D6',  pitch = 2^(2/12)  },
			[2]  = { note = 'E6',  pitch = 2^(4/12)  },
			[3]  = { note = 'F6',  pitch = 2^(5/12)  },
			[4]  = { note = 'G6',  pitch = 2^(7/12)  },
			[5]  = { note = 'A6',  pitch = 2^(9/12)  },
			[6]  = { note = 'B6',  pitch = 2^(11/12) },

			-- Октава 7 (C7–B7)
			[7]  = { note = 'C7',  pitch = 2^(12/12) },
			[8]  = { note = 'D7',  pitch = 2^(14/12) },
			[9]  = { note = 'E7',  pitch = 2^(16/12) },
			[10] = { note = 'F7',  pitch = 2^(17/12) },
			[11] = { note = 'G7',  pitch = 2^(19/12) },
			[12] = { note = 'A7',  pitch = 2^(21/12) },
			[13] = { note = 'B7',  pitch = 2^(23/12) },
		},
		min_offset = 0,
		max_offset = 13,
		recipe = {
			{'lottores:silver_ingot', ''                            , 'lottores:silver_ingot', },
			{'lottores:silver_ingot', 'music_instruments:music_base', 'lottores:silver_ingot', },
			{'lottores:silver_ingot', ''                            , 'lottores:silver_ingot', },
		},
	},
}


return {
	instruments = instruments,
}
