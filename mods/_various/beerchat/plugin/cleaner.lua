
beerchat.register_callback('on_receive', function(msg_data)
	msg_data.message = msg_data.message:gsub('%c','')
end)

beerchat.register_callback('on_http_receive', function(msg_data)
	-- Trim spaces and newlines, add ">" to mark newlines in incoming message
	local msg = msg_data.text
		:gsub('%s+$','') -- Remove trailing space
		:gsub('<:[%w_]+:%d+>','') -- Remove long emoji codes
		:gsub('(%s)%s+','%1') -- Trim all whitespace
		:gsub('[\r\n]','\n  > ') -- Add line continuation markers
	if not msg:find("[^%c%p%s]") then
		-- Throw away messages that do not contain any words after cleanup
		return false
	end
	msg_data.text = msg
end)
