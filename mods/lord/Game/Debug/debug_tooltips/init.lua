local colorize = core.colorize


core.mod(function(mod)

	--- @diagnostic disable-next-line: need-check-nil
	local debug = core.settings:get_bool('debug', false)
	if not debug then
		return
	end


	local items = core.registered_items

	--- @param item_string string
	--- @return string|nil
	tt.register_snippet(function(item_string)
		local groups = items[item_string].groups

		local groups_strings = {}
		for group, value in pairs(groups or {}) do
			groups_strings[#groups_strings + 1] = ' • ' .. group .. ': ' .. value
		end


		return '\n\n' .. colorize('#aaa', ''
			.. '--------------------\n'
			.. item_string
			.. (#groups_strings ~= 0
				and '\ngroups:\n' .. table.concat(groups_strings, '\n')
				or  ''
			)
		)
	end)

end)
