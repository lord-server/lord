local SL = lord.require_intllib()

--ELF RINGS
--FUNCTION = Sets your health to max every 30 seconds.
minetest.register_craftitem("lottother:blue_gem_ring", {
	description = SL("Blue Gem Ring"),
	inventory_image = "lottother_bluegem_ring.png",
    	groups = {forbidden=1},
	stack_max = 1,
})

minetest.register_craftitem("lottother:vilya", {
	description = SL("Vilya"),
	inventory_image = "lottother_vilya.png",
    	groups = {forbidden=1},
	stack_max = 1,
})

minetest.register_craftitem("lottother:narya", {
	description = SL("Narya"),
	inventory_image = "lottother_narya.png",
   	groups = {forbidden=1},
	stack_max = 1,
})

minetest.register_tool("lottother:nenya", {
	description = SL("Nenya"),
	inventory_image = "lottother_nenya_inv.png",
	wear = 0,
})

minetest.register_tool("lottother:dwarf_ring", {
	description = SL("Dwarf Ring"),
	inventory_image = "lottother_dwarf_ring.png",
	groups = {forbidden=1},
})


local function starts_with(str, st)
	return string.sub(str, 1, string.len(st)) == st
end
