

--- @class sunshine.Config.Default
local Default = {
    shadows = {
        intensity = 0.5,
    },
    bloom = {
        intensity = 0.05,
        strength_factor = 1,
        radius = 1,
    },
    -- aka "god rays"
    volumetric_light = {
        strength = 0.2,
    },
}

return Default
