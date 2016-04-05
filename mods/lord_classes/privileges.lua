local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_privilege("GAMEmale", {
	description = SL("A male player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEfemale", {
	description = SL("A female player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEdwarf", {
	description = SL("A dwarf player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEelf", {
	description = SL("An elf player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEman", {
	description = SL("A man player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEorc", {
	description = SL("An orc player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEhobbit", {
	description = SL("A hobbit player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEshadow", {
	description = SL("A shadow player"),
	give_to_singleplayer = false,
})
minetest.register_privilege("race", {
	description = SL("Change race"),
	give_to_singleplayer = false,
})
