

core.mod(function(mod)
	local environment = core.settings:get('environment') or 'production'
	if environment == 'production' then
		return
	end

	local count_file_path = mod.path .. '/.ghost_blocks_count.txt'
	local state_file_path = mod.path .. '/.ghost_blocks.lua'

	local show_diff  = mod.settings:get_bool('show_diff', true)
	local save_state = mod.settings:get_bool('save_state', false)

	--- @return number, table<string, boolean>
	local function count_ghost_blocks()
		local ghost_count = 0
		local ghost_names = {}

		for name, _ in pairs(core.registered_nodes) do
			if name:starts_with('defaults:') then
				ghost_count = ghost_count + 1
				ghost_names[name] = true
			end
		end

		return ghost_count, ghost_names
	end

	--- @param current_ghost_names table<string, boolean>
	--- @param previous_ghost_names table<string, boolean>
	local function print_diff(current_ghost_names, previous_ghost_names)
		term.print('Added ghost blocks:', term.style.bold)
		for name, _ in pairs(current_ghost_names) do
			if not previous_ghost_names[name] then
				term.print('  ' .. name, term.style.green)
			end
		end

		term.print('Removed ghost blocks:', term.style.bold)
		for name, _ in pairs(previous_ghost_names) do
			if not current_ghost_names[name] then
				term.print('  ' .. name, term.style.red)
			end
		end
	end

	-- Run after all mods are loaded
	core.after(0, function()
		local previous_count = tonumber(tostring(io.read_from_file(count_file_path))) or 0
		local current_count, current_ghost_names = count_ghost_blocks()
		if previous_count == current_count then
			return
		end

		mod.logger.error('Ghost blocks count: %d (previous: %d)', current_count, previous_count)

		local success
		success = io.write_to_file(count_file_path, tostring(current_count))
		if not success then
			mod.logger.error('Failed to write ghost blocks count to file')
		end

		if show_diff and io.file_exists(state_file_path) then
			local previous_ghost_names = dofile(state_file_path)
			print_diff(current_ghost_names, previous_ghost_names)
		else
			if not io.file_exists(state_file_path) then
				mod.logger.error('Previous state file not found')
			end
			mod.logger.error('To show diff, set setting `lord_ghost_debug.show_diff = true`')
			mod.logger.error('You need to have the previous state in the file ' .. state_file_path)
			mod.logger.error(
				'If you does not have it:\n' ..
				'  - stash your changes\n' ..
				'  - enable `lord_ghost_debug.show_diff`\n' ..
				'  - run the game again\n' ..
				'  - unstash your changes and run'
			)
		end

		if save_state then
			success = io.write_to_file(state_file_path, core.serialize(current_ghost_names))
			if not success then
				mod.logger.error('Failed to write ghost blocks state to file')
			end
		end
	end)
end)
