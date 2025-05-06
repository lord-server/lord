

local except = { 'lord_rocks:mordor_stone' }

local rocks = table.merge(
	{ ['default:stone'] = {}, },
	table.except(rocks.get_lord_rocks(), except)
)


return table.keys(rocks)
