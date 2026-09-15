
-- We have typed damage.
-- The type of damage is determined by node `damage_groups`

core.override_item('fire:basic_flame',     { damage_groups = { fire = true, }, })
core.override_item('fire:permanent_flame', { damage_groups = { fire = true, }, })
