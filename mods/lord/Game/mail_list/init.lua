local S = minetest.get_mod_translator()

local file_name = minetest.get_worldpath() .. "/mail_list.txt"

function get_mail(name)
	local tab = minetest.deserialize(io.read_from_file(file_name) or '')
	if not tab then return end
	if not name then
		return tab
	else
		if not tab[name] then return end
		return tab[name]
	end
end

minetest.register_privilege("mail", {
	description          = S("Can register e-mail."),
	give_to_singleplayer = false,
})

minetest.register_chatcommand("setmail", {
	privs       = { mail = true },
	params      = "<mail>",
	description = S("Register your e-mail"),
	func        = function(name, param)
		if (not param) or (param == "") then
			minetest.chat_send_player(name, S("No <mail>!"))
			return
		end
		local tab = get_mail()
		if not tab then tab = {} end
		tab[name] = param
		io.write_to_file(file_name, minetest.serialize(tab))
	end,
})

minetest.register_chatcommand("getmail", {
	privs       = { mail = true },
	description = S("Show your e-mail"),
	func        = function(name)
		local mail = get_mail(name)
		if not mail then
			minetest.chat_send_player(name, S("No mail!"))
		else
			minetest.chat_send_player(name, S("Your mail:") .. " " .. mail)
		end
	end,
})
