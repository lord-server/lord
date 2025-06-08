minetest.mod(function(mod)
	local resources = require('messages.resources')
	local facts     = require('messages.facts')

	local S = minetest.get_mod_translator()
	local colorize = minetest.colorize

	-- периодичность в секундах
	local MESSAGE_PERIOD = 30 * 60

	local timer = 0
	local show_links = true -- флаг для переключения между "ссылками" и "фактами"
	minetest.register_globalstep(function(delta_time)
		timer = timer + delta_time;
		if (timer >= MESSAGE_PERIOD) and (minetest.get_connected_players()[1] ~= nil) then
			local message = ''
			if not show_links then
				local used_indices = {} --используется для хранения индексов уже выбранных ресурсов
				message = message .. colorize('#0f0', '\n# Server: ' .. S('Stay in connect!'))
				.. S(' (click on the link with Ctrl)') .. ' \n'
				message = message .. colorize('#ff0', 'Telegram:') ..' https://t.me/lord_server_ru\n'

				for i = 1, 2 do
					local index
					-- Цикл ниже гарантирует, что индекс будет выбран заново,
					-- пока он не окажется уникальным среди уже использованных
					repeat
						index = math.random(#resources)
					until not used_indices[index]
					used_indices[index] = true
					message = message .. colorize('#ff0', resources[index].title) .. ': '
					.. resources[index].url .. '\n'
				end
			else
				local fact = facts[math.random(#facts)]
				message = message .. colorize('#0f0', '# Server: ' .. S('Fun fact:')) .. '\n'
				message = message .. colorize('#ff0', fact.title) .. ': ' .. '\n' .. fact.text .. '\n'
				.. '\n' -- пустая строка чтоб отделить от сообщения с кланами
			end
			-- Отдельное информационное сообщение
			message = message .. colorize(clans.COLOR, S('Clans: '))
				.. S('Join the clan and find loyal allies! Learn more on the website:')
				.. ' https://lord-server.ru/clans\n'
			minetest.chat_send_all(message .. '\n')
			timer = 0
			show_links = not show_links -- переключаем флаг для следующего сообщения
		end
	end)

end)
