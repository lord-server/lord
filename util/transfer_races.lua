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

function read_races(filename)
    local f = io.open(filename, "rt")
    if f then
        local content = f:read()
        f:close()
        local races = loadstring(content)
        return races()
    end
    return nil
end

function escape_str(s)
    s = s:gsub('\'', '\'\'') 
    return "\'"..s.."\'"
end

function recode_races(races)
    local revoked_privs = races["revoked_privs"]
    local granted_privs = races["granted_privs"]
    local players = races["players"]
    local can_change = races["can_change"]
    local skins = races["skins"]

    for name, privs in pairs(revoked_privs) do
        local val = "return {"
        for priv,revoked in pairs(privs) do
            if revoked then
                val = val..'"'..tostring(priv)..'",'
            end
        end
        val = val.."}"
        local cmd = "INSERT INTO player_metadata (player, metadata, value) "..
                    "VALUES ("..escape_str(name)..",'player:revoked_privs',"..
                    escape_str(tostring(val))..");"
        print(cmd)
    end

    for name, privs in pairs(granted_privs) do
        local val = "return {"
        for priv,granted in pairs(privs) do
            if granted then
                val = val..'"'..tostring(priv)..'",'
            end
        end
        val = val.."}"
        local cmd = "INSERT INTO player_metadata (player, metadata, value) "..
                    "VALUES ("..escape_str(name)..",'player:granted_privs',"..
                    escape_str(tostring(val))..");"
        print(cmd)
    end

    for name, change in pairs(can_change) do
        local cmd = "INSERT INTO player_metadata (player, metadata, value) "..
                    "VALUES ("..escape_str(name)..",'player:has_second_chance','"..
                    tostring(change).."');"
        print(cmd)
    end

    for name, skin in pairs(skins) do
        local cmd = "INSERT INTO player_metadata (player, metadata, value) "..
                    "VALUES ("..escape_str(name)..",'player:skin','"..
                    tostring(skin).."');"
        print(cmd)
    end

    for name, player in pairs(players) do
        local race = player[1]
        local gender = player[2]
        local cmd = "INSERT INTO player_metadata (player, metadata, value) "..
                    "VALUES ("..escape_str(name)..",'player:gender','"..
                    tostring(gender).."');"
        print(cmd)
        local cmd = "INSERT INTO player_metadata (player, metadata, value) "..
                    "VALUES ("..escape_str(name)..",'player:race','"..
                    tostring(race).."');"
        print(cmd)
    end
end

local races = read_races(arg[1])
recode_races(races)
