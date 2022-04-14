local script_path = minetest.get_modpath("ping").."/ping.sh"

minetest.register_chatcommand("ping", {
	description = "Ping 8.8.8.8",
	privs = {server = true},
	func = function(player, param)
		local host = "8.8.8.8"
		if #param ~= 0 then
			host = param
		end

		local cmd = string.format("sh %s %s", script_path, host)
		print(cmd)
		local output = io.popen(cmd, "r")
		if output == nil then
			return false, "Не удалось запустить ping"
		end
		local content = output:read("*all")
		output:close()
		return true, content
	end,
})
