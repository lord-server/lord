
--- @class lottmobs.Api
local Api = {

}

function Api.set_fear_height_by_state(self)
	local target = (self.state == "attack") and 10 or 3
	if self.fear_height == target then
		return
	end
	self.fear_height = target
end

return Api
