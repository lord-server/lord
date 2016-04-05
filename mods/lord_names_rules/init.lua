local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local names_rules = { -- правила формирования имени
	{	rule = function(S)
			return #S > 2
		end,
		description = SL("your name must contain more than 2 symbols;"),
	},
	{	rule = function(S)
			return #S < 14
		end,
		description = SL("your name must be less than 14 symbols;"),
	},
	{	rule = function(S)
			return not string.match(S, '[^%a_-]')
		end,
		description = SL("your name must contain only letters, also allows '-' and '_';"),
	},
	{	rule = function(S)
			return string.match(S, "^[A-Z]")
		end,
		description = SL("your name must begin with capital letters;"),
	},
}

local function check_name_player(name) -- возвращает true, если name удовлетворяет всем условиям, и false в противном случае
	local S = name -- имя игрока..
	for _, i in pairs(names_rules) do
		if not i.rule(S) then return false end
	end
	return true
end

local function registered_player(name) -- если игрок уже зарегистрирован, возвращает true
	local file = minetest.get_worldpath().."/players/"..name
	if os.rename(file, file) then return true else return false end
end

minetest.register_on_prejoinplayer(function(name, ip) -- попытка клиента присоединиться к серверу
	local list_rules = ""
	for _, i in pairs(names_rules) do
		list_rules = list_rules.."\n- "..i.description
	end
	if (not check_name_player(name))and(not registered_player(name)) then -- ошибка в имени и игрок ещё не зарегистрирован
		return "\n"..SL("Invalid character name")..list_rules
	end
end)

minetest.register_on_joinplayer(function(player) -- присоединение клиента к серверу
	local name = player:get_player_name()
	if not check_name_player(name) then -- ошибка в имени
		minetest.chat_send_player(name, SL("Invalid character name. Contact to the administration."))
	end
end)

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
