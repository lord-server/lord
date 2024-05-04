local S = minetest.get_translator("mountgen")
local esc = minetest.formspec_escape

local function can_edit(player)
    return minetest.get_player_privs(player:get_player_name())[mountgen.required_priv]
end

local function can_dig(pos, player)
	return can_edit(player)
end

minetest.register_node("mountgen:mountain_spawner", {
	description = S("Mountain spawner"),
	tiles = {
		"mountgen_mountain_spawner.png"
	},
	groups = {cracky=2, not_in_creative_inventory=1},
	can_dig = can_dig,
    on_place = function(itemstack, placer, pointed_thing)
        if (not can_edit(placer)) then
            return itemstack
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,
    after_place_node          = function(pos, placer)
		local meta = minetest.get_meta(pos)
        minetest.log("Meta = "..tostring(meta))
	end
})
