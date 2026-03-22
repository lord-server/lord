---@meta

--- @class Lummander
--- @field title string
--- @field tag string
--- @field description string
--- @field version string
--- @field author string
--- @field root_path string
--- @field prevent_help boolean
--- @field devmode boolean
--- @field commands table
--- @field theme table
--- @field chalk table
--- @field lfs LummanderLfs
--- @field pcall table
--- @field log table
--- @field parsed table
local Lummander = {}

--- @class LummanderLfs
--- @field dir fun(dir:string):table<string,string>
--- @field attributes fun(filepath:string):table
--- @field mkdir fun(path:string)
--- @field currentdir fun():string
--- @field chdir fun(path:string)

--- @class ThemeColor
--- @field color fun(text:string):string

--- @class LummanderTheme
--- @field cli table
--- @field cli.title ThemeColor
--- @field cli.text ThemeColor
--- @field cli.category ThemeColor
--- @field command table
--- @field command.definition ThemeColor
--- @field command.description ThemeColor
--- @field command.argument ThemeColor
--- @field command.option ThemeColor
--- @field command.category ThemeColor
--- @field primary ThemeColor
--- @field secondary ThemeColor
--- @field success ThemeColor
--- @field warning ThemeColor
--- @field error ThemeColor

--- @class LummanderLog
--- @field info fun(text:string)
--- @field warn fun(text:string)
--- @field error fun(text:string)

--- Create a Lummander instance
--- @param setup table
--- @param setup.title? string Title message for your CLI
--- @param setup.tag? string CLI Command to execute your program
--- @param setup.description? string CLI description
--- @param setup.version? string CLI version
--- @param setup.author? string CLI author
--- @param setup.root_path? string Root path
--- @param setup.prevent_help? boolean Prevent help message if not command found
--- @param setup.devmode? boolean Development mode
--- @param setup.theme? table|string Theme to apply
--- @return Lummander
function Lummander.new(setup) end

--- Set a default action to execute if any command if found
--- @param command function|Command Default action
--- @param params table? Default params passed to Default action function
--- @return Lummander
function Lummander:action(command, params) end

--- Apply a theme
--- @param theme table|string? Theme to apply
--- @return Lummander
function Lummander:apply_theme(theme) end

--- Create a new command
--- @param command string|table Parse that string to extract arguments names and their requirement
--- @param description? string|table Command description or table as config
--- @param config? table Options
--- @return Command
function Lummander:command(command, description, config) end

--- Load command of a directory
--- @param folderpath string Relative path to load commands (.lua files)
--- @return Lummander
function Lummander:commands_dir(folderpath) end

--- Execute command on shell
--- @param command string Shell command to execute
--- @param fn? function Callback to execute when the shell command finished
--- @return string?
function Lummander:execute(command, fn) end

--- Search a command by name
--- @param cmd_name string|table Command name to search
--- @return Command|nil
function Lummander:find_cmd(cmd_name) end

--- Print Help message
--- @param ignore_flag? boolean ignore_flag Ignore Lummander prevent_help to show help message
function Lummander:help(ignore_flag) end

--- Parse message
--- @param message table|string Message splited by spaces and ""
--- @return table
function Lummander:parse(message) end

--- Run main action
--- @return Lummander
function Lummander:run() end

--- Error logging
--- @param err string
function Lummander:error(err) end

--- Development logging
--- @vararg any
function Lummander:dev(...) end

return Lummander
