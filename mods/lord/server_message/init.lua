minetest.log("action", minetest.get_current_modname().." mod STARTED")

-- периодичность в секундах
local Message_period = 60*60
-- текст сообщения
local Message_text = "# Server: Хотите увидеть свой домик с высоты? "..
	"Узнать последние новости и посмотреть лучшие постройки сервера?\n"..
	"Тогда бегом сюда -> vk.com/minetest_lord. "..
	"Это и многое другое в группе ВК «Сервер Minetest L.O.R.D»"

local Timer = 0
minetest.register_globalstep(function(DTime)
	Timer = Timer + DTime;
	if (Timer >= Message_period)and(minetest.get_connected_players()[1] ~= nil) then
		minetest.chat_send_all(Message_text)
		Timer = 0
	end
end)

if minetest.settings:get_bool("msg_loading_mods") then
	minetest.log("action", minetest.get_current_modname() .. " mod LOADED")
end
