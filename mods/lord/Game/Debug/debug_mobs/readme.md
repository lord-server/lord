# debug_mobs

Debug tools for testing mobs. Works only when `environment` is not `production`.

## Settings (`minetest.conf`)

| Setting                         | Value                                 | Description                                                                                                                   |
|---------------------------------|---------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| `debug_mobs.no_damage`          | `true`/`false` (default `false`)      | Player takes no damage from anything (mobs, projectiles, fire, falling).                                                      |
| `debug_mobs.no_attack`          | `true`/`false` (default `false`)      | Mobs never attack (`legacy_mobs`).                                                                                            |
| `debug_mobs.animation_forever`  | `stand`, `walk`, `run`, `punch`/`attack` | All mobs (`legacy_mobs`) play the given animation non-stop: `stand`/`punch` in place, `walk`/`run` straight ahead (no turns, no stops). Implies `no_attack`. |

`debug_mobs.no_damage` is implemented in this mod; `no_attack` & `animation_forever` are read by `legacy_mobs/api.lua`.
