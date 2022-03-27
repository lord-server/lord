local function on_activate(self, staticdata)
    local data = minetest.deserialize(staticdata)
	if data ~= nil then
        -- это активация существующего моба
        self.ai = right_mobs_ai:init_from_serialized(data.ai, self)
        self.health = right_mobs_health:init_from_serialized(data.health, self)
    else
        -- создание нового моба
        self.ai = right_mobs_ai:init_new_mob(self.ai_name, self)
        self.health = right_mobs_health:init_new_mob(self.health_name, self.max_health, self)
    end
end

local function get_staticdata(self)
    local data = {
        ai = right_mobs_ai:serialize(self.ai),
        health = right_mobs_health:serialize(self.health),
    }
    return minetest.serialize(data)
end

local function interact_simplemob(self, clicker)
end

local function punch_simplemob(self, clicker)
    right_mobs_ai:punch(self.ai, clicker, {})
    right_mobs_health:punch(self.health, clicker, 1)
end

local function simplemob_die(health_context, self)
    right_mob_api.drop_items(self.object:get_pos(), self.drops)
    self.object:remove()
end

right_mobs_ai:register_mob("simple_ai", {
    attack = nil,
    walk = nil,
    stay = nil,
    aggression = nil,
})

right_mobs_health:register_mob("simple_health", {
    on_die = simplemob_die,
})

minetest.register_entity("right_mobs:simplemob", {
    ai_name     = "simple_ai",
    health_name = "simple_health",

    max_health = 10,
    physical = true,
    drops = { name = "tools:spear_silver", chance = 1, min = 1, max = 1, },


    collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
    visual = "mesh",
    mesh = "human_model.x",

    texture = definition.texture or "lottmobs_rohan_guard_2.png",

    on_rightclick = interact_simplemob,
    on_punch = punch_simplemob,
    
    on_activate = on_activate,
    get_staticdata = get_staticdata,
})

minetest.register_craftitem("right_mobs:simplemob_egg", {
    description = "right_mobs:simplemob egg",
    inventory_image = "npc_info_mob.png",
    groups = {not_in_creative_inventory = 1},
    stack_max = 1,

    on_place = function(itemstack, placer, pointed_thing)
        local player = placer:get_player_name()
        local can_edit = minetest.get_player_privs(player)[npc.required_priv]
        if not can_edit then
            return
        end

        local pos = pointed_thing.above

        -- am I clicking on something with existing on_rightclick function?
        local under = minetest.get_node(pointed_thing.under)
        local def = minetest.registered_nodes[under.name]
        if def and def.on_rightclick then
            return def.on_rightclick(pointed_thing.under, under, placer, itemstack)
        end

        if pos
        and within_limits(pos, 0)
        and not minetest.is_protected(pos, player) then
            pos.y            = pos.y + 0.5

            local data       = itemstack:get_metadata()
            local entity     = minetest.add_entity(pos, "right_mobs:simplemob", data)
            local lua_entity = entity:get_luaentity()

            if not lua_entity then
                entity:remove()
                return
            end

            -- since mob is unique we remove egg once spawned even in creative mod
            itemstack:take_item()
        end

        return itemstack
    end,
})
