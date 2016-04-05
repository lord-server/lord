local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local file_name = minetest.get_worldpath().."/mail_list.txt"

function get_mail(name)
	local file = io.open(file_name, "r")
	if not file then return end
	local str = file:read("*a")
	io.close(file)
	local tab = minetest.deserialize(str)
	if not tab then return end
	if not name then
		return tab
	else
		if not tab[name] then return end
		return tab[name]
	end
end

minetest.register_privilege("mail", {
	description = SL("Can register e-mail."),
	give_to_singleplayer= false,
})

minetest.register_chatcommand("setmail", {
	privs = {mail = true},
	params = "<mail>",
	description = SL("Register your e-mail"),
	func = function(name, param)
		if (not param)or(param == "") then minetest.chat_send_player(name, SL("No <mail>!")) return end
		local tab = get_mail()
		if not tab then tab = {} end
		tab[name] = param
		local file = io.open(file_name, "w")
		file:write(minetest.serialize(tab))
		io.close(file)
	end,
})

minetest.register_chatcommand("getmail", {
	privs = {mail = true},
	description = SL("Show your e-mail"),
	func = function(name)
		local mail = get_mail(name)
		if not mail then minetest.chat_send_player(name, SL("No mail!"))
		else minetest.chat_send_player(name, SL("Your mail:").." "..mail)
		end
	end,
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
