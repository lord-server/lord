-- Exclude regression tests / unit tests
exclude_files = {
	"**/spec/**",
}

globals = {
	"beerchat"
}

read_globals = {
	-- Stdlib
	string = {fields = {"split", "trim"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"minetest",
	"vector", "ItemStack",
	"dump", "dump2",

	-- Deps
	"xban", "QoS"
}
