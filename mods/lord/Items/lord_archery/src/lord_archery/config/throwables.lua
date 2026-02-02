local S = minetest.get_translator("lord_archery")

return  {
    ["lord_archery:steel_throwing_axe"] = {
        definition = {
            description      = S("Steel Throwing Axe"),
            inventory_image  = "lord_archery_steel_throwing_axe", -- without ".png"
            groups           = { throwing_axe = 1, throwable = 1, steel_item = 1 },
            uses             = 150,
            sound_on_release = "lord_archery_arrow_release",
            draw_power = 0.75,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.5,
                [2] = 1.75,
            },
        },
        projectile_reg = {
            damage_tt   = 18,
            type        = "throwable",
            entity_name = "lord_archery:steel_throwing_axe",
            entity_reg  = {
                initial_properties = {
                    visual      = "item",
                    wield_item  = "lord_archery:steel_throwing_axe",
                    visual_size = { x = 0.25, y = 0.25, z = 0.25 },
                },
                max_speed            = 20,
                sound_hit_node       = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
                sound_hit_object     = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
                damage_groups        = { fleshy = 18 },
                remove_on_object_hit = false,
                remove_on_node_hit   = false,
                rotation_formula     = "rolling"
            },
        },
    },
    ["lord_archery:bronze_throwing_axe"] = {
        definition = {
            description      = S("Bronze Throwing Axe"),
            inventory_image  = "lord_archery_bronze_throwing_axe", -- without ".png"
            groups           = { throwing_axe = 1, throwable = 1, bronze_item = 1 },
            uses             = 180,
            sound_on_release = "lord_archery_arrow_release",
            draw_power = 0.75,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.5,
                [2] = 1.75,
            },
        },
        projectile_reg = {
            damage_tt   = 22,
            type        = "throwable",
            entity_name = "lord_archery:bronze_throwing_axe",
            entity_reg  = {
                initial_properties = {
                    visual      = "item",
                    wield_item  = "lord_archery:bronze_throwing_axe",
                    visual_size = { x = 0.25, y = 0.25, z = 0.25 },
                },
                max_speed            = 25,
                sound_hit_node       = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
                sound_hit_object     = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
                damage_groups        = { fleshy = 22 },
                remove_on_object_hit = false,
                remove_on_node_hit   = false,
                rotation_formula     = "rolling"
            },
        },
    },
    ["lord_archery:galvorn_throwing_axe"] = {
        definition = {
            description      = S("Galvorn Throwing Axe"),
            inventory_image  = "lord_archery_galvorn_throwing_axe", -- without ".png"
            groups           = { throwing_axe = 1, throwable = 1, galvorn_item = 1 },
            uses             = 210,
            sound_on_release = "lord_archery_arrow_release",
            draw_power = 0.75,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.5,
                [2] = 2,
            },
        },
        projectile_reg = {
            damage_tt   = 26,
            type        = "throwable",
            entity_name = "lord_archery:galvorn_throwing_axe",
            entity_reg  = {
                initial_properties = {
                    visual      = "item",
                    wield_item  = "lord_archery:galvorn_throwing_axe",
                    visual_size = { x = 0.25, y = 0.25, z = 0.25 },
                },
                max_speed            = 20,
                sound_hit_node       = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
                sound_hit_object     = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
                damage_groups        = { fleshy = 26 },
                remove_on_object_hit = false,
                remove_on_node_hit   = false,
                rotation_formula     = "rolling"
            },
        },
    },
    ["lord_archery:mithril_throwing_axe"] = {
        definition = {
            description      = S("Mithril Throwing Axe"),
            inventory_image  = "lord_archery_mithril_throwing_axe", -- without ".png"
            groups           = { throwing_axe = 1, throwable = 1, mithril_item = 1 },
            uses             = 310,
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
            damage_tt   = 30,
            type        = "throwable",
            entity_name = "lord_archery:mithril_throwing_axe",
            entity_reg  = {
                initial_properties = {
                    visual      = "item",
                    wield_item  = "lord_archery:mithril_throwing_axe",
                    visual_size = { x = 0.25, y = 0.25, z = 0.25 },
                },
                max_speed            = 25,
                sound_hit_node       = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
                sound_hit_object     = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
                damage_groups        = { fleshy = 30 },
                remove_on_object_hit = false,
                remove_on_node_hit   = false,
                rotation_formula     = "rolling"
            },
        },
    },
}
