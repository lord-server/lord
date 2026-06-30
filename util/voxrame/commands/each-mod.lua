
--- @class lfs
local lfs = require('lfs')


local cwd = lfs.currentdir()
lfs.chdir('../../')

require('mods.Voxrame.helpers.src.lua_ext.io')
require('mods.Voxrame.helpers.src.lua_ext.table')
require('mods.Voxrame.helpers.src.lua_ext.string')
require('mods.Voxrame.helpers.src.term')


local function forech_dir(path, callback)
	path = path:gsub('/+$', '')
	for name in lfs.dir(path) do
		if name ~= "." and name ~= ".." then
			local file_path = path .. '/' .. name
			if lfs.attributes(file_path, 'mode') == 'directory' then
				callback(file_path)
				forech_dir(file_path, callback)
			end
		end
	end
end

local function foreach_mod(callback)
	forech_dir('mods/', function(path)
		if io.file_exists(path .. '/mod.conf') then
			callback(path)
		end
	end)
end


local function print_mods()
	foreach_mod(function(name)
		print(name)
	end)
end


return {
	schema = "each-mod <subcommand>",
	description = 'For each mod do <subcommand>.',
	positional_args = {
		subcommand = 'Command to execute for each mod\n' ..
		'  ' .. term.stylize("Supported subcommands:\n", term.style.bold) ..
		'    ' .. term.stylize("print", term.style.green) .. ' - Print all mod names',
	},
	action = function(parsed, command, app)
		if parsed.subcommand == 'print' then
			print_mods()
		else
			print("Unknown subcommand: " .. parsed.subcommand)
		end
	end,
}
