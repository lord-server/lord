fractions = {}
fractions.fractions = {}


function fractions:register_fraction(name, desc)
	self.fractions[name] = {}
	self.fractions[name].hostiles = {}
	self.fractions[name].friends = {}
	if desc.hostiles ~= nil then
		for i, hostile in ipairs(desc.hostiles) do
			self.fractions[name].hostiles[i] = hostile
		end
	end
	if desc.friends ~= nil then
		for i, friend in ipairs(desc.friends) do
			self.fractions[name].friends[i] = friend
		end
	end
end

function fractions:is_hostile(target, fraction)
	if self.fractions[fraction] == nil then
		return false
	end
	for _, hostile in ipairs(self.fractions[fraction].hostiles) do
		if hostile == target then
			return true
		end
	end
	return false
end

function fractions:is_friend(target, fraction)
	if self.fractions[fraction] == nil then
		return false
	end
	for _, friend in ipairs(self.fractions[fraction].friends) do
		if friend == target then
			return true
		end
	end
	return false
end

dofile(minetest.get_modpath("fractions").."/fractions.lua")

