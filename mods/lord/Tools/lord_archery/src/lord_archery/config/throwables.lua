local S = minetest.get_translator("lord_archery")

return  {
    ["lord_archery:throwing_axe_steel"] = {
        definition = {
            description      = S("Steel Throwing Axe"),
            inventory_image  = "lord_archery_throwing_axe_steel", -- without ".png"
            groups           = { throwing_axe = 1, throwable = 1 },
            uses             = 180,
            sound_on_release = "lord_archery_arrow_release",
            draw_power = 0.75,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.25,
                [2] = 1.75,
            },
        },
        projectile_reg = {
            damage_tt   = 6,
            type        = "throwable",
            entity_name = "lord_archery:throwing_axe_steel",
            entity_reg  = {
                initial_properties = {
                    visual      = "item",
                    wield_item  = "lord_archery:throwing_axe_steel",
                    visual_size = { x = 0.25, y = 0.25, z = 0.25 },
                },
                max_speed            = 20,
                sound_hit_node       = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
                sound_hit_object     = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
                damage_groups        = { fleshy = 18 },
                remove_on_object_hit = false,
                remove_on_node_hit   = false,
                rotation_formula     = "axe"
            },
        },
    },
}
