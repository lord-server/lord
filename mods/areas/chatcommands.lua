local SL = lord.require_intllib()

minetest.register_chatcommand("protect", {
	params = "<AreaName>",
	description = SL("Protect your own area"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		if param == "" then
			return false, SL("Invalid usage, see").." /help protect."
		end
		local pos1, pos2 = areas:getPos(name)
		if not (pos1 and pos2) then
			return false, SL("You need to select an area first.")
		end

		minetest.log("action", "/protect invoked, owner="..name..
				" AreaName="..param..
				" StartPos="..minetest.pos_to_string(pos1)..
				" EndPos="  ..minetest.pos_to_string(pos2))

		local canAdd, errMsg = areas:canPlayerAddArea(pos1, pos2, name)
		if not canAdd then
			return false, SL("You can't protect that area")..": "..errMsg
		end

		local id = areas:add(name, param, pos1, pos2, nil)
		areas:save()

		return true, SL("Area protected.").." ID: "..id
	end
})

minetest.register_chatcommand("set_owner", {
	params = "<PlayerName> <AreaName>",
	description = SL("Protect an area beetween two positions and give"
		.." a player access to it without setting the parent of the"
		.." area to any existing area"),
	privs = areas.adminPrivs,
	func = function(name, param)
		local ownerName, areaName = param:match('^(%S+)%s(.+)$')

		if not ownerName then
			return false, SL("Incorrect usage, see").." /help set_owner."
		end

		local pos1, pos2 = areas:getPos(name)
		if not (pos1 and pos2) then
			return false, SL("You need to select an area first.")
		end

		if not areas:player_exists(ownerName) then
			return false, SL("The player").." \""..ownerName.."\" "..SL("does not exist.")
		end

		minetest.log("action", name.." runs /set_owner. Owner = "..ownerName..
				" AreaName = "..areaName..
				" StartPos = "..minetest.pos_to_string(pos1)..
				" EndPos = "  ..minetest.pos_to_string(pos2))

		local id = areas:add(ownerName, areaName, pos1, pos2, nil)
		areas:save()

		minetest.chat_send_player(ownerName, SL("You have been granted control over area #")..id..SL(". Type /list_areas to show your areas."))
		return true, SL("Area protected.").." ID: "..id
	end
})

minetest.register_chatcommand("add_owner", {
	params = "<ParentID> <Player> <AreaName>",
	description = SL("Give a player access to a sub-area beetween two"
		.." positions that have already been protected,"
		.." Use set_owner if you don't want the parent to be set."),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local pid, ownerName, areaName
				= param:match('^(%d+) ([^ ]+) (.+)$')

		if not pid then
			minetest.chat_send_player(name, SL("Incorrect usage, see").." /help add_owner")
			return
		end

		local pos1, pos2 = areas:getPos(name)
		if not (pos1 and pos2) then
			return false, SL("You need to select an area first.")
		end

		if not areas:player_exists(ownerName) then
			return false, SL("The player").." \""..ownerName.."\" "..SL("does not exist.")
		end

		minetest.log("action", name.." runs /add_owner. Owner = "..ownerName..
				" AreaName = "..areaName.." ParentID = "..pid..
				" StartPos = "..pos1.x..","..pos1.y..","..pos1.z..
				" EndPos = "  ..pos2.x..","..pos2.y..","..pos2.z)

		-- Check if this new area is inside an area owned by the player
		pid = tonumber(pid)
		if (not areas:isAreaOwner(pid, name)) or
		   (not areas:isSubarea(pos1, pos2, pid)) then
			return false, SL("You can't protect that area")
		end

		local id = areas:add(ownerName, areaName, pos1, pos2, pid)
		areas:save()

		minetest.chat_send_player(ownerName, SL("You have been granted control over area #")..id..SL(". Type /list_areas to show your areas."))
		return true, SL("Area protected.").." ID: "..id
	end
})

minetest.register_chatcommand("rename_area", {
	params = "<ID> <newName>",
	description = SL("Rename a area that you own"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local id, newName = param:match("^(%d+)%s(.+)$")
		if not id then
			return false, SL("Invalid usage, see").." /help rename_area."
		end

		id = tonumber(id)
		if not id then
			return false, SL("That area doesn't exist.")
		end

		if not areas:isAreaOwner(id, name) then
			return true, SL("You don't own that area.")
		end

		areas.areas[id].name = newName
		areas:save()
		return true, SL("Area renamed.")
	end
})

minetest.register_chatcommand("find_areas", {
	params = "<regexp>",
	privs = areas.adminPrivs,
	description = SL("Find areas using a Lua regular expression"),
	func = function(name, param)
		if param == "" then
			return false, SL("A regular expression is required.")
		end

		-- Check expression for validity
		local function testRegExp()
			("Test [1]: Player (0,0,0) (0,0,0)"):find(param)
		end
		if not pcall(testRegExp) then
			return false, SL("Invalid regular expression.")
		end

		local matches = {}
		for id, area in pairs(areas.areas) do
			local str = areas:toString(id)
			if str:find(param) then
				table.insert(matches, str)
			end
		end
		if #matches > 0 then
			return true, table.concat(matches, "\n")
		else
			return true, SL("No matches found.")
		end
	end
})

minetest.register_chatcommand("list_areas", {
	description = SL("List your areas, or all areas if you are an admin"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local admin = minetest.check_player_privs(name, areas.adminPrivs)
		local areaStrings = {}
		for id, area in pairs(areas.areas) do
			if admin or areas:isAreaOwner(id, name) then
				table.insert(areaStrings, areas:toString(id))
			end
		end
		if #areaStrings == 0 then
			return true, SL("No visible areas.")
		end
		return true, table.concat(areaStrings, "\n")
	end
})

minetest.register_chatcommand("recursive_remove_areas", {
	params = "<id>",
	description = SL("Recursively remove areas using an id"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local id = tonumber(param)
		if not id then
			return false, SL("Invalid usage, see").." /help recursive_remove_areas"
		end

		if not areas:isAreaOwner(id, name) then
			return false, SL("Area").." "..id.." "..SL("does not exist or is not owned by you.")
		end

		areas:remove(id, true)
		areas:save()
		return true, SL("Removed area").." "..id.." "..SL("and it's sub areas.")
	end
})

minetest.register_chatcommand("remove_area", {
	params = "<id>",
	description = SL("Remove an area using an id"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local id = tonumber(param)
		if not id then
			return false, SL("Invalid usage, see").." /help remove_area"
		end

		if not areas:isAreaOwner(id, name) then
			return false, SL("Area").." "..id.." "..SL("does not exist or is not owned by you.")
		end

		areas:remove(id)
		areas:save()
		return true, SL("Removed area").." "..id
	end
})

minetest.register_chatcommand("change_owner", {
	params = "<ID> <NewOwner>",
	description = SL("Change the owner of an area using it's ID"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local id, newOwner = param:match("^(%d+)%s(%S+)$")
		if not id then
			return false, SL("Invalid usage, see").." /help change_owner."
		end

		if not areas:player_exists(newOwner) then
			return false, SL("The player").." \""..newOwner.."\" "..SL("does not exist.")
		end

		id = tonumber(id)
		if not areas:isAreaOwner(id, name) then
			return false, SL("Area").." "..id.." "..SL("does not exist or is not owned by you.")
		end
		areas.areas[id].owner = newOwner
		areas:save()
		minetest.chat_send_player(newOwner,
			("%s "..SL("has given you control over the area").." %q (ID %d).")
				:format(name, areas.areas[id].name, id))
		return true, SL("Owner changed.")
	end
})

minetest.register_chatcommand("area_open", {
	params = "<ID>",
	description = SL("Toggle an area open (anyone can interact) or closed"),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local id = tonumber(param)
		if not id then
			return false, SL("Invalid usage, see").." /help area_open."
		end

		if not areas:isAreaOwner(id, name) then
			return false, SL("Area").." "..id.." "..SL("does not exist or is not owned by you.")
		end
		local open = not areas.areas[id].open
		-- Save false as nil to avoid inflating the DB.
		areas.areas[id].open = open or nil
		areas:save()
		return true, (SL("Area").." %s."):format(open and SL("opened") or SL("closed"))
	end
})

minetest.register_chatcommand("move_area", {
	params = "<ID>",
	description = SL("Move (or resize) an area to the current positions."),
	privs = areas.adminPrivs,
	func = function(name, param)
		local id = tonumber(param)
		if not id then
			return false, SL("Invalid usage, see").." /help move_area."
		end

		local area = areas.areas[id]
		if not area then
			return false, SL("That area doesn't exist.")
		end

		local pos1, pos2 = areas:getPos(name)
		if not pos1 then
			return false, SL("You need to select an area first.")
		end

		area.pos1 = pos1
		area.pos2 = pos2
		areas:save()
		return true, SL("Area successfully moved.")
	end,
})

minetest.register_chatcommand("area_info", {
	description = SL("Get information about area configuration and usage."),
	privs = {[areas.config.self_protection_privilege]=true},
	func = function(name, param)
		local lines = {}
		local privs = minetest.get_player_privs(name)

		-- Short (and fast to access) names
		local cfg = areas.config
		local self_prot  = cfg.self_protection
		local prot_priv  = cfg.self_protection_privilege
		local limit      = cfg.self_protection_max_areas
		local limit_high = cfg.self_protection_max_areas_high
		local size_limit = cfg.self_protection_max_size
		local size_limit_high = cfg.self_protection_max_size_high

		local has_high_limit = privs.areas_high_limit
		local has_prot_priv = not prot_priv or privs[prot_priv]
		local can_prot = privs.areas or (self_prot and has_prot_priv)
		local max_count = can_prot and
			(has_high_limit and limit_high or limit) or 0
		local max_size = has_high_limit and
			size_limit_high or size_limit

		-- Privilege information
		local self_prot_line = SL(("Self protection is %sabled"):format(
				self_prot and "en" or "dis"))
		if self_prot and prot_priv then
			self_prot_line = self_prot_line..
				(", %s "..SL("have the neccessary privilege").." (%q).")
				:format(
					has_prot_priv and SL("and you") or
						SL("but you don't"),
					prot_priv)
		else
			self_prot_line = self_prot_line.."."
		end
		table.insert(lines, self_prot_line)
		if privs.areas then
			table.insert(lines, SL("You are an area administrator").." (\"areas\" "..SL("privilege)."))
		elseif has_high_limit then
			table.insert(lines, SL("You have extended area protection limits").." (\"areas_high_limit\" "..SL("privilege)."))
		end

		-- Area count
		local area_num = 0
		for id, area in pairs(areas.areas) do
			if area.owner == name then
				area_num = area_num + 1
			end
		end
		local count_line = SL("Number of your areas:").." "..tostring(area_num)
		if privs.areas then
			count_line = count_line.."; "..SL("you have no area protection limits.")
		elseif can_prot then
			count_line = count_line.."; "..SL("the maximum number").." - "..tostring(max_count).."."
		end
		table.insert(lines, count_line)

		-- Area size limits
		local function size_info(str, size)
			table.insert(lines, ("%s "..SL("spanning up to").." %dx%dx%d."):format(str, size.x, size.y, size.z))
		end
		local function priv_limit_info(priv, max_count, max_size)
			size_info((SL("Players with the").." %q "..SL("privilege")..
				" "..SL("can protect up to").." %d "..SL("areas")):format(priv, max_count), max_size)
		end
		if self_prot then
			if privs.areas then
				priv_limit_info(prot_priv, limit, size_limit)
				priv_limit_info("areas_high_limit", limit_high, size_limit_high)
			elseif has_prot_priv then
				size_info(SL("You can protect areas"), max_size)
			end
		end

		return true, table.concat(lines, "\n")
	end,
})
