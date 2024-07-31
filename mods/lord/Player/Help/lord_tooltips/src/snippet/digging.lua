local items,                     colorize
		= minetest.registered_items, minetest.colorize

local S = minetest.get_translator(minetest.get_current_modname())


--- @param caps table
--- @return number,boolean
local function get_min_digtime(caps)
	local maxlevel = caps.maxlevel or 1
	local unique = maxlevel > 1 and false or true
	--- @type number
	local mintime

	if caps.times then
		for r=1,3 do
			local time = caps.times[r]
			if time and maxlevel > 1 then
				time = time / maxlevel
			end
			if time and ((not mintime) or (time < mintime)) then
				if mintime and (time < mintime) then
					unique = false
				end
				mintime = time
			end
		end
	end

	return mintime, unique
end


--- @param item_string string
--- @return string|nil
return function(item_string)
	local tool_capabilities = items[item_string].tool_capabilities
	if not tool_capabilities or not tool_capabilities.groupcaps then return nil end

	local digging_strings = {}
	for group, caps in pairs(tool_capabilities.groupcaps) do
		local mintime, unique_mintime
		local list_item
		if caps.times then
			mintime, unique_mintime = get_min_digtime(caps)
			if mintime and (mintime > 0 or (not unique_mintime)) then
				list_item =  S('@1 blocks in @2s (minimal)', colorize('#bbb', S(group..'_dig')), string.format('%.2f', mintime))
				digging_strings[#digging_strings+1] = '  • ' .. list_item
			elseif mintime and mintime == 0 then
				list_item = S('@1 blocks instantly', colorize('#bbb', S(group..'_dig')))
				digging_strings[#digging_strings+1] = '  • ' .. list_item
			end

		end
	end

	return #digging_strings ~= 0
		and (colorize('#ee8', '\n' .. S('Digs')) .. ':\n' .. table.concat(digging_strings, '\n'))
		or nil
end
