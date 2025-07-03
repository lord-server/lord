local debug_getinfo
	= debug.getinfo


local PROJECT_LOCATION = ''

local debug_mode   = minetest.settings:get_bool('debug', false)
local x_scheme_tpl = debug_mode	and minetest.settings:get('debug.editor_x_scheme_tpl') or  nil

--- @param file_full string
--- @param line string
--- @return string
local function get_x_scheme_url(file_full, line)
	local file_relative = file_full:replace(PROJECT_LOCATION:reg_escape(), '')

	return x_scheme_tpl
		:replace('%${file}', file_full)
		:replace('%${file_relative}', file_relative)
		:replace('%${line}', line)
		:replace('%${project}', PROJECT_LOCATION)
end

--- @param file_full string
--- @param line      number
local function get_file_line_term_string(file_full, line)
	local file = file_full:replace(PROJECT_LOCATION:reg_escape(), '')

	local file_line_styled = ''
		.. term.stylize('@ ', term.style.bright_yellow)
		.. term.stylize(file, term.style.yellow)
		.. term.stylize(':', term.style.bright_white)
		.. term.stylize(line, term.style.green)

	return x_scheme_tpl
		and term.link(file_line_styled, get_x_scheme_url(file_full, line))
		or  file_line_styled
end

--- @param depth number  Call stack nesting level (default: `0`)
--- @param full  boolean get full path; default: `false`
--- @return string
function __FILE__(depth, full) -- luacheck: ignore unused global variable __FILE__
	full = full or false
	local full_file = debug_getinfo(2 + (depth or 0), 'S').source:replace('^@', '')

	return full
		and full_file
		or  full_file:replace(PROJECT_LOCATION:reg_escape(), '')
end

--- @param depth number Call stack nesting level (default: `0`)
--- @return number
function __LINE__(depth) -- luacheck: ignore unused global variable __LINE__
	return debug_getinfo(2 + (depth or 0), 'l').currentline
end

--- @param depth number  Call stack nesting level (default: `0`)
--- @param full  boolean get full path; default: `false`
--- @return string
function __FILE_LINE__(depth, full) -- luacheck: ignore unused global variable __FILE_LINE__
	depth = depth or 0
	return __FILE__(depth + 1, full) .. ':' .. __LINE__(depth + 1)
end

--- @param depth number Call stack nesting level (default: `0`)
--- @return string
function __FUNC__(depth)  -- luacheck: ignore unused global variable __FUNC__
	return debug_getinfo(2 + (depth or 0), 'n').name
end

--- @param depth number Call stack nesting level (default: `0`)
--- @return string
function __DIR__(depth)
	local file_path = __FILE__(depth)
	local dir_path  = file_path:match('(.*[/\\])') or './'

	return dir_path
end


local up = io.dirname
PROJECT_LOCATION = up(up(up(up(up(up(__DIR__())))))) .. os.DIRECTORY_SEPARATOR


--- @param line_code string
--- @return table, number array of passed params & max string length of param
function debug.get_passed_params(line_code)
	local params_str = (line_code:match('%b()') or '')
		:sub(2, -2):gsub('%s+', '')

	local params           = {}
	local buffer           = ''
	local bracket_depth    = 0
	local max_param_length = 0
	for i = 1, #params_str do
		local char = params_str:sub(i, i)

		if char == '(' then
			bracket_depth = bracket_depth + 1
			buffer        = buffer .. char
		elseif char == ')' then
			bracket_depth = bracket_depth - 1
			buffer        = buffer .. char
		elseif char == ',' and bracket_depth == 0 then
			table.insert(params, buffer:trim())
			max_param_length = #buffer > max_param_length and #buffer or max_param_length
			buffer = ''
		else
			buffer = buffer .. char
		end
	end

	if buffer ~= '' then
		table.insert(params, buffer:trim())
	end

	return params, max_param_length
end

