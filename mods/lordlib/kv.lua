--[[
Simple key-value storage

This mod three public functions:
  lord.kv_set(key, value, mod)
  ^ Returns nil if the key isn't either string or number

  lord.kv_get(key, mod)
  ^ Returns the saved value or (if error occurs) nil

  lord.kv_save()
  ^ Returns true on success, false otherwise

`key` MUST NOT be nil

If you want to remove object from the storage, call lord.kv_set(key, nil)

I don't recommend to save manually because it saves automatically every N seconds
Also don't forget to add `lord_lord` to your depends.txt
--]]
if not minetest.global_exists("lord") then
	lord = {}
end

-- TODO: use settings
local KV_FILE = minetest.get_worldpath().."/storage.serialized"
local SAVE_INTERVAL = 10 -- seconds

local storage = {}
local content_changed = false
local timer_delta = 0

local function load()
	local input = io.open(KV_FILE, "r")
	if not input then
		return false
	end
	local content = input:read("*all")
	storage = minetest.deserialize(content)
	input:close()
end

function lord.kv_get(key, mod)
	local modname = minetest.get_current_modname() or mod or "global"
	-- Create table for the mod if it doesn't exist
	if storage[modname] == nil then
		storage[modname] = {}
	end
	-- Prevent crash
	if key == nil then
		minetest.log("error", "In mod \""..modname.."\":")
		minetest.log("error", "  lord.kv_get(): key must not be nil")
		return nil
	end
	return storage[modname][key]
end

function lord.kv_set(key, value, mod)
	local modname = minetest.get_current_modname() or mod or "global"
	-- Create table for the mod if it doesn't exist
	if storage[modname] == nil then
		storage[modname] = {}
	end
	-- Prevent crash
	if key == nil then
		minetest.log("error", "In mod \""..modname.."\":")
		minetest.log("error", " lord.kv_set(): key must not be nil")
		return
	end
	storage[modname][key] = value
	content_changed = true
end

function lord.kv_save()
	local output = io.open(KV_FILE, "w")
	if not output then return false end
	local content = minetest.serialize(storage)
	output:write(content)
	output:close()
	return true
end

load()

-- Trigger lord.kv_save() every SAVE_INTERVAL seconds
minetest.register_globalstep(function(dtime)
	timer_delta = timer_delta + dtime;
	if timer_delta >= SAVE_INTERVAL then
		if content_changed then
			lord.kv_save()
		end
		timer_delta = 0
	end
end)
