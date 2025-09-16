--- @diagnostic disable: missing-return

--- Used by `core.register_privilege`.
--- @class PrivilegeDefinition
local PrivilegeDefinition = {
	--- @type string? Privilege description
	description = "",

	--- @type boolean? Whether to grant the privilege to singleplayer.
	give_to_singleplayer = true,

	--- Whether to grant the privilege to the server admin.
	--- Uses value of 'give_to_singleplayer' by default.
	--- @type boolean?
	give_to_admin = true,

	--- Called when given to player 'name' by 'granter_name'.
	--- 'granter_name' will be nil if the priv was granted by a mod.
	---
	--- Note that it will be called twice if a player is responsible,
	--- once with the player name, and then with a nil player name.
	---
	--- Return `true` to stop register_on_priv_grant or revoke being called.
	---
	--- @param name string for whom priv was granted
	--- @param granter_name string who gives the priv
	--- @return boolean
	--- @type nil|fun(name:string, granter_name:string):boolean
	on_grant = function(name, granter_name) end,

	--- Called when taken from player 'name' by 'revoker_name'.
	--- 'revoker_name' will be nil if the priv was revoked by a mod.
	---
	--- Note that it will be called twice if a player is responsible,
	--- once with the player name, and then with a nil player name.
	---
	--- Return `true` to stop register_on_priv_grant or revoke being called.
	---
	--- @param name string for whom priv was granted
	--- @param revoker_name string who gives the priv
	--- @return boolean
	--- @type nil|fun(name:string, revoker_name:string):boolean
	on_revoke = function(name, revoker_name) end,
}
