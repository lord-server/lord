local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

-- Original code by Traxie21 and released with the WTFPL license
-- https://forum.minetest.net/viewtopic.php?id=4457

-- Updates by Zeno and ChaosWormz

local timeout_delay = 60

-- Set to true to register tpr_admin priv
local regnewpriv = false

local version = "1.1"

local tpr_list = {}
local tphr_list = {}

--Teleport Request System
local function tpr_send(sender, receiver)
	if receiver == "" then
		minetest.chat_send_player(sender, SL("Usage: /tpr <Player name>"))
		return
	end

	--If paremeter is valid, Send teleport message and set the table.
	if not minetest.get_player_by_name(receiver) then
		return
	end

	minetest.chat_send_player(receiver, sender ..' '..SL('is requesting to teleport to you. /tpy to accept.'))
	minetest.chat_send_player(sender, SL('Teleport request sent! It will time out in')..' '.. timeout_delay ..' '..SL('seconds.'))

	--Write name values to list and clear old values.
	tpr_list[receiver] = sender
	--Teleport timeout delay
	minetest.after(timeout_delay, function(name)
		if tpr_list[name] then
			tpr_list[name] = nil
		end
	end, sender)
end

local function tphr_send(sender, receiver)
	if receiver == "" then
		minetest.chat_send_player(sender, SL("Usage: /tphr <Player name>"))
		return
	end

	--If paremeter is valid, Send teleport message and set the table.
	if not minetest.get_player_by_name(receiver) then
		return
	end

	minetest.chat_send_player(receiver, sender ..' '..SL('is requesting that you teleport to them. /tpy to accept; /tpn to deny'))
	minetest.chat_send_player(sender, SL('Teleport request sent! It will time out in')..' '.. timeout_delay ..' '..SL('seconds.'))

	--Write name values to list and clear old values.
	tphr_list[receiver] = sender
	--Teleport timeout delay
	minetest.after(timeout_delay, function(name)
		if tphr_list[name] then
			tphr_list[name] = nil
		end
	end, sender)
end

local function tpr_deny(name)
	if tpr_list[name] then
		minetest.chat_send_player(tpr_list[name], SL('Teleport request denied.'))
		tpr_list[name] = nil
	end
	if tphr_list[name] then
		minetest.chat_send_player(tphr_list[name], SL('Teleport request denied.'))
		tphr_list[name] = nil
	end
end

-- Copied from Celeron-55's /teleport command. Thanks Celeron!
local function find_free_position_near(pos)
	local tries = {
		{x=1,y=0,z=0},
		{x=-1,y=0,z=0},
		{x=0,y=0,z=1},
		{x=0,y=0,z=-1},
	}
	for _,d in pairs(tries) do
		local p = vector.add(pos, d)
		if not minetest.registered_nodes[minetest.get_node(p).name].walkable then
			return p, true
		end
	end
	return pos, false
end


--Teleport Accept Systems
local function tpr_accept(name, param)

	--Check to prevent constant teleporting.
	if not tpr_list[name]
	and not tphr_list[name] then
		minetest.chat_send_player(name, SL("Usage: /tpy allows you to accept teleport requests sent to you by other players"))
		return
	end

	local chatmsg, source, target, name2

	if tpr_list[name] then
		name2 = tpr_list[name]
		source = minetest.get_player_by_name(name)
		target = minetest.get_player_by_name(name2)
		chatmsg = name2 .. " "..SL("is teleporting to you.")
		tpr_list[name] = nil
	elseif tphr_list[name] then
		name2 = tphr_list[name]
		source = minetest.get_player_by_name(name2)
		target = minetest.get_player_by_name(name)
		chatmsg = SL("You are teleporting to").." " .. name2 .. "."
		tphr_list[name] = nil
	else
		return
	end

	-- Could happen if either player disconnects (or timeout); if so just abort
	if not source
	or not target then
		return
	end

	minetest.chat_send_player(name2, SL("Request Accepted!"))
	minetest.chat_send_player(name, chatmsg)

	target:setpos(find_free_position_near(source:getpos()))
end

--Initalize Permissions.

if regnewpriv then
	minetest.register_privilege("tpr_admin", {
		description = SL("Permission to override teleport to other players. UNFINISHED"),
		give_to_singleplayer = true
	})
end

--Initalize Commands.

minetest.register_chatcommand("tpr", {
	description = SL("Request teleport to another player"),
	params = "<playername> | leave playername empty to see help message",
	privs = {interact=true},
	func = tpr_send
})

minetest.register_chatcommand("tphr", {
	description = SL("Request player to teleport to you"),
	params = "<playername> | leave playername empty to see help message",
	privs = {interact=true},
	func = tphr_send
})

minetest.register_chatcommand("tpy", {
	description = SL("Accept teleport requests from another player"),
	func = tpr_accept
})

minetest.register_chatcommand("tpn", {
	description = SL("Deny teleport requests from another player"),
	func = tpr_deny
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
