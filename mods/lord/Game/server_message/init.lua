local colorize = minetest.colorize

-- периодичность в секундах
local MESSAGE_PERIOD = 30 * 60
-- текст сообщения
local resources = {
	{ title = 'Website',  url = 'https://lord-server.ru/' },
	{ title = 'Discord',  url = 'https://www.discord.gg/YcT5FuQwUT' },
	{ title = 'YouTube',  url = 'https://www.youtube.com/@lord-server' },
	{ title = 'VK Group', url = 'https://vk.com/minetest_lord' },
	{ title = 'GitHub',   url = 'https://github.com/lord-server/lord' },
}

local timer = 0
minetest.register_globalstep(function(delta_time)
	timer = timer + delta_time;
	if (timer >= MESSAGE_PERIOD) and (minetest.get_connected_players()[1] ~= nil) then
		local used_indices = {} --используется для хранения индексов уже выбранных ресурсов
		local message = colorize('#0f0', '\n# Server: Оставайтесь на связи!')
			.. ' (кликните по ссылке с Ctrl)\n'
		message = message .. '+---------------------------------------------------------------------+\n'
		message = message .. '|  ' ..
			colorize('#ff0', 'Telegram:') ..' https://t.me/lord_server_ru                              |\n'
		message = message .. '+---------------------------------------------------------------------+\n'

		for i = 1, 2 do
			local index
			-- Цикл ниже гарантирует, что индекс будет выбран заново, пока он не окажется уникальным среди уже использованных
			repeat
			index = math.random(#resources)
			until not used_indices[index]
			used_indices[index] = true
			message = message .. resources[index].title .. ': ' .. resources[index].url .. '\n'
		end
		minetest.chat_send_all(message .. '\n')
		timer = 0
		used_indices = {}  -- Явная очистка таблицы после использования
	end
end)
