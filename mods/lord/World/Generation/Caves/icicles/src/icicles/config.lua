

local except = { 'lord_rocks:mordor_stone' }

local rocks = table.merge(
	{ ['default:stone'] = {}, },
	table.except(rocks.get_lord_rocks(), except)
)

local icicle_prefix = {}
for rock_name, _ in pairs(rocks) do
	icicle_prefix[rock_name] = 'icicles:' .. rock_name:replace(':', '_') .. '_'
end

local config = {
	--- @type string[]
	rocks         = table.keys(rocks),
	--- @type table<string,string>
	icicle_prefix = icicle_prefix,

	map_gen       = {
		--- @type number
		chunks_per_volume = 1/16,
		chunk_size        = 9,
		icicles_per_chunk = 1,
		height_min        = -31000,
		height_max        = -200,
	},
}


return config
