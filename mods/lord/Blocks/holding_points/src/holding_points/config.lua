
--- @class holding_points.config.Notifier.Colors
--- @field EVENT  string ColorSpec
--- @field BATTLE string ColorSpec
--- @field POINT  string ColorSpec
--- @field CLAN   string ColorSpec

--- @class holding_points.config.Notifier
--- @field colors holding_points.config.Notifier.Colors


--- @class holding_points.config
local config = {
	--- @type holding_points.config.Notifier
	notifier = {
		--- @type holding_points.config.Notifier.Colors
		colors = {
			EVENT  = '#f0f',
			BATTLE = '#2f8',
			POINT  = '#ee4',
			CLAN   = clans.COLOR,
		}
	}
}


return config
