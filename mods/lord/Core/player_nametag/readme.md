Player NameTag Manager (`player_nametag`)
=========================================

This the API mod & it has no sense without other mods.

What is this for?
-----------------
This mod manage player name-tag displaying above the player,
so that changes made from different mods can be displayed together.

Name tag can contain several parts (segments), for example:
 - the nickname itself
 - current health
 - player level
 - the role of player (admin, moderator, ...)
 - maybe name of faction or clan

This parts can be set by different mods for/or different games.

So, in order for mods not to overwrite each other's values, we need a common global manager of NameTag.



How to use in other mods
------------------------
First of all depend your mod on this mod.

While your mod loading you need to initialize and reserve segment in NameTag for your mod:
```lua
    nametag.segments.add("health", "lime", "20")
```
Then, when you need to change the value just:
```lua
    nametag.for_player(player):segment("health"):update("18")
```
That's all !

Full API:
---------

### `Segments`
 - Add new segment definition:
   ```
   nametag.segments.add(name:string, default_color:string, default_value:string): void
   ```
 - Get list of all defined segments at the time:
   ```
   nametag.segments.list(): table<name:string, nametag.Segments.definition>
   ```
 - Check if segment already exists:
   ```
   nametag.segments.exists(name:string): boolean
   ```

### `NameTag`
- Get `NameTag` instance for player:
  ```
  nametag.for_player(player:Player)
  ```
- Get named segment of player NameTag:
  ```
  nametag.for_player(player:Player):segment(name:string): nametag.NameTag.Segment
  ```

### `NameTag.Segment`
You can use `minetest.colorize()` for parts of your value for segments.  
Also yuu can use callback function for calculate your value. yuu can use callback function for calculate your value.
- Set new text for the segment (*Note: no update of displaying):
  ```
  nametag.for_player(player:Player):segment(name:string):set_value(text:string): self
  ```
  or set text and color (overwrites color from definition):
  ```
  nametag.for_player(player:Player):segment(name:string):set_value(text:string, color:string): self
  ```
  or set just color:
  ```
  nametag.for_player(player:Player):segment(name:string):set_color(color:string): self
  ```
  
- Then update displaying name-tag:
  ```
  nametag.for_player(player:Player):segment(name:string):update() void
  ```
  
- Or just Quick "alias" for `:set_value(text:string, color:string):update()` use:
  ```
  nametag.for_player(player:Player):segment(name:string):update(text:string[, color:string]) void
  ```
  
- Update displaying NameTag for player:
  ```
  nametag.for_player(player:Player):force_refresh(): void
  ```
