
mountgen.config = {
	-- for cone:
	TOP_RADIUS = 10,
	MAX_RADIUS = 20,
	-- /for cone

	ANGLE = 60,
	Y0 = 0,
	METHOD = 'cone',
	SNOW_LINE = 50,
	SNOW_LINE_RAND = 4,
	GRASS_PERCENT = 10,
	FLOWERS_LINE = 35,
	FLOWERS_PERCENT = 10,
	TREE_LINE = 20,
	TREE_PROMILLE = 4,

	--- @type number smoothness coefficient for big scales
	rk_big = 5,
	--- @type number smoothness coefficient for small scales
	rk_small = 100,
	--- @type number for scales greater than this, use rk_big
	rk_thr = 5,

	top_cover = minetest.get_modpath('lord_ground')
		and 'lord_ground:dirt_lorien'
		or  'default:dirt'
	,
}
