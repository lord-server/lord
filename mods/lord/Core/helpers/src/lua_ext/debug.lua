local debug_getinfo
	= debug.getinfo


local PROJECT_LOCATION = ''
local x_scheme_tpl = minetest.settings:get_bool('debug', false)
	and minetest.settings:get('debug.editor_x_scheme_tpl')
	or  nil

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

--- Shorten for `print(dump(...))`
--- @overload fun(any:any)
--- @param any    any
--- @param dumped table
function pd(any, dumped) -- luacheck: ignore unused global variable pd
	local file_full = __FILE__(1, true)
	local line      = __LINE__(1)

	term.print(get_file_line_term_string(file_full, line))

	print(dump(any, dumped))
end

--- @param func function
--- @return string
function debug.get_function_code(func)
	local func_info = debug_getinfo(func)
	local name = func_info.source:replace('^@','')
	local i    = 0
	local code = {}
	for line in io.lines(name) do
		i = i + 1
		if i >= func_info.linedefined then code[#code +1] = line end
		if i >= func_info.lastlinedefined then break end
	end

	return table.concat(code,'\n')
end

local up = io.dirname
PROJECT_LOCATION = up(up(up(up(up(up(__DIR__())))))) .. os.DIRECTORY_SEPARATOR

if not minetest.settings:get_bool('debug', false) then
	return
end


local function backtrace(depth)
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

local original_error = error
---
--- Terminates the last protected function called and returns `message` as the
--- error object. Function `error` never returns. Usually, `error` adds some
--- information about the error position at the beginning of the message, if the
--- message is a string. The `level` argument specifies how to get the error
--- position. With level 1 (the default), the error position is where the
--- `error` function was called. Level 2 points the error to where the function
--- that called `error` was called; and so on. Passing a level 0 avoids the
--- addition of error position information to the message.
---@overload fun(message:string)
---@param message string
---@param depth number
function error(message, depth)
	depth   = depth or 0
	message = message or term.stylize('~ no error message ~', term.style.italic .. term.style.red)

	term.print(term.stylize(('+'):rep(80), term.style.green))
	term.print('ERROR:', term.style.bold .. term.style.bright_red)
	term.print('  ' .. message, term.style.bright_red)
	term.print('')
	term.print('Stack trace:', term.style.bold .. term.style.bright_red)
	term.print(backtrace(depth + 1))
	term.print(term.stylize(('+'):rep(80), term.style.green))

	original_error(message, depth)
end
