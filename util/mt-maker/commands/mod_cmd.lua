local DS = package.config:sub(1,1)

--- @param filename string
--- @param content  string
--- @param mode     string file open mode. Default: `"w"`
local function create_file_with(filename, content, mode)
	mode = mode or "w"
	local file = io.open(filename, mode)
	file:write(content)
	file:close()
end

local function create_dirs(mod_name, app)
	app.lfs.mkdir(mod_name)
	app.lfs.mkdir(mod_name .. DS .. "locale")
	app.lfs.mkdir(mod_name .. DS .. "src")
	app.lfs.mkdir(mod_name .. DS .. "src" .. DS .. mod_name)
	app.lfs.mkdir(mod_name .. DS .. "textures")
end

local function create_files(mod_name)
	-- TODO: use templates

	create_file_with(mod_name .. DS .. "locale" .. DS .. mod_name .. ".en.tr", "# textdomain: " .. mod_name)
	create_file_with(mod_name .. DS .. "locale" .. DS .. mod_name .. ".ru.tr", "# textdomain: " .. mod_name)


	create_file_with(mod_name .. DS .. "init.lua",
	"local DS          = os.DIRECTORY_SEPARATOR\
	local mod_path    = minetest.get_modpath(minetest.get_current_modname())\
	local old_require = require\
	require           = function(name) return dofile(mod_path .. DS .. \"src\" .. DS .. name:gsub(\"%.\", DS) .. \".lua\") end\
	\
	\
	require(\"" .. mod_name .. "\").init()\
\
\
require = old_require\
")


	create_file_with(mod_name .. DS .. "src" .. DS .. mod_name..".lua",
	"local api    = require(\""..mod_name..".api\")\
local config = require(\""..mod_name..".config\")\
\
local function register_api()\
	_G."..mod_name.." = api\
end\
\
\
return {\
	init = function()\
		register_api()\
	end,\
}\
"
)
end


return {
	schema = "mod <mod_name>",
	--description = "Creates mod backbone.",
	--positional_args = { -- Set description or {description, default} for positional arguments
	--	mod_name = "Name of creating mod",
	--},
	action = function(parsed, command, app)
		create_dirs(parsed.mod_name, app)
		create_files(parsed.mod_name)

		app.theme.success("Backbone for MT Mod `" .. parsed.mod_name .. "` created")
	end,
}
