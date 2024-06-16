---@type string @old mode name
local oldmod = "lottblocks"
---@type string @new mod name
local newmod = "lord_wooden_stuff"

---@param fname string @in format: `"%s:something_%s"`
---@param wood string @name_postfix from config
---@param new_name string? @if given, then it will be used as string to format for new name
local function register_alias_by_str(fname, wood, new_name)
	local old = string.format(fname, oldmod, wood)
	local fname_new = new_name or fname
	local new = string.format(fname_new, newmod, wood)
	minetest.register_alias(old, new)
end


local fnames_with_new_form = {
	["%s:%s_chair"]     = "%s:chair_%s",
	["%s:%s_stanchion"] = "%s:stanchion_%s",
	["%s:%s_table"]     = "%s:table_%s",
}
---@param wood string @name_postfix from config
local function register_aliases_with_new_form(wood)
	for oldn, newn in pairs(fnames_with_new_form) do
		register_alias_by_str(oldn, wood, newn)
	end
end

local fnames_with_same_form = {
	"%s:door_%s",
	"%s:door_%s_a",
	"%s:door_%s_b",
	"%s:door_%s_c",
	"%s:door_%s_d",
	"%s:door_%s_lock_a",
	"%s:door_%s_lock_b",
	"%s:door_%s_lock_c",
	"%s:door_%s_lock_d",
	"%s:fence_%s",
	"%s:fence_rail_%s",
	"%s:hatch_%s",
	"%s:hatch_%s_open",
	"%s:ladder_%s",
	"%s:stick_%s",
}
---@param wood string @name_postfix from config
local function register_aliases_with_same_form(wood)
	for _, fname in ipairs(fnames_with_same_form) do
		register_alias_by_str(fname, wood)
	end
end

return {
	register_aliases_by_wood = function(wood)
		register_aliases_with_new_form(wood)
		register_aliases_with_same_form(wood)
	end
}
