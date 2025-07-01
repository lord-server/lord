
term = {}

--- ANSI escape codes of terminal styles.
term.style = {
	-- Reset
	reset               = '\27[0m',
	-- Basic colors
	black               = '\27[30m',
	red                 = '\27[31m',
	green               = '\27[32m',
	yellow              = '\27[33m',
	blue                = '\27[34m',
	magenta             = '\27[35m',
	cyan                = '\27[36m',
	white               = '\27[37m',
	-- Bright colors
	bright_black        = '\27[90m',
	bright_red          = '\27[91m',
	bright_green        = '\27[92m',
	bright_yellow       = '\27[93m',
	bright_blue         = '\27[94m',
	bright_magenta      = '\27[95m',
	bright_cyan         = '\27[96m',
	bright_white        = '\27[97m',
	-- Background colors
	bg_black            = '\27[40m',
	bg_red              = '\27[41m',
	bg_green            = '\27[42m',
	bg_yellow           = '\27[43m',
	bg_blue             = '\27[44m',
	bg_magenta          = '\27[45m',
	bg_cyan             = '\27[46m',
	bg_white            = '\27[47m',
	-- Bright background colors
	bg_bright_black     = '\27[100m',
	bg_bright_red       = '\27[101m',
	bg_bright_green     = '\27[102m',
	bg_bright_yellow    = '\27[103m',
	bg_bright_blue      = '\27[104m',
	bg_bright_magenta   = '\27[105m',
	bg_bright_cyan      = '\27[106m',
	bg_bright_white     = '\27[107m',
	-- Text styles
	bold                = '\27[1m',
	dim                 = '\27[2m',
	italic              = '\27[3m',
	underline           = '\27[4m',
	blink               = '\27[5m',
	reverse             = '\27[7m', -- Reverse video (swap foreground and background)
	hidden              = '\27[8m', -- Hidden text
	strikethrough       = '\27[9m',
	-- Reset specific attributes
	reset_bold          = '\27[22m',
	reset_dim           = '\27[22m',
	reset_italic        = '\27[23m',
	reset_underline     = '\27[24m',
	reset_blink         = '\27[25m',
	reset_reverse       = '\27[27m',
	reset_hidden        = '\27[28m',
	reset_strikethrough = '\27[29m'
}

--- @type boolean
term.supports_ansi = (function()
	-- Unix-like
	if os.getenv('TERM') and os.getenv('TERM') ~= 'dumb' then
		return true
	end
	-- Windows 10+ (PowerShell, Terminal, ConEmu)
	if os.getenv('ANSICON') or os.getenv('WT_SESSION') then
		return true
	end
	-- Additional check via Windows Registry
	if os.getenv('OS') == 'Windows_NT' then
		local handle = io.popen('reg query HKCU\\Console /v VirtualTerminalLevel 2>nul')
		local result = handle:read('*a')
		handle:close()
		return result:find('0x1') ~= nil
	end

	return false
end) ()


--- @overload fun(text:string)
--- @param text  string
--- @param style string Color or style ANSI-code. (one of `term.style`). You can concatenate several styles.
--- @return string
function term.stylize(text, style, reset)
	reset = reset or term.style.reset

	return (term.supports_ansi and style)
		and (style .. text .. reset)
		or  text
end

--- @overload fun(text:string)
--- @param text  string
--- @param style string Color or style ANSI-code. (one of `term.style`). You can concatenate several styles.
function term.print(text, style)
	print(term.stylize(text, style))
end

--- @param text string
--- @param url
--- @return string
function term.link(text, url)
	return '\27]8;;' .. url .. '\27\\' .. text .. '\27]8;;\27\\'
end
