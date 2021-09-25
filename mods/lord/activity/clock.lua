local S = minetest.get_translator("activity")
local esc = minetest.formspec_escape

clock = {}

clock.draw_arrow = function(self, pos, hour, clear)
	local node = "default:bronzeblock"
	if clear then
		node = "air"
	end

	hour = hour % 12
	local sector = math.floor(hour / 3)
	local phase = hour % 3

	local main_axis
	local sec_axis
	local dir_main
	local dir_sec

	if sector == 0 then
		main_axis = "y"
		sec_axis = "x"
		dir_main = 1
		dir_sec = 1
	elseif sector == 1 then
		main_axis = "x"
		sec_axis = "y"
		dir_main = 1
		dir_sec = -1
	elseif sector == 2 then
		main_axis = "y"
		sec_axis = "x"
		dir_main = -1
		dir_sec = -1
	elseif sector == 3 then
		main_axis = "x"
		sec_axis = "y"
		dir_main = -1
		dir_sec = 1
	end

	local epos = {x=pos.x, y=pos.y, z=pos.z}

	if phase == 0 then
		epos[main_axis] = pos[main_axis] + dir_main*1
		minetest.set_node(epos, {name=node})

		epos[main_axis] = pos[main_axis] + dir_main*2
		minetest.set_node(epos, {name=node})

		epos[main_axis] = pos[main_axis] + dir_main*3
		minetest.set_node(epos, {name=node})

		epos[main_axis] = pos[main_axis] + dir_main*4
		minetest.set_node(epos, {name=node})

		epos[main_axis] = pos[main_axis] + dir_main*5
		minetest.set_node(epos, {name=node})

	elseif phase == 1 then
		epos[main_axis] = pos[main_axis] + dir_main*1
		minetest.set_node(epos, {name=node})

		epos[main_axis] = pos[main_axis] + dir_main*2
		epos[sec_axis] = pos[sec_axis] + dir_sec
		minetest.set_node(epos, {name=node})

		epos[main_axis] = pos[main_axis] + dir_main*3
		epos[sec_axis] = pos[sec_axis] + dir_sec
		minetest.set_node(epos, {name=node})

		epos[main_axis] = pos[main_axis] + dir_main*4
		epos[sec_axis] = pos[sec_axis] + dir_sec*2
		minetest.set_node(epos, {name=node})

	elseif phase == 2 then
		epos[sec_axis] = pos[sec_axis] + dir_sec*1
		minetest.set_node(epos, {name=node})

		epos[sec_axis] = pos[sec_axis] + dir_sec*2
		epos[main_axis] = pos[main_axis] + dir_main
		minetest.set_node(epos, {name=node})

		epos[sec_axis] = pos[sec_axis] + dir_sec*3
		epos[main_axis] = pos[main_axis] + dir_main
		minetest.set_node(epos, {name=node})

		epos[sec_axis] = pos[sec_axis] + dir_sec*4
		epos[main_axis] = pos[main_axis] + dir_main*2
		minetest.set_node(epos, {name=node})
	end
end

minetest.register_node("activity:clock", {
        description       = S("Clock"),
        tiles             = { "default_gold_block.png" },
        is_ground_content = true,
        groups            = {  },
        drop              = "activity:clock",
})

minetest.register_abm({
        nodenames = "activity:clock",
        interval  = 1,
        chance    = 1,
        action    = function(pos, node)
		local meta = minetest.get_meta(pos)
		local old_hour = meta:get_int("hour")
		

		local time = minetest.get_timeofday()
		local hour = math.floor(time * 24)
		local minute = math.floor((time * 24 - hour)*60)

		if (old_hour ~= hour) then
			clock:draw_arrow(pos, old_hour, true)
			clock:draw_arrow(pos, hour, false)
			meta:set_int("hour", hour)
		end
	end
})
