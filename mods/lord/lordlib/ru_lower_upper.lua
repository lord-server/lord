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
function string.lower(str) -- luacheck: ignore setting read-only field of global string
	local new_str = old_lower(str)
	for S, s in pairs(Alphabet) do
		new_str = string.gsub(new_str, S, s)
	end
	return new_str
end

function string.upper(str) -- luacheck: ignore setting read-only field of global string
	local new_str = old_upper(str)
	for S, s in pairs(Alphabet) do
		new_str = string.gsub(new_str, s, S)
	end
	return new_str
end
