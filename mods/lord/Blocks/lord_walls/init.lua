local S = minetest.get_translator("lord_walls")

walls.register(":walls:orc_stone", S("Orc Stone Wall"), "lottblocks_orc_stone.png",
	"lottblocks:orc_stone", default.node_sound_stone_defaults())
walls.register(":walls:orc_brick", S("Orc Brick Wall"), "lottblocks_orc_brick.png",
	"lottblocks:orc_brick", default.node_sound_stone_defaults())
walls.register(":walls:orc_block", S("Orc Block Wall"), "lottblocks_orc_block.png",
	"lottblocks:orc_block", default.node_sound_stone_defaults())
walls.register(":walls:marble_brick", S("Marble Brick Wall"), "lottblocks_marble_brick.png",
	"lottblocks:marble_brick", default.node_sound_stone_defaults())
walls.register(":walls:limestone", S("Limestone Wall"), "lottores_limestone_ore.png",
	"lottores:limestone", default.node_sound_stone_defaults())
walls.register(":walls:marble", S("Marble Wall"), "lottores_marble.png",
	"lottores:marble", default.node_sound_stone_defaults())
walls.register(":walls:frozen_stone", S("Frozen Stone Wall"), "default_stone.png^lottmapgen_frozen.png",
	"lottmapgen:frozen_stone", default.node_sound_stone_defaults())
walls.register(":walls:mordor_stone", S("Mordor Stone Wall"), "lottmapgen_mordor_stone.png",
	"lottmapgen:mordor_stone", default.node_sound_stone_defaults())
walls.register(":walls:mordor_cobble", S("Mordor Cobble Wall"), "lottmapgen_mordor_cobble.png",
	"lottmapgen:mordor_cobble", default.node_sound_stone_defaults())
walls.register(":walls:green_marble", S("Green Marble Wall"), "lord_blocks_green_marble.png",
	"lord_blocks:green_marble", default.node_sound_stone_defaults())
walls.register(":walls:dungeon_stone", S("Dungeon Stone Wall"), "castle_dungeon_stone.png",
	"castle:dungeon_stone", default.node_sound_stone_defaults())

-- Clay/chamotte:
walls.register(":walls:mordor_clay_block", S("Mordor Clay Block Wall"), "lord_bricks_mordor_clay_block.png",
	"lord_bricks:mordor_clay_block", default.node_sound_stone_defaults())
walls.register(":walls:mordor_clay_brick", S("Mordor Clay Brick Wall"), "lord_bricks_mordor_clay_brick.png",
	"lord_bricks:mordor_clay_brick", default.node_sound_stone_defaults())
walls.register(":walls:mordor_clay_masonry", S("Mordor Clay Masonry Wall"), "lord_bricks_mordor_clay_masonry.png",
	"lord_bricks:mordor_clay_masonry", default.node_sound_stone_defaults())
walls.register(":walls:mordor_clay_masonry_large", S("Large Mordor Clay Masonry Wall"),
	"lord_bricks_mordor_clay_masonry_large.png", "lord_bricks:mordor_clay_masonry", default.node_sound_stone_defaults())

walls.register(":walls:chamotte_block", S("Chamotte Block Wall"), "lord_bricks_chamotte_block.png",
	"lord_bricks:chamotte_block", default.node_sound_stone_defaults())
walls.register(":walls:chamotte_brick", S("Chamotte Brick Wall"), "lord_bricks_chamotte_brick.png",
	"lord_bricks:chamotte_brick", default.node_sound_stone_defaults())
walls.register(":walls:chamotte_masonry", S("Chamotte Masonry Wall"), "lord_bricks_chamotte_masonry.png",
	"lord_bricks:chamotte_masonry", default.node_sound_stone_defaults())
walls.register(":walls:chamotte_masonry_large", S("Large Chamotte Masonry Wall"),
	"lord_bricks_chamotte_masonry_large.png", "lord_bricks:chamotte_masonry", default.node_sound_stone_defaults())