--- @param file      string
--- @param line_from number
--- @param line_to   number
--- @return string|nil
function debug.get_file_code(file, line_from, line_to)
	line_to = line_to or line_from

	local code = {}
	local current_line = 0
	for line in io.lines(file) do
		current_line = current_line + 1
		if current_line >  line_to   then  break                    end
		if current_line >= line_from then  table.insert(code, line) end
	end

	return table.concat(code, '\n')
end

--- @param func function
--- @return string
function debug.get_function_code(func)
	local func_info = debug_getinfo(func)
	local name = func_info.source:replace('^@','')

	return debug.get_file_code(name, func_info.linedefined, func_info.lastlinedefined)
end

--- @param depth number
local function backtrace(depth)
	depth = depth or 0
	depth = depth + 2

	local i = 1
	local trace = ''
	while true do
		local info = debug.getinfo(depth, 'Slnf')
		if not info then
			break
		end

		trace = trace
			.. term.stylize(('%4s   '):format(i), term.style.italic .. term.style.dim)
			.. (info.what == 'C'
				and term.stylize('@', term.style.bright_yellow) .. ' [C]'
				or  get_file_line_term_string(info.source:replace('^@', ''), info.currentline)
			)
			.. term.stylize(': in ' .. (info.name or info.what), term.style.cyan)
			.. '\n'

		depth = depth + 1
		i = i + 1
	end

	return trace
end

--- Dumps all passed params, also show `@ <file>:<line>` where `pdt()` was called.
---
--- If `with_trace` is `true` additionally prints stack trace from place of call.
---
--- If your terminal supports links, every `@ <file>:<line>` will linked to open IDE, see `readme.md` to configure.
---
--- @param depth      number  call stack depth to start from
--- @param with_trace boolean print trace or not
--- @param ...        any     params to dump
function print_dump(depth, with_trace, ...)
	depth = depth or 0
	local file_full = __FILE__(1 + depth, true)
	local line      = __LINE__(1 + depth)

	term.print(get_file_line_term_string(file_full, line))
	if with_trace then
		term.print(backtrace(2 + depth))
	end

	local passed_params, max_param_length = debug.get_passed_params(debug.get_file_code(file_full, line))
	max_param_length = max_param_length

	for i = 1, select('#', ...) do
		local name = passed_params[i] or ('<' .. i .. '>')
		name = (' '):rep(max_param_length - #name) .. name
		local value = select(i, ...)
		print(term.stylize(name .. ':', term.style.cyan) .. ' ' .. (
			type(value) == 'function'
				and debug.get_function_code(value)
				or  dump(value)
		))
	end
end

--- Dumps all passed params, also show `@ <file>:<line>` & stack trace where `pd()` was called.
--- Shorten for `print_dump(0, true, ...)`.
--- See `readme.md` to configure your IDE to open `<file>:<line>` links from terminal.
--- @param ... any
function pdt(...) -- luacheck: ignore unused global variable pdt
	print_dump(1, true, ...)
end

--- Dumps all passed params, also show `@ <file>:<line>` where `pd()` was called.
--- Shorten for `print_dump(0, false, ...)`.
--- See `readme.md` to configure your IDE to open `<file>:<line>` links from terminal.
--- @param ... any
function pd(...) -- luacheck: ignore unused global variable pd
	print_dump(1, false, ...)
end


local original_error_handler = core.error_handler
---@overload fun(message:string)
---@param message string
---@param depth number
function core.error_handler(message, depth)
	depth   = depth or 0
	message = message or term.stylize('~ no error message ~', term.style.italic .. term.style.red)
	message = message:gsub('%.%.%.[^:]+:[0-9]+: ', '')

	if debug_mode then
		term.print(term.stylize(('+'):rep(80), term.style.green))
		term.print('ERROR:', term.style.bold .. term.style.bright_red)
		term.print('  ' .. message, term.style.bright_red)
		term.print('')
		term.print('Stack trace:', term.style.bold .. term.style.bright_red)
		term.print(backtrace(depth))
		term.print(term.stylize(('+'):rep(80), term.style.green))

		return 'Debug mode is `on`. See you terminal.'
	else
		return original_error_handler(message, depth)
	end
end
