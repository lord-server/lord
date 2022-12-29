#!/usr/bin/env lua
-- This script is created to convert old races.txt file into SQL file
-- for import into minetest database
--
-- Generated SQL file adds records into table "player_metadata"
-- If minetest uses sqlite database, it can be imported by
--
-- sqlite3 players.sqlite < races.sql
--
-- In case of other database read the documentation to database.
--
-- How to generate SQL file:
--
-- luajit transfer_races.lua races.txt > races.sql

local function read_races(filename)
    local f = io.open(filename, "rt")
    if f then
        local content = f:read()
        f:close()
        local races = loadstring(content)
        return races()
    end
    return nil
end

local function escape_str(s)
    s = s:gsub('\'', '\'\'')
    return "\'"..s.."\'"
end

--- @param player_name string
--- @param attribute string attribute name
--- @param value any
local function generate_insert_stmt(player_name, attribute, value)
    return "INSERT INTO player_metadata (player, attr, value) " ..
        "VALUES (" .. escape_str(player_name) .. ", " .. escape_str(attribute) .. ", " .. escape_str(tostring(value)) .. ");"
end
--- @param privs table
local function serialize_privileges(privs)
    local val = "return {"
    for priv_name, priv_value in pairs(privs) do
        if priv_value then
            val = val..'"'..tostring(priv_name)..'",'
        end
    end
    val = val.."}"
    return val
end

function recode_races(races)
    local revoked_privs = races["revoked_privs"]
    local granted_privs = races["granted_privs"]
    local players = races["players"]
    local can_change = races["can_change"]
    local skins = races["skins"]

    for name, privs in pairs(revoked_privs) do
        local serialized_privileges = serialize_privileges(privs)
        print(generate_insert_stmt(name, "player:revoked_privs", serialized_privileges))
    end

    for name, privs in pairs(granted_privs) do
        local serialized_privileges = serialize_privileges(privs)
        print(generate_insert_stmt(name, "player:granted_privs", serialized_privileges))
    end

    for name, change in pairs(can_change) do
        print(generate_insert_stmt(name, "player:has_second_chance", change))
    end

    for name, skin in pairs(skins) do
        print(generate_insert_stmt(name, "player:skin", skin))
    end

    for name, player in pairs(players) do
        local race = player[1]
        local gender = player[2]
        print(generate_insert_stmt(name, "player:gender", gender))
        print(generate_insert_stmt(name, "player:race", race))
    end
end

local races = read_races(arg[1])
recode_races(races)
