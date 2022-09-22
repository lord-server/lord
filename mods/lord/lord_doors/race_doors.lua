local S = minetest.get_translator("lord_doors")


--- Обработчик on_rightclick для расовых дверей.
---@param owner_race string @раса, которая может открывать эти двери.
---@param pos table
---@param node any @FIXME: нечто неизвестное
---@param clicker Player
---@param itemstack ItemStack
local function race_door_on_rightclick_wrapper(owner_race, pos, node, clicker, itemstack)
	local player = clicker:get_player_name()
	local opened, failed_race = races.race_stuff_opener(owner_race, player, itemstack)
	if opened then
		doors.door_toggle(pos, node, clicker)
	elseif failed_race ~= nil then
		minetest.chat_send_player(player, S("This door can only be opened by @1!", failed_race))
	end
end

doors.register("lord_doors:door_dwarf", {
	description = S("Dwarf Door"),
	inventory_image = "lord_doors_item_dwarf.png",
	groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1, },
	tiles = {{ name = "lord_doors_dwarf.png", backface_culling = true }},
	recipe = {
		{"default:stone", "default:stone"},
		{"default:stone", "lottores:silver_ingot"},
		{"default:stone", "default:stone"},
	},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(...)
		race_door_on_rightclick_wrapper("dwarf", ...)
	end,
})
