local pairs, string_gsub, table_contains
	= pairs, string.gsub, table.contains

-- правка стандартных функций преобразования регистра
-- для работы с кириллицей

-- локально определяем русский алфавит, он же - "словарь" для замены символов
local Alphabet = {
	["А"] = "а",
	["Б"] = "б",
	["В"] = "в",
	["Г"] = "г",
	["Д"] = "д",
	["Е"] = "е",
	["Ё"] = "ё",
	["Ж"] = "ж",
	["З"] = "з",
	["И"] = "и",
	["Й"] = "й",
	["К"] = "к",
	["Л"] = "л",
	["М"] = "м",
	["Н"] = "н",
	["О"] = "о",
	["П"] = "п",
	["Р"] = "р",
	["С"] = "с",
	["Т"] = "т",
	["У"] = "у",
	["Ф"] = "ф",
	["Х"] = "х",
	["Ц"] = "ц",
	["Ч"] = "ч",
	["Ш"] = "ш",
	["Щ"] = "щ",
	["Ъ"] = "ъ",
	["Ь"] = "ь",
	["Э"] = "э",
	["Ю"] = "ю",
	["Я"] = "я",
}

-- локально сохраняем старые функции для использования в новых
local old_lower = string.lower
local old_upper = string.upper


-- переопределяем старые функции для работы с русским алфавитом
-- TODO use utf8 module instead

--- string.lower с учётом русского
--- @param str string
--- @return string
function string.lower(str)
	local new_str = old_lower(str)
	for S, s in pairs(Alphabet) do
		new_str = string_gsub(new_str, S, s)
	end
	return new_str
end

--- string.upper с учётом русского
--- @param str string
--- @return string
function string.upper(str)
	local new_str = old_upper(str)
	for S, s in pairs(Alphabet) do
		new_str = string_gsub(new_str, s, S)
	end
	return new_str
end

--- @param table table
--- @return boolean
function string:is_one_of(table)
	return table_contains(table, self)
end

--- @return string
function string:first_to_upper()
	return self:sub(1, 1):upper() .. self:sub(2)
end

--- @return string
function string:title()
	local result = ""
	for _, word in ipairs(self:split(" ")) do
		result = string.format("%s%s ", result, word:first_to_upper())
	end
	return result:trim()
end

--- @return string
function string:to_headline()
	local result = ""
	for _, word in ipairs(self:split(" ")) do
		result = string.format("%s%s ", result, word:first_to_upper())
	end
	return result:trim()
end

--- @return string
function string:remove_underscores()
	return self:gsub("_", " ")
end

--- @param prefix string
--- @return boolean
function string:starts_with(prefix)
	return self:sub(1, #prefix) == prefix
end

--- @param suffix string
--- @return boolean
function string:ends_with(suffix)
	return self:sub(-#suffix) == suffix
end

--- @param sub_string string
function string:contains(sub_string)
	return self:find(sub_string, 1, true) ~= nil
end

--- Same as `string.gsub()`, but returns only result string without count of matches.
--- See `string.gsub()` docs.
--- @overload fun(pattern:string, replacement:string): string
--- @param pattern     string
--- @param replacement string|fun()
--- @param n           number
--- @return string
function string:replace(pattern, replacement, n)
	-- take only first returned value from gsub, to return only 1 value from this function
	local result_string = self:gsub(pattern, replacement, n)

	return result_string
end

--- @overload fun(pattern:string): string
--- @param pattern string
--- @param n       number
--- @return string
function string:remove(pattern, n)
	return self:replace(pattern, '', n)
end

--- @return string
function string:reg_escape()
	-- take only first returned value from gsub, to return only 1 value from this function
	local escaped = self:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]', '%%%0')

	return escaped
end

--- @overload fun()
--- @overload fun(delimiter:string)
--- @overload fun(delimiter:string, processor:fun(part:string):any)
--- @param delimiter string                default `" "` (space)
--- @param processor fun(part:string): any
--- @return table
function string:vxr_split(delimiter, processor)
	delimiter = delimiter or ' '

	local result = {}
	for part in self:gmatch('([^' .. delimiter .. ']+)') do
		result[#result + 1] = processor and processor(part) or part
	end

	return result
end
