nazgul_area = {}

local table_has_value
	= table.has_value

local NAZGUL_AREA_IDS = {}

local area_ids      = minetest.settings:get("nazgul_areas") or ""
area_ids            = string.split(area_ids, ",")
for _, v in ipairs(area_ids) do
	table.insert(NAZGUL_AREA_IDS, tonumber(v))
end

local max_per_block = tonumber(minetest.settings:get("max_objects_per_block") or 99)

--- @param pos position
nazgul_area.position_in_nazgul_area = function(pos)
    return table_keys_has_one_of_values(areas:getAreasAtPos(pos), NAZGUL_AREA_IDS)
end

-- copy from mobs mod
local count_mobs = function(pos, type)

	local num_type = 0
	local num_total = 0
	local objs = minetest.get_objects_inside_radius(pos, 40)

	for n = 1, #objs do

		if not objs[n]:is_player() then

			local obj = objs[n]:get_luaentity()

			-- count mob type and add to total also
			if obj and obj.name and obj.name == type then

				num_type = num_type + 1
				num_total = num_total + 1

			-- add to total mobs
			elseif obj and obj.name and obj.health ~= nil then

				num_total = num_total + 1
			end
		end
	end

	return num_type, num_total
end

-- spawn nazguls in nazgul areas
minetest.register_abm({

    label = "nazgul_area_spawning",
    nodenames = {"lord_blocks:green_marble"},
    neighbors = neighbors,
    interval = 30,
    chance = 300,
    catch_up = false,

    action = function(pos, node, active_object_count, active_object_count_wider)
        if active_object_count_wider >= max_per_block then
            return
        end

        if not nazgul_area.position_in_nazgul_area(pos) then
            return
        end

        if math.random(9) == 1 then
            if count_mobs(pos, "lottmobs:witch_king") >= 1 then
                return
            end

            pos.y = pos.y + 1
			minetest.add_entity(pos, "lottmobs:witch_king")
        else
            if count_mobs(pos, "lottmobs:nazgul") >= 8 then
                return
            end

            pos.y = pos.y + 1
			minetest.add_entity(pos, "lottmobs:nazgul")
        end
        
    end
})