---@class LordWoodenStuffDefinition
---@field desc string @description prefix. Example: `"Alder"`
---@field texture string @planks texture. Example: `"lord_planks_alder.png"`
---@field wood_name string @planks nodename. Example: `"lord_planks:alder"`

---@type table<string,LordWoodenStuffDefinition>
local wood_defs = {
	["alder"]       = { desc="Alder",       texture="lord_planks_alder.png",     	wood_name="lord_planks:alder", },
	["beech"]       = { desc="Beech",       texture="lord_planks_beech.png",     	wood_name="lord_planks:beech", },
	["birch"]       = { desc="Birch",       texture="lord_planks_birch.png",     	wood_name="lord_planks:birch", },
	["cherry"]      = { desc="Cherry",      texture="lord_planks_cherry.png",    	wood_name="lord_planks:cherry", },
	["culumalda"]   = { desc="Culumalda",   texture="lord_planks_culumalda.png", 	wood_name="lord_planks:culumalda", },
	["elm"]         = { desc="Elm",         texture="lord_planks_elm.png",       	wood_name="lord_planks:elm", },
	["fir"]         = { desc="Fir",         texture="lord_planks_fir.png",       	wood_name="lord_planks:fir", },
	["hardwood"]    = { desc="Hardwood",    texture="lord_planks_hardwood.png",  	wood_name="lord_planks:hardwood", },
	["junglewood"]  = { desc="Junglewood",  texture="default_junglewood.png",    	wood_name="default:junglewood", },
	["lebethron"]   = { desc="Lebethron",   texture="lord_planks_lebethron.png", 	wood_name="lord_planks:lebethron", },
	["mallorn"]     = { desc="Mallorn",     texture="lord_planks_mallorn.png",   	wood_name="lord_planks:mallorn", },
	["pine"]        = { desc="Pine",        texture="lord_planks_pine.png",      	wood_name="lord_planks:pine", },
	["plum"]        = { desc="Plum",        texture="lord_planks_plum.png",      	wood_name="lord_planks:plum", },
	["wood"]        = { desc="Wooden",      texture="default_wood.png",          	wood_name="default:wood", },
	["white"]       = { desc="White",       texture="lord_planks_white.png",     	wood_name="lord_planks:white", },
	["yavannamire"] = { desc="Yavannamire", texture="lord_planks_yavannamire.png",  wood_name="lord_planks:yavannamire", },
}

--- Stuff types which will not be registered.
---@type table<string,string[]>
local wood_stuff_exceptions = {
--  [wood_type]     = { "doors", "hatch", "fence", "stick", "ladder", "Rhatch", "stanchion", "table", "chair", }
	["alder"]       = {                                               "Rhatch", },
	["beech"]       = { "doors", },
	["birch"]       = {                                               "Rhatch", },
	["cherry"]      = { "doors",                                      "Rhatch", },
	["culumalda"]   = { "doors",                                      "Rhatch", },
	["elm"]         = { "doors", },
	["fir"]         = { "doors",                                      "Rhatch", },
	["hardwood"]    = {                                               "Rhatch", },
	["junglewood"]  = {                   "fence", },
	["lebethron"]   = {                                               "Rhatch", },
	["mallorn"]     = {                                               "Rhatch", },
	["pine"]        = {                                               "Rhatch", },
	["plum"]        = { "doors",                                      "Rhatch", },
	["wood"]        = { "doors", "hatch", "fence", "stick", "ladder", },
	["white"]       = { "doors",                                      "Rhatch", },
	["yavannamire"] = { "doors",                                      "Rhatch", },
}


return {
	wood_defs = wood_defs,
	wood_stuff_exceptions = wood_stuff_exceptions,
	translator = minetest.get_mod_translator(),
}
