factions = {}
factions.factions = {}


function factions:register_faction(name, desc)
	self.factions[name] = {}
	self.factions[name].hostiles = {}
	self.factions[name].friends = {}
	if desc.hostiles ~= nil then
		for i, hostile in ipairs(desc.hostiles) do
			self.factions[name].hostiles[i] = hostile
		end
	end
	if desc.friends ~= nil then
		for i, friend in ipairs(desc.friends) do
			self.factions[name].friends[i] = friend
		end
	end
end

function factions:is_hostile(target, faction)
	if self.factions[faction] == nil then
		return false
	end
	for _, hostile in ipairs(self.factions[faction].hostiles) do
		if hostile == target then
			return true
		end
	end
	return false
end

function factions:is_friend(target, faction)
	if self.factions[faction] == nil then
		return false
	end
	for _, friend in ipairs(self.factions[faction].friends) do
		if friend == target then
			return true
		end
	end
	return false
end

dofile(minetest.get_modpath("factions").."/factions.lua")

