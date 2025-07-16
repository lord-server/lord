local S = minetest.get_mod_translator()

--- @class holding_points.config.Notifier.Colors
--- @field EVENT    string ColorSpec
--- @field BATTLE   string ColorSpec
--- @field POINT    string ColorSpec
--- @field POSITION string ColorSpec
--- @field WAR_CRY  string ColorSpec
--- @field CLAN     string ColorSpec

--- @class holding_points.config.Notifier.Sounds
--- @field battle_start        string
--- @field battle_over         string
--- @field battle_starts_in_30 string
--- @field battle_starts_in_10 string
--- @field battle_starts_in_5  string
--- @field battle_starts_in_3  string
--- @field battle_starts_in_1  string
--- @field point_captured      string


--- @class holding_points.config.Notifier
--- @field colors  holding_points.config.Notifier.Colors
--- @field war_cry string[]
--- @field sounds  holding_points.config.Notifier.Sounds

--- @class holding_points.config.Scheduler
--- @field notify_before number[]


--- @class holding_points.config
local config = {
	--- @type holding_points.config.Notifier
	notifier = {
		--- @type holding_points.config.Notifier.Colors
		colors = {
			EVENT    = '#f0f',
			BATTLE   = '#2f8',
			POINT    = '#ee4',
			POSITION = '#aaa',
			WAR_CRY  = '#f73',
			CLAN     = clans.COLOR,
		},
		war_cry = {
			S('Fight desperately, win with honor! The control points await their heroes!'),
			S('May your tactics be sharp, and your victory glorious! To battle!'),
			S('Capture. Hold. Dominate. Good luck on the battlefield!'),
			S('Every point is a step toward triumph. Show them what you’re made of!'),
			S('Not a step back! May your team be the first to the point!'),
			S('Kings aren’t born — they’re forged in battle!'),
			S('Eyes on the map, fists on the controls. Let’s move!'),
			S('Capture, hold, don’t hesitate — the enemy never sleeps!'),
			S('It’s gonna get hot! Ready for a fight? Attack!'),
			S('Victory favors the bold! Do you? Charge for the points!'),
		},
		--- @type holding_points.config.Notifier.Sounds
		sounds = {
			battle_start        = 'holding_points_battle_start',
			battle_over         = 'holding_points_battle_over',
			battle_starts_in_30 = 'holding_points_battle_starts_in_30_min',
			battle_starts_in_10 = 'holding_points_battle_starts_in_10_min',
			battle_starts_in_5  = 'holding_points_battle_starts_in_5_min',
			battle_starts_in_3  = 'holding_points_battle_starts_in_3_min',
			battle_starts_in_1  = 'holding_points_battle_starts_in_1_min',
			point_captured      = 'holding_points_point_captured',
		},
	},
	--- @type holding_points.config.Scheduler
	scheduler = {
		--- @type number[]
		notify_before = { 30, 10, 5, 3, 1 }
	},
}


return config
