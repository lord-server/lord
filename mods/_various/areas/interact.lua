local SL = lord.require_intllib()

-- nodes to ignore
local ignorelist = {
	"fire:basic_flame",
}

local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	-- checking node in ignorelist
	for _, ignored_node in ipairs(ignorelist) do
		if minetest.get_node(pos).name == ignored_node then
			return old_is_protected(pos, name)
		end
	end

	if not areas:canInteract(pos, name) then
		return true
	end
	return old_is_protected(pos, name)
end

minetest.register_on_protection_violation(function(pos, name)
	if not areas:canInteract(pos, name) then
		local owners = areas:getNodeOwners(pos)
		minetest.chat_send_player(name,
			("%s "..SL("is protected by").." %s."):format(
				minetest.pos_to_string(pos),
				table.concat(owners, ", ")))
	end
end)
