local function on_activate(self, staticdata)
    local data = minetest.deserialize(staticdata)
    if data ~= nil then
        -- это активация существующего моба
        self.object:set_armor_groups({immortal = 1,})
        self.ai = right_mobs_ai:init_from_serialized(data.ai, self)
        self.health = right_mobs_health:init_from_serialized(data.health, self)
    else
        -- создание нового моба
        self.object:set_armor_groups({immortal = 1,})
        self.ai = right_mobs_ai:init_new_mob(self.ai_name, self, self.parameters.ai)
        self.health = right_mobs_health:init_new_mob(self.health_name, self, self.parameters.health)
    end
    self.inited = true
end

local function get_staticdata(self)
    local data = {
        ai = right_mobs_ai:serialize(self.ai),
        health = right_mobs_health:serialize(self.health),
    }
    return minetest.serialize(data)
end

local function interact_mob(self, clicker)
end

local function punch_mob(self, hitter, tflp, tool_capabilities, dir)
    right_mobs_ai:punch(self.ai, hitter, {})
    local damage = right_mobs_api.calculate_damage(tool_capabilities, tflp)
    right_mobs_health:punch(self.health, hitter, damage)
end

local function mob_step(self, dtime)
    if self.inited then
        right_mobs_ai:process(self.ai, self.object:get_pos(), self.object:get_velocity(), dtime)
        right_mobs_health:process(self.health, self.object:get_pos(), self.object:get_velocity(), dtime)
    end
end

right_mobs_api.mob_death = function(health_context, self)
    right_mobs_api.drop_items(self.object:get_pos(), self.drops)
    self.object:remove()
end

right_mobs_api.register_mob = function(name, def)
    minetest.register_entity(name, {
        ai_name     = def.ai,
        health_name = def.health,

        max_health = def.max_health or 20,
        physical = true,
        drops = def.drops or {},

        collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
        visual = "mesh",
        mesh = def.mesh,
        textures = def.textures,

        on_rightclick = interact_mob,
        on_punch = punch_mob,
        on_step = mob_step,
    
        on_activate = on_activate,
        get_staticdata = get_staticdata,

        parameters = {
            ai = def.parameters.ai,
            health = def.parameters.health,
        },
    })

    minetest.register_craftitem(name.."_egg", {
        description = def.description.." egg",
        inventory_image = def.inventory_image or "npc_info_mob.png",
        groups = {not_in_creative_inventory = 1},
        stack_max = 99,

        on_place = function(itemstack, placer, pointed_thing)
            local player = placer:get_player_name()
            
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
                local entity     = minetest.add_entity(pos, name, data)
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
end
