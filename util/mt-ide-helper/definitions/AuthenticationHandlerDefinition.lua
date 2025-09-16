--- @diagnostic disable: missing-return


---@class AuthenticationHandlerGetAuth
---@field password string
---@field privileges table<string,number>
---@field last_login number|nil

-- Used by `minetest.register_authentication_handler`.
---@class AuthenticationHandlerDefinition
local AuthenticationHandlerDefinition = {
	--- Get authentication data for existing player `name` (`nil` if player
    --- doesn't exist).
    --- Returns following structure:
    --- `{password=<string>, privileges=<table>, last_login=<number or nil>}`
	---@type fun(name:string):AuthenticationHandlerGetAuth|nil
    get_auth = function(name) end,

	--- Create new auth data for player `name`.
    --- Note that `password` is not plain-text but an arbitrary
    --- representation decided by the engine.
	---@type fun(name:string, password:string)
    create_auth = function(name, password) end,

	--- Delete auth data of player `name`.
    --- Returns boolean indicating success (false if player is nonexistent).
	---@type fun(name:string)
    delete_auth = function(name) end,

	--- Set password of player `name` to `password`.
    --- Auth data should be created if not present.
	---@type fun(name:string, password:string)
    set_password = function(name, password) end,

    --- Set privileges of player `name`.
    --- `privileges` is in table form, auth data should be created if not
    --- present.
	---@type fun(name:string, priveleges:table<string,number>)
    set_privileges = function(name, privileges) end,

    --- Reload authentication data from the storage location.
    --- Returns boolean indicating success.
	---@type fun():boolean
    reload = function() end,

    --- Called when player joins, used for keeping track of last_login
	---@type fun(name:string)
    record_login = function(name) end,

    --- Returns an iterator (use with `for` loops) for all player names
    --- currently in the auth database
	---@type fun():fun()
    iterate = function() end,
}
