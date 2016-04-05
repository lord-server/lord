local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end


local function redefinition(chatcommand, new_description)
	if minetest.chatcommands[chatcommand] then
		if new_description then
			minetest.chatcommands[chatcommand].description = SL(new_description)
		else
			minetest.chatcommands[chatcommand].description = SL(minetest.chatcommands[chatcommand].description)
		end
	end
end

redefinition("me")
redefinition("help")
redefinition("privs")
redefinition("grant")
redefinition("revoke")
redefinition("setpassword")
redefinition("clearpassword")
redefinition("auth_reload")
redefinition("teleport")
redefinition("set")
redefinition("emergeblocks")
redefinition("deleteblocks")
redefinition("mods")
redefinition("give")
redefinition("giveme")
redefinition("spawnentity")
redefinition("pulverize")
redefinition("rollback_check", "Check who has last touched a node or near it, max <seconds> ago")
redefinition("rollback")
redefinition("status")
redefinition("time")
redefinition("shutdown")
redefinition("ban")
redefinition("unban")
redefinition("kick")
redefinition("clearobjects")
redefinition("msg")
redefinition("last-login")

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
