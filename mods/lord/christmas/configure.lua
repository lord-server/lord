local conf_gifts = minetest.settings:get("christmas_tree_gifts")
local conf_date  = minetest.settings:get("christmas_date")
if not conf_gifts then
	minetest.log("warning", "christmas: no 'christmas_tree_gifts' setting. Use 'default:dirt'.")
	conf_gifts = "default:dirt"
end
if not conf_date then
	minetest.log("warning", "christmas: no 'christmas_date' setting. Use '01.01 00:00'.")
	conf_date = "01.01 00:00"
end

local gifts                 = string.split(conf_gifts)
local month, day, hour, min = string.match(conf_date, "(%d+)/(%d+) (%d+):(%d+)")
local christmas_date        = {month = tonumber(month), day = tonumber(day), hour = tonumber(hour), min = tonumber(min)}

return gifts, christmas_date
