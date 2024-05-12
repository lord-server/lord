-- Used by `minetest.register_chatcommand`.
--- @class ChatCommandDefinition
local ChatCommandDefinition = {
	--- Short parameter description. Example: `"<name> <privilege>"`.
	--- Note that in params, use of symbols is as follows:
	--- * `<>` signifies a placeholder to be replaced when the command is used. For
	---   example, when a player name is needed: `<name>`
	--- * `[]` signifies param is optional and not required when the command is used.
	---   For example, if you require param1 but param2 is optional:
	---   `<param1> [<param2>]`
	--- * `|` signifies exclusive or. The command requires one param from the options
	---   provided. For example: `<param1> | <param2>`
	--- * `()` signifies grouping. For example, when param1 and param2 are both
	---   required, or only param3 is required: `(<param1> <param2>) | <param3>`
	--- @type string|nil
	params = nil,

	--- @type string|nil Full description. Example: `"Remove privilege from player"`.
	description = nil,

	--- @type table<string,boolean>|nil Require the "privs" privilege to run. Example: `{privs=true}`.
	privs = nil,

	--- Called when command is run. Returns boolean success and text output.
	--- Special case: The help message is shown to the player if `func`
	--- returns false without a text output.
	--- @type fun(name:string, param:string):boolean,string
	func = function(name, param) end,
}
