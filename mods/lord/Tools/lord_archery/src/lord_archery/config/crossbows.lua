local S = minetest.get_translator("lord_archery")

return  {
    ["lord_archery:wooden_crossbow"] = {
        definition = {
            description      = S("Wooden Crossbow"),
            inventory_image  = "lord_archery_wooden_crossbow", -- without ".png"
            groups           = { wooden = 1, crossbow = 1, archery_item = 1 },
            uses             = 100,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "bolt" },
            draw_power = 0.7,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.75,
                [2] = 1.25,
                [3] = 1.75,
            },
        },
    },
    ["lord_archery:tin_crossbow"] = {
        definition = {
            description      = S("Tin Crossbow"),
            inventory_image  = "lord_archery_tin_crossbow", -- without ".png"
            groups           = { tin_item = 1, crossbow = 1, archery_item = 1 },
            uses             = 120,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "bolt" },
            draw_power = 0.8,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.65,
                [2] = 1.15,
                [3] = 1.65,
            },
        },
    },
    ["lord_archery:steel_crossbow"] = {
        definition = {
            description      = S("Steel Crossbow"),
            inventory_image  = "lord_archery_steel_crossbow", -- without ".png"
            groups           = { steel_item = 1, crossbow = 1, archery_item = 1 },
            uses             = 150,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "bolt" },
            draw_power = 0.9,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.55,
                [2] = 1.05,
                [3] = 1.55,
            },
        },
    },
    ["lord_archery:silver_crossbow"] = {
        definition = {
            description      = S("Silver Crossbow"),
            inventory_image  = "lord_archery_silver_crossbow", -- without ".png"
            groups           = { silver_item = 1, crossbow = 1, archery_item = 1 },
            uses             = 190,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "bolt" },
            draw_power = 1,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.55,
                [2] = 1.05,
                [3] = 1.55,
            },
        },
    },
    ["lord_archery:gold_crossbow"] = {
        definition = {
            description      = S("Gold Crossbow"),
            inventory_image  = "lord_archery_gold_crossbow", -- without ".png"
            groups           = { gold_item = 1, crossbow = 1, archery_item = 1 },
            uses             = 200,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "bolt" },
            draw_power = 1,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = 0.5,
                [2] = 1,
                [3] = 1.5,
            },
        },
    },
    ["lord_archery:galvorn_crossbow"] = {
        definition = {
            description      = S("Galvorn Crossbow"),
            inventory_image  = "lord_archery_galvorn_crossbow", -- without ".png"
            groups           = { galvorn_item = 1, crossbow = 1, archery_item = 1 },
            uses             = 250,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "bolt" },
            draw_power = 1.2,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = .25,
                [2] = .75,
                [3] = 1,
            },
        },
    },
    ["lord_archery:mithril_crossbow"] = {
        definition = {
            description      = S("Mithril Crossbow"),
            inventory_image  = "lord_archery_mithril_crossbow", -- without ".png"
            groups           = { mithril_item = 1, crossbow = 1, archery_item = 1 },
            uses             = 350,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "bolt" },
            draw_power = 1.4,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = .25,
                [2] = .75,
                [3] = 1,
            },
        },
    },
}
