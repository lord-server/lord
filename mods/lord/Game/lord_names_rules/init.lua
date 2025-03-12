minetest.mod(function(mod)
	local S = minetest.get_mod_translator()

	minetest.register_on_prejoinplayer(function(usrname, ip)

		-- правила формирования имени
		local rules = {
			{
				match = function(name)
					return #name > 2
				end,
				check = "(v)",
				description = S("Your name must contain more than 2 symbols;"),
			},
			{
				match = function(name)
					return #name <= 19
				end,
				check = "(v)",
				description = S("Your name must be less than 19 symbols;"),
			},
			{
				match = function(name)
					return not string.match(name, '[^%a_-]')
				end,
				check = "(v)",
				description = S("Your name must contain letters only, symbol '-' and '_' are also allowed;"),
			},
			{
				match = function(name)
					return string.match(name, "^[A-Z]")
				end,
				check = "(v)",
				description = S("Your name must begin with capital letters;"),
			},
		}

		-- возвращает true, если name удовлетворяет всем условиям, и false в противном случае
		local function is_correct_name(name)
			local check_flag = true
			for _, rule in pairs(rules) do
				if not rule.match(name) then
					rule.check = "(x)"
					check_flag = false
				else
					rule.check = "(v)"
				end
			end

			return check_flag
		end
		local name = usrname
		if minetest.is_singleplayer() or minetest.player_exists(name) then
			return
		end
		if not is_correct_name(name) then
			local list_rules = ""
			--выводим правила сервера на русском языке
			for _, rule in pairs(rules) do
				list_rules = list_rules .. "\n" .. rule.check .. " " .. minetest.get_translated_string("ru", rule.description)
			end
			-- выводим правила сервера на английском языке
			list_rules = list_rules .. "\n\n" .. "Your name does not accepted with the server rules:"
			for _, rule in pairs(rules) do
				list_rules = list_rules .. "\n" .. rule.check .. " " .. rule.description
			end

			return "\n" .. minetest.get_translated_string("ru", S("Your name does not accepted with the server rules:"))
				.. list_rules
		end
	end)
end)
