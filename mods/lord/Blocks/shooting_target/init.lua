local S = minetest.get_translator("shooting_target")

minetest.register_node("shooting_target:shooting_target", {
	description = S("Shooting target"),
	tiles = {"shooting_target.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,wooden=1},
	on_punch = function (pos, node, puncher, pointed_thing)
        minetest.chat_send_all(S("Player").." "..puncher:get_player_name().." "..S("have hitted the target"))
    end
})
