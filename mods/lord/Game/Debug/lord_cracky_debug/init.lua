-- luacheck:ignore 561

core.mod(function(mod)
	local environment = core.settings:get('environment') or 'production'
	if environment == 'production' or not mod.settings:get_bool('enabled', false) then
		return
	end

	local term = Voxrame.terminal

	local dump_file_path = mod.path .. '/.cracky_dump.txt'

	--- @param groups table<string, any>
	--- @return string
	local function format_groups(groups)
		local keys = {}
		for key in pairs(groups) do
			if key ~= 'cracky' then
				table.insert(keys, key)
			end
		end
		table.sort(keys)

		local parts = {}
		for _, key in ipairs(keys) do
			table.insert(parts, key .. '=' .. tostring(groups[key]))
		end

		return table.concat(parts, ', ')
	end

	--- @param times table<number, number>?
	--- @return string
	local function format_times(times)
		if not times then
			return '-'
		end

		local ratings = {}
		for rating in pairs(times) do
			table.insert(ratings, rating)
		end
		table.sort(ratings)

		local parts = {}
		for _, rating in ipairs(ratings) do
			table.insert(parts, rating .. '=' .. times[rating])
		end

		return '{ ' .. table.concat(parts, ', ') .. ' }'
	end

	--- @return table<number, string[]> nodes grouped by cracky rating
	--- @return table<string, table<string, any>> raw `groups` table per node name
	local function collect_cracky_nodes()
		local by_rating = {}
		local node_groups = {}

		for name, def in pairs(core.registered_nodes) do
			local groups = def.groups or {}
			local cracky = groups.cracky

			if cracky and cracky > 0 then
				by_rating[cracky] = by_rating[cracky] or {}
				table.insert(by_rating[cracky], name)
				node_groups[name] = groups
			end
		end

		return by_rating, node_groups
	end

	--- @return table<string, table> cracky groupcaps, keyed by tool name
	--- @return table<number, boolean> set of ratings covered by at least one tool
	local function collect_cracky_tools()
		local tools = {}
		local covered_ratings = {}

		for name, def in pairs(core.registered_tools) do
			local caps = def.tool_capabilities
			local cap = caps and caps.groupcaps and caps.groupcaps.cracky

			if cap then
				tools[name] = cap

				for rating in pairs(cap.times or {}) do
					covered_ratings[rating] = true
				end
			end
		end

		return tools, covered_ratings
	end

	core.after(0, function()
		local by_rating, node_groups = collect_cracky_nodes()
		local tools, covered_ratings = collect_cracky_tools()

		local ratings = {}
		for rating in pairs(by_rating) do
			table.insert(ratings, rating)
		end
		table.sort(ratings)

		local lines = {}
		local warnings = {}

		table.insert(lines, '=== TOOLS (groupcaps.cracky) ===')
		local tool_names = {}
		for name in pairs(tools) do
			table.insert(tool_names, name)
		end
		table.sort(tool_names)
		for _, name in ipairs(tool_names) do
			local cap = tools[name]
			table.insert(lines, string.format(
				'%-40s maxlevel=%-4s uses=%-6s times=%s',
				name, tostring(cap.maxlevel), tostring(cap.uses), format_times(cap.times)
			))
		end

		table.insert(lines, '')
		table.insert(lines, '=== NODES by groups.cracky ===')
		for _, rating in ipairs(ratings) do
			local names = by_rating[rating]
			table.sort(names)

			local covered = covered_ratings[rating]
			if not covered then
				table.insert(warnings, string.format(
					'cracky=%d used by %d node(s), but NO registered tool has times[%d] — undiggable by any pickaxe',
					rating, #names, rating
				))
			end

			table.insert(lines, string.format(
				'-- cracky = %d (%d nodes)%s --',
				rating, #names, covered and '' or '  [!! NO TOOL KNOWS THIS RATING !!]'
			))

			for _, name in ipairs(names) do
				local groups = node_groups[name]
				if groups.level then
					table.insert(warnings, string.format(
						'%s has groups.level=%s set — dead weight under maxlevel=0 scheme, or a hard block if maxlevel < level',
						name, tostring(groups.level)
					))
				end

				table.insert(lines, string.format('    %-50s %s', name, format_groups(groups)))
			end
		end

		table.insert(lines, '')
		table.insert(lines, '=== Ratings declared by tools but unused by any node (possible leftover/typo) ===')
		local unused_ratings = {}
		for rating in pairs(covered_ratings) do
			if not by_rating[rating] then
				table.insert(unused_ratings, rating)
			end
		end
		table.sort(unused_ratings)
		for _, rating in ipairs(unused_ratings) do
			table.insert(lines, string.format('cracky=%d — no node uses it', rating))
		end

		local content = table.concat(lines, '\n') .. '\n'
		local success = io.write_to_file(dump_file_path, content)
		if not success then
			mod.logger.error('Failed to write cracky dump to file')
		end

		mod.logger.action('Cracky audit: %d rating(s) in use, dumped to %s', #ratings, dump_file_path)
		term.print('Cracky audit written to ' .. dump_file_path, term.style.bold)

		for _, warning in ipairs(warnings) do
			mod.logger.error(warning)
			term.print('  !! ' .. warning, term.style.red)
		end
	end)
end)
