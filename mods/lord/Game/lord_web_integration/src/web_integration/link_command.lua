local S = core.get_mod_translator()

--- @type web_integration.Player
local WebPlayer


--- @type table<number,string>
local FAIL_MESSAGES = {
	[403] = S('Your character is already linked to another account.'),
	[409] = S('Code already used.'),
	[410] = S('Code expired.'),
	[422] = S('Code not found.'),
	[429] = S('Too many attempts. Try again later.'),
}


--- @param player_name string
--- @param result      HTTPRequestResult
local function on_link_done(player_name, result)
	core.chat_send_player(player_name, result.code == 200
		and S('Your character is already linked to this account.')
		or  S('Character linked to your account on the site.')
	)
end

--- @param player_name string
--- @param result      HTTPRequestResult
local function on_link_fail(player_name, result)
	core.chat_send_player(player_name, FAIL_MESSAGES[result.code] or S('Failed to link character. Try again later.'))
end

--- @param player_name string
--- @param param       string
--- @return boolean, string
local function link_handler(player_name, param)
	local code = param:trim()
	if code == '' then
		return false, S('Enter the code from your account page on the site: /link <code>')
	end

	local is_sent = WebPlayer.link(
		player_name,
		code,
		function(result)
			on_link_done(player_name, result)
		end,
		function(result)
			on_link_fail(player_name, result)
		end
	)
	if not is_sent then
		return false, S('Failed to link character. Try again later.')
	end

	return true, S('Linking...')
end


return {
	--- @param web_player web_integration.Player
	register = function(web_player)
		WebPlayer = web_player
		core.register_chatcommand('link', {
			params      = '<code>',
			description = S('Link your character to your account on the site'),
			func        = link_handler,
		})
	end
}
