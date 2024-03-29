local debug_getinfo
	= debug.getinfo

--- @param depth number
--- @return string
function __FILE__(depth)
	return debug_getinfo(3 + (depth or 0), 'S').source
end
--- @param depth number
--- @return number
function __LINE__(depth)
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
