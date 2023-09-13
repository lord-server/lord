-- register monster/animal/npc as factions

factions:register_faction("animal", {})

factions:register_faction("npc", {
	friends = {"npc"},
	hostiles = {"monster"},
})

factions:register_faction("monster", {
	friends = {"monster"},
	hostiles = {"npc"},
})
