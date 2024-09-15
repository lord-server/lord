local DS = package.config:sub(1,1)

local command_dir = debug.getinfo(1, 'S').source:gsub("@./", ""):gsub(".lua$", "")


--- @param find    string
--- @param replace string
--- @return string
function string:replace(find, replace)
	local start_pos, end_pos = self:find(find, 1, true)
	if not start_pos then return self end

	return self:sub(1, start_pos-1) .. replace .. self:sub(end_pos+1)
end

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

--- @param dir string
--- @param app Lummander
--- @param callback fun(is_dir:boolean,filename:string,filepath:string)
local function scan_directory(dir, app, callback)
	for filename, file in app.lfs.dir(dir) do
		if filename ~= "." and filename ~= ".." then
			local filepath = dir .. DS .. filename
			local file_type = app.lfs.attributes(filepath).mode
			if file_type == "directory" then
				callback(true, filename, filepath)
				scan_directory(filepath, app, callback)
			else
				callback(false, filename, filepath)
			end
		end
	end
end

local function create_dirs_and_files(mod_name, app)
	app.lfs.mkdir(mod_name)

	local templates_dir = app.root_path .. command_dir .. DS .. "templates"
	scan_directory(templates_dir, app, function(is_dir, tpl_filename, tpl_filepath)
		local filename = tpl_filepath:replace(templates_dir, mod_name)
		filename       = filename:replace('[[mod_name]]', mod_name)
		if is_dir then
			app.lfs.mkdir(filename)
		else
			create_file_with(filename, tpl_compile(tpl_filepath, {
				mod_name = mod_name
			}))
		end
	end)
end


return {
	schema = "mod <mod_name>",
	description = "Creates mod backbone.",
	positional_args = { -- Set description or {description, default} for positional arguments
		mod_name = "Name of creating mod",
	},
	action = function(parsed, command, app)
		create_dirs_and_files(parsed.mod_name, app)

		app.theme.success("Backbone for MT Mod `" .. parsed.mod_name .. "` created!")
	end,
}
