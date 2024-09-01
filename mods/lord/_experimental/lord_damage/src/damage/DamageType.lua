local InstantBehavior  = require(lord_damage.damdge.DamageType.InstantBehavior)
local PeriodicBehavior = require(lord_damage.damdge.DamageType.PeriodicBehavior)

--- @class InstantBehaviorDef
--- @field target                Player|Entity
--- @field amount                number
--- @field armor_group_override  string
--- @field reason                DamageReason
--- @field on_start              function

--- @class PeriodicBehaviorDef
--- @field target    Player|Entity
--- @field damage    DamagePattern
--- @field reason    DamageReason
--- @field on_start  function
--- @field on_cycle  function
--- @field on_stop   function

--- @class DamageTypeDef
--- @field instant_behavior_def   InstantBehaviorDef
--- @field periodic_behavior_def  PeriodicBehaviorDef

--- @class lord_damage.DamageType
local DamageType = {
	--- @private
	--- @type table<string,any>
}

--- @param damage_type_def DamageTypeDef
--- @return base_classes.ObjectState
function DamageType:new(damage_type_def)
    local instant_def  = damage_type_def.instant_behavior_def
    local periodic_def = damage_type_def.periodic_behavior_def

    local private = {}

	private.instant_behavior = InstantBehavior:new()
    private.periodic_behavior = PeriodicBehavior:new()


    if instant_def then
        local pass
    end

    if periodic_def then
        local pass
    end

	local class = self

    function self:instant(target, amount, reason, on_start)

    end


    function self:periodic(target, amount, reason, on_start)

    end

	self = setmetatable({}, { __index = class })


	return self
end
