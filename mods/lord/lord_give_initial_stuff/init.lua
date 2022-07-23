-- stackstrings
local initial_stuff = {
	"tools:axe_wood 1",
	"tools:pick_wood 1",
	"lottplants:yavannamirefruit 1",
}

local function give_initial_stuff(player)
	local player_name = player:get_player_name()
	if minetest.is_creative_enabled(player_name) then
		return
	end
	minetest.log("action", string.format("Выдача новому игроку %s стартового набора.", player_name))
	local inv = player:get_inventory()
	for _, stack in pairs(initial_stuff) do
		inv:add_item("main", stack)
	end
end
minetest.register_on_newplayer(give_initial_stuff)
