
local default_password = minetest.settings:get("default_password")
if not default_password or '' == default_password then
	-- Do not use if default password is not set
	return
end

local only_new_players = minetest.settings:get("beerchat.password.mode") == "new"
local show_formspec = minetest.settings:get_bool("beerchat.password.use_form", true)
local initial_delay = tonumber(minetest.settings:get("beerchat.password.delay")) or 60
local message = minetest.settings:get("beerchat.password.message") or "*** Please change your password"
local fs_message = minetest.formspec_escape(message)

local password_notify = {}

local function validate_password(name)
	local auth_data = minetest.get_auth_handler().get_auth(name)
	if auth_data and auth_data.password then
		return not (minetest.check_password_entry(name, auth_data.password, default_password)
			or minetest.check_password_entry(name, auth_data.password, ""))
	end
	return true
end

local function handle_player(name, last_login)
	if minetest.get_player_by_name(name) and not validate_password(name) then
		password_notify[name] = minetest.get_us_time()
		minetest.chat_send_player(name, "\n" .. message)
		if last_login and show_formspec then
			-- Formspec notification if player has not changed password during first login
			minetest.show_formspec(name, "MT_PAUSE_MENU",
				"formspec_version[3]size[14,3]bgcolor[#66F;both;]button_exit[0.5,0.5;13,1;ok;I will]"
				.. "style_type[*;textcolor=#F00;font_size=*1.2]label[0.5,2;".. fs_message .."]"
			)
		end
	end
end

beerchat.register_callback('before_send_on_channel', function(name)
	-- Only run checks if account is marked for notifications
	if password_notify[name] then
		if minetest.get_us_time() - password_notify[name] > 4000000 then
			-- If marked at login do validation again every 4 seconds
			if validate_password(name) then
				-- Password was updated and is now valid, stop complaining
				password_notify[name] = nil
				return
			else
				password_notify[name] = minetest.get_us_time()
			end
		end
		-- Complain about bad password, this can continue for few seconds after password change
		minetest.chat_send_player(name, message)
	end
end)

beerchat.register_callback('after_joinplayer', function(player, last_login)
	if not only_new_players or last_login == nil then
		local name = player:get_player_name()
		minetest.after(initial_delay, function() handle_player(name, last_login) end)
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	password_notify[name] = nil
end)
