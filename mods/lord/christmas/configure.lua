local os_date, os_time = os.date, os.time

local conf_gifts = minetest.settings:get("christmas_tree_gifts")
local conf_date  = minetest.settings:get("christmas_date")
if not conf_gifts then
	minetest.log("warning", "christmas: no 'christmas_tree_gifts' setting. Using 'default:dirt 99'.")
	conf_gifts = "default:dirt 99"
end
if not conf_date then
	minetest.log("warning", "christmas: no 'christmas_date' setting. Using '01.01 00:00'.")
	conf_date = "01.01 00:00"
end

local gifts                 = string.split(conf_gifts)
local month, day, hour, min = string.match(conf_date, "(%d+)/(%d+) (%d+):(%d+)")
local christmas_date        = {
	month = tonumber(month),
	day   = tonumber(day),
	hour  = tonumber(hour),
	min   = tonumber(min),
}


local ONE_MONTH = 30 * 24 * 60 * 60


--- @class Christmas
local christmas = {

	--- @return boolean true, if has come & one month has not passed (30 days)
	has_come = function()
		local now = os_date("*t")

		local holiday_in_past_year = christmas_date.month == 12 and now.month == 1

		local holiday = table.copy(christmas_date)
		holiday.year  = now.year + (holiday_in_past_year and 1 or 0)

		local diff = os_time(now) - os_time(holiday)

		return diff > 0 and diff < ONE_MONTH
	end,

	--- @return boolean true, if is coming & less than a month left/until (30 days)
	is_coming = function()
		local now = os_date("*t")

		local holiday_in_next_year = christmas_date.month == 1 and now.month == 12

		local holiday = table.copy(christmas_date)
		holiday.year  = now.year + (holiday_in_next_year and 1 or 0)

		local diff = os_time(holiday) - os_time(now)

		return diff > 0 and diff < ONE_MONTH
	end
}


return gifts, christmas
