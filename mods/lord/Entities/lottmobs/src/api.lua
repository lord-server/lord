--- @class lottmobs.Api
local Api = {
    fear_height = {}
}
function Api.fear_height.state_check(self)
    local target = (self.state == "attack") and 10 or 3
    if self.fear_height ~= target then
        self.fear_height = target
    end
end

return Api
