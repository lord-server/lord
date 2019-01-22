-- register monster/animal/npc as fractions

fractions:register_fraction("animal", {})

fractions:register_fraction("npc", {
	friends = {"npc"},
	hostiles = {"monster"},
})

fractions:register_fraction("monster", {
	friends = {"monster"},
	hostiles = {"npc"},
})

