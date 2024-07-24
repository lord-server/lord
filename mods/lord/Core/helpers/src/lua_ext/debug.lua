local debug_getinfo
	= debug.getinfo

--- @param depth number
--- @return string
function __FILE__(depth) -- luacheck: ignore unused global variable __FILE__
	return debug_getinfo(3 + (depth or 0), 'S').source
end
--- @param depth number
--- @return number
function __LINE__(depth) -- luacheck: ignore unused global variable __LINE__
	return debug_getinfo(3 + (depth or 0), 'l').currentline
end
--- @param depth number
--- @return string
function __FILE_LINE__(depth) -- luacheck: ignore unused global variable __FILE_LINE__
	return __FILE__(depth) .. ':' .. __LINE__(depth)
end
--- @param depth number
--- @return string
function __FUNC__(depth)  -- luacheck: ignore unused global variable __FUNC__
	return debug_getinfo(2 + (depth or 0), 'n').name
end

--- @param func function
--- @return string
function debug.get_function_code(func)
	local func_info = debug.getinfo(func)
	local name = func_info.source:gsub("^@","")
	local i    = 0
	local code = {}
	for line in io.lines(name) do
		i=i+1
		if i >= func_info.linedefined then code[#code +1] = line end
		if i >= func_info.lastlinedefined then break end
	end

	return table.concat(code,"\n")
end
