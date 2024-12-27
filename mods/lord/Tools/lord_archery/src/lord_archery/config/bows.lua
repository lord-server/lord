local S = minetest.get_translator("lord_archery")

return {
    ["lord_archery:apple_wood_bow"] = {
        definition = {
            description      = S("Apple Wood Bow"),
            inventory_image  = "lord_archery_apple_wood_bow", -- without ".png"
            groups           = { wooden = 1, bow = 1, allow_hold_abort = 1, archery_item = 1 },
            uses             = 90,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "arrow" },
            draw_power = 0.6,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = .5,
                [2] = 1.0,
                [3] = 1.50,
            },
        },
    },
    ["lord_archery:alder_wood_bow"] = {
        definition = {
            description      = S("Alder Wood Bow"),
            inventory_image  = "lord_archery_alder_wood_bow", -- without ".png"
            groups           = { wooden = 1, bow = 1, allow_hold_abort = 1, archery_item = 1 },
            uses             = 120,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "arrow" },
            draw_power = 0.9,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = .25,
                [2] = .75,
                [3] = 1.25,
            },
        },
    },
    ["lord_archery:birch_wood_bow"] = {
        definition = {
            description      = S("Birch Wood Bow"),
            inventory_image  = "lord_archery_birch_wood_bow", -- without ".png"
            groups           = { wooden = 1, bow = 1, allow_hold_abort = 1, archery_item = 1 },
            uses             = 180,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "arrow" },
            draw_power = 1,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = .25,
                [2] = .75,
                [3] = 1.25,
            },
        },
    },
    ["lord_archery:mallorn_wood_bow"] = {
        definition = {
            description      = S("Mallorn Wood Bow"),
            inventory_image  = "lord_archery_mallorn_wood_bow", -- without ".png"
            groups           = { wooden = 1, bow = 1, allow_hold_abort = 1, archery_item = 1 },
            uses             = 210,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "arrow" },
            draw_power = 1,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = .25,
                [2] = .65,
                [3] = 1.05,
            },
        },
    },
    ["lord_archery:lebethron_wood_bow"] = {
        definition = {
            description      = S("Lebethron Wood Bow"),
            inventory_image  = "lord_archery_lebethron_wood_bow", -- without ".png"
            groups           = { wooden = 1, bow = 1, allow_hold_abort = 1, archery_item = 1 },
            uses             = 350,
            sound_on_release = "lord_archery_arrow_release",
            used_projectiles = { "arrow" },
            draw_power = 1.2,
        },
        stage_conf = {
            charging_time = {
                [0] = 0,
                [1] = .25,
                [2] = .65,
                [3] = 1.05,
            },
        },
    },
}
