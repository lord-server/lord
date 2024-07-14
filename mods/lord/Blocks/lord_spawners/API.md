# Spawners API

## Class

`lord_spawners`

## Methods

`register_spawner(name, def)`

`name` - mob technical name

`def`:

`egg_name_custom` string
For `lord_spawners` only. Deifnes material for recipes.

`dummy_size` string
Entity size inside the spawner.

`dummy_offset` string
Entity y offset inside the spawner.

`dummy_mesh` string
Entity mesh model inside the spawner.

`dummy_texture` string
Entity mesh texture inside the spawner.

`night_only` string
true - night only
false - day only
'disable' - day and night

`sound_custom` string
Sound used when entity spawns. When not defined one will be attempted to generate.

`boss` string
Boss flag will spawn mob without player near by. Only one mob at the time with ~1 hour intervals.
