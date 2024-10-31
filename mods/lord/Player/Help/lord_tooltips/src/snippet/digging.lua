local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_mod_translator()


--- @param caps_times table<number,number>
--- @param level      number
--- @param maxlevel   number
--- @return number|nil
local function get_dig_time(caps_times, level, maxlevel)
	local time = caps_times[level]

	return time
		and (maxlevel > 1 and time / maxlevel or time)
		or  nil
end

--- @param caps table
--- @return number|nil,boolean
local function get_min_digtime(caps)
	local maxlevel = caps.maxlevel or 1
	local unique = maxlevel > 1 and false or true
	--- @type number
	local mintime = nil

	if not caps.times then
		return mintime, unique
	end

	for r = 1, 3 do
		local time = get_dig_time(caps.times, r, maxlevel)
		if time then
			if not mintime or  time < mintime then
				if mintime then
					unique = false
				end
				mintime = time
			end
		end
	end

	return mintime, unique
end

--- @param caps  table
--- @param group string
--- @return string
local function get_digging_list_item(caps, group)
	local mintime, unique_mintime
	mintime, unique_mintime = get_min_digtime(caps)
	if mintime and (mintime > 0 or (not unique_mintime)) then
		return S(
			'@1 blocks in @2s (minimal)',
			colorize('#bbb', S(group..'_dig')), string.format('%.2f', mintime)
		)
	elseif mintime and mintime == 0 then
		return S('@1 blocks instantly', colorize('#bbb', S(group..'_dig')))
	end

	return nil
end

--- @param item_string string
--- @return string|nil
return function(item_string)
	local tool_capabilities = items[item_string].tool_capabilities
	if not tool_capabilities or not tool_capabilities.groupcaps then return nil end

	local digging_strings = {}
	for group, caps in pairs(tool_capabilities.groupcaps) do
		if caps.times then
			local list_item = get_digging_list_item(caps, group)
			if list_item then
				digging_strings[#digging_strings + 1] = '  • ' .. list_item
			end
		end
	end

	return #digging_strings ~= 0
		and ('\n' ..
			colorize('#ee8', S('Digs')) .. ':\n' ..
				table.concat(digging_strings, '\n')
		)
		or nil
end
