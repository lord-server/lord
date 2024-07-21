local DS = package.config:sub(1,1)

local command_dir = debug.getinfo(1, 'S').source:gsub("@./", ""):gsub(".lua$", "")


--- @param filename string
--- @param variables table<string,string>
--- @return string compiled file content
local function tpl_compile(filename, variables)
	local file, err, msg = io.open(filename)
	if not file then print(err) print(msg) end
	--- @type string
	local content = file:read("*all")

	for name, value in pairs(variables) do
		content = content:gsub("%[%[" .. name .. "%]%]", value)
	end

	return content
end

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

	-- TODO: recursively walk through `templates`
	--local templates_dir = app.root_path .. command_dir .. DS .. "templates"
	--for filename in app.lfs.dir(templates_dir) do
	--	if filename ~= "." and filename ~= ".." then
	--		print(filename)
	--	end
	--end
end

local function create_files(mod_name, app)

	local templates_dir = app.root_path .. command_dir .. DS .. "templates"


	create_file_with(mod_name .. DS .. "locale" .. DS .. mod_name .. ".en.tr", "# textdomain: " .. mod_name)
	create_file_with(mod_name .. DS .. "locale" .. DS .. mod_name .. ".ru.tr", "# textdomain: " .. mod_name)

	create_file_with(mod_name .. DS .. "mod.conf", "name = " .. mod_name)

	create_file_with(
		mod_name .. DS .. "init.lua",
		tpl_compile(templates_dir .. DS .. "src" .. DS .. "[[mod_name]].lua", {
			mod_name = mod_name
		})
	)


	create_file_with(
		mod_name .. DS .. "src" .. DS .. mod_name..".lua",
		tpl_compile(templates_dir .. DS .. "src" .. DS .. "[[mod_name]].lua", {
			mod_name = mod_name
		})
	)
end


return {
	schema = "mod <mod_name>",
	description = "Creates mod backbone.",
	positional_args = { -- Set description or {description, default} for positional arguments
		mod_name = "Name of creating mod",
	},
	action = function(parsed, command, app)
		create_dirs(parsed.mod_name, app)
		create_files(parsed.mod_name, app)

		app.theme.success("Backbone for MT Mod `" .. parsed.mod_name .. "` created!")
	end,
}
