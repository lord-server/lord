
---
--- @class Grinder
---
local Grinder =
{
    --- @type table<number,number,number>
    position = nil,
    --- @type NodeMetaRef
    meta = nil
}

--- Constructor
--- @public
--- @param pos table<number,number,number>
--- @return Grinder
function Grinder:new(pos)
    self.position = pos

    return self
end

-- -----------------------------------------------------------------------------------------------
-- Private functions:

--- @private
--- @param pos table<number,number,number>
--- @return NodeMetaRef
local function getInitiatedMeta(pos)
    local meta = minetest.get_meta(pos)
    for i, name in pairs({
        "fuel_totaltime",
        "fuel_time",
        "src_totaltime",
        "src_time"}) do
        -- init with 0.0 if var not set
        if not meta:get_float(name) then
            meta:set_float(name, 0.0)
        end
    end
    return meta
end

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- @public
--- @return NodeMetaRef
function Grinder:getMeta()
    return self.meta or getInitiatedMeta(self.position)
end



return Grinder
