-- периодичность в секундах
local MESSAGE_PERIOD = 60 * 60
-- текст сообщения
local Message_text   = minetest.colorize("#0f0", "# Server: ") .. "Хотите увидеть свой домик с высоты? " ..
	"Узнать последние новости и посмотреть лучшие постройки сервера?\n" ..
	"Группа ВК: " .. minetest.colorize("#00f", "https://vk.com/minetest_lord") .. " (новости, фоточки и пр.)\n" ..
	"Discord: " .. minetest.colorize("#00f", "https://discord.gg/uTX3mbb") ..
	" (общаемся, задаём вопросы, делимся настроением)\n" ..
	"YouTube: " .. minetest.colorize("#00f", "https://youtube.com/@lord-server") .. " (стримы и небольшие видео)\n" ..
	"Сайт: " .. minetest.colorize("#00f", "https://lord-server.ru/") .. " (есть карта мира)\n" ..
	"GitHub: " .. minetest.colorize("#00f", "https://github.com/lord-server/lord") .. "\n"

local Timer          = 0
minetest.register_globalstep(function(DTime)
	Timer = Timer + DTime;
	if (Timer >= MESSAGE_PERIOD) and (minetest.get_connected_players()[1] ~= nil) then
		minetest.chat_send_all(Message_text)
		Timer = 0
	end
end)
