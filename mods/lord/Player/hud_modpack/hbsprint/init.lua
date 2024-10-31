local enable_stamina = false --Set to "true" to enable stamina
if enable_stamina == true then

local S = minetest.get_mod_translator()
-- Vars

local speed         = tonumber(minetest.settings:get ("sprint_speed")) or 2
local key           = minetest.settings:get ("sprint_key") or "Use"
local dir           = minetest.settings:get_bool("sprint_forward_only") ~= false
local particles     = tonumber(minetest.settings:get ("sprint_particles")) or 2
local stamina       = minetest.settings:get_bool("sprint_stamina") ~= false
local stamina_drain = tonumber(minetest.settings:get ("sprint_stamina_drain")) or 0.5
local replenish     = tonumber(minetest.settings:get ("sprint_stamina_replenish")) or 1
--local starve        = minetest.settings:get_bool("sprint_starve") ~= false
--local starve_drain  = tonumber(minetest.settings:get ("sprint_starve_drain")) or 590
local starve_limit  = tonumber(minetest.settings:get ("sprint_starve_limit")) or 6
local autohide      = minetest.settings:get_bool("hudbars_autohide_stamina") ~= false

local sprint_timer_step = 0.5
local sprint_timer = 0
local stamina_timer = 0

local mod_hudbars = minetest.get_modpath("hudbars") or false
local starve
if minetest.get_modpath("hbhunger") then
  starve = "hbhunger"
else
  starve = false
end


-- Functions

local function start_sprint(player)
  if player:get_meta():get("hbsprint:sprinting") == "false" then
      player:set_physics_override({speed = speed})
  end
end

local function stop_sprint(player)
  if player:get_meta():get("hbsprint:sprinting") == "true" then
      player:set_physics_override({speed = 1})
  end
end

local function drain_stamina(player)
  local player_stamina = tonumber(player:get_meta():get("hbsprint:stamina"))
  if player_stamina > 0 then
    player:get_meta():set_float("hbsprint:stamina", player_stamina - stamina_drain)
  end
  if mod_hudbars then
    if autohide and player_stamina < 20 then hb.unhide_hudbar(player, "stamina") end
    hb.change_hudbar(player, "stamina", player_stamina)
  end
end

local function replenish_stamina(player)
  local hunger = tonumber(hbhunger.hunger[player:get_player_name()])
  if hunger >= 18 then
    local player_stamina = tonumber(player:get_meta():get("hbsprint:stamina"))
    if player_stamina < 20 then
      player:get_meta():set_float("hbsprint:stamina", player_stamina + stamina_drain)
    end
    hb.change_hudbar(player, "stamina", player_stamina)
    if autohide and player_stamina == 20 then hb.hide_hudbar(player, "stamina") end
  end
end

local function create_particles(player, name, pos, ground)
  if ground and ground.name ~= "air" and ground.name ~= "ignore" then
    local def = minetest.registered_nodes[ground.name]
    local tile = def.tiles[1] or def.inventory_image or ""
    if type(tile) == "string" then
      for i = 1, particles do
        minetest.add_particle({
          pos = {x = pos.x + math.random(-1,1) * math.random() / 2, y = pos.y + 0.1,
           z = pos.z + math.random(-1,1) * math.random() / 2},
          velocity = {x = 0, y = 5, z = 0},
          acceleration = {x = 0, y = -13, z = 0},
          expirationtime = math.random(),
          size = math.random() + 0.5,
          vertical = false,
          texture = tile,
        })
      end
    end
  end
end

-- Registrations

if mod_hudbars and stamina then
  hb.register_hudbar(
    "stamina",
    0xFFFFFF,
    S("Stamina"),
    {
      bar = "sprint_stamina_bar.png",
      icon = "sprint_stamina_icon.png",
      bgicon = "sprint_stamina_bgicon.png"
    },
    20,
    20,
    autohide,
    nil,
    nil,
    5
  )
end

minetest.register_on_joinplayer(function(player)
  if mod_hudbars and stamina then hb.init_hudbar(player, "stamina", 20, 20, autohide) end
  player:get_meta():set_float("hbsprint:stamina", 20)
end)

minetest.register_globalstep(function(dtime)
  sprint_timer = sprint_timer + dtime
  stamina_timer = stamina_timer + dtime
  if sprint_timer >= sprint_timer_step then
    for _,player in ipairs(minetest.get_connected_players()) do
      local ctrl = player:get_player_control()
      local key_press = false
      if key == "Use" and dir then
        key_press = ctrl.aux1 and ctrl.up and not ctrl.left and not ctrl.right
      elseif key == "Use" and not dir then
        key_press = ctrl.aux1
      end
      -- if key == "W" and dir then
      --   key_press = ctrl.aux1 and ctrl.up or key_press and ctrl.up
      -- elseif key == "W" then
      --   key_press = ctrl.aux1 or key_press and key_tap
      -- end

      if key_press then
        local name = player:get_player_name()
        local hunger = 30
        local pos = player:get_pos()
        local ground = minetest.get_node_or_nil({x=pos.x, y=pos.y-1, z=pos.z})
        local player_stamina = tonumber(player:get_meta():get("hbsprint:stamina"))
        if starve == "hbhunger" and not minetest.is_creative_enabled(name) then
          hunger = tonumber(hbhunger.hunger[name])
        end
        if player_stamina > 0 and hunger > starve_limit then
          start_sprint(player)
          player:get_meta():set_string("hbsprint:sprinting", "true")
          if stamina then drain_stamina(player) end
          if particles then create_particles(player, name, pos, ground) end
        else
          stop_sprint(player)
          player:get_meta():set_string("hbsprint:sprinting", "false")
        end
      else
        stop_sprint(player)
        player:get_meta():set_string("hbsprint:sprinting", "false")
        if stamina_timer >= replenish then
          if stamina then replenish_stamina(player) end
          stamina_timer = 0
        end
      end
    end
    sprint_timer = 0
  end
end)

end
