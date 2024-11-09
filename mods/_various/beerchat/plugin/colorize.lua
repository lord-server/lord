--luacheck: no_unused_args
--
-- Allow using colors on chat messages by sending "(#f00)Red (#0f0)Green (#00f)Blue"
--
-- Configuration to allow on selected chat channels:
--   beerchat.colorize_channels = channel1, channel2, channel3
-- Configuration to allow on all chat channels:
--   beerchat.colorize_channels = *
-- Configuration to allow only on channel named * (not sure why...):
--   beerchat.colorize_channels = *,
--

local colorize_channels = minetest.settings:get("beerchat.colorize_channels")

if colorize_channels == "*" then

	-- Colorize all chat channels

	beerchat.register_callback('before_send_on_channel', function(name, msg)
		msg.message = msg.message:gsub('%((%#%x%x%x)%)', string.char(0x1B) .. '(c@%1)')
	end)

elseif colorize_channels then

	-- Colorize only specific selected chat channels

	local channels = string.gmatch(colorize_channels, "[^%s,]+")
	local allowed_channels = {}
	for channel in channels do
		allowed_channels[channel] = true
	end

	if next(allowed_channels) then
		beerchat.register_callback('before_send_on_channel', function(name, msg)
			if msg.channel and allowed_channels[msg.channel] then
				msg.message = msg.message:gsub('%((%#%x%x%x)%)', string.char(0x1B) .. '(c@%1)')
			end
		end)
	end

end
