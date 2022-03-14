local SL = lord.require_intllib()

local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	if not areas:canInteract(pos, name) then
		return true
	end
	return old_is_protected(pos, name)
end

local function default_violation_message(pos, player_name, owners)
	minetest.chat_send_player(player_name,
		("%s "..SL("is protected by").." %s."):format(
		minetest.pos_to_string(pos),
		table.concat(owners, ", ")))
end

function areas:send_violation_message(pos, player_name, owners)
	for _,cb in ipairs(self.violation_cbs) do
		cb(pos, player_name, owners)
	end
end

minetest.register_on_protection_violation(function(pos, name)
	if not areas:canInteract(pos, name) then
		local owners = areas:getNodeOwners(pos)
		areas:send_violation_message(pos, name, owners)
	end
end)

areas:registerViolationHandler(default_violation_message)

