# Change Log

## [2024.06](https://github.com/lord-server/lord/releases/tag/2024.06)
 - Колонны теперь можно ставить без блока под ними. Closes #1269 (#1361)
 - Dirt bloscks: add coarse & stony dirts for desert & mordor. Closes #1321
 - Add Lembas. Closes #1491
 - Added reinforced hatches (#1380). Closes #1226
 - Add lord_books:scroll (#1328)
 - Add straw bed. And you can sleep on it (#1394)
 - Clans v2:
   - feature: max players in clan - 10 (fixes #1346)
   - Feature: raid bell notification cooldown. Closes #1325 (#1381)
   - Auto-Kick inactive players from clans (#1385). Closes #1324.
   - Added clan Tapestries (#1393). Closes #1370.
     - README for clan tapestries (#1399)
   - Feature: clan blocking (#1396). Closes #1372.
   - Refresh player tag-name (add/del clan postfix) on the fly, when player {add|delete}ed to clan (no need to re-login) (#1398)
   - Commands `clans.list` and `clans.show` available for all (closes #1432)
 - Reduced time of day end for beds (#1410). Closes #780.
 - Configure Hobbiton coordinates. Official opening of Hobbits spawn.
 - Tooltips: for food items now shows food points. Closes #1484

 - Textures:
   - New textures for mithril, silver, tin, copper, gold, iron ores. Close #1290

 - Bug fixes:
   - Correction of the number of used bottles when crafting mead. fix #1350
   - Adding a check for the ability to place bottles (stop brewer barrel if not enough place). fix #1364 (#1365)
   - No warning of non-existent textures when login. (#1358) Fixes #1354
   - Fix invisible fishes (Set use_texture_alpha = false for mobs)
   - Unified straw: Fixed multiple straws: using farming's (#1426). Closes #1414. Closes #1203.
   - Now pictures and not annihilates blocks. Closes #319
   - Fixes for painting mod (#1482). Closes #1197.
   - Extended Tooltips: add "Luminance: N" for Lampposts. Fixes #1483

 - Technical:
   - Clans enchancements. Add localization (#1357). Closes #1347
   - Force Linux eol in `.gitattributes`.
   - Add label `unconfirmed` into bug-issue template.
   - Fix: english troubles
   - Refactoring castle (tapestries) (#1389). Relates to #1370
   - Add straw bed craftitem texture and use textures from castle (#1395)
   - Add CODE_OF_CONDUCT.md
   - CODE_OF_CONDUCT.md fixes
   - Generated mods: fix tabs in `init.lua`; add `mod.conf`; add cmd & arg description.
   - Added clans callbacks API
   - Total turning off mechanism if no `lord_ground.mordor_{from|to}` settings found (#1369). Closes #1360.
   - Removed unnecessary clear craft statements (#1416). Closes #710
   - Fixed global planks (#1417).  Closes #1415
   - Clans v2: rectructure files. Relates to #1419
   - Clans v2: rename some functions and commands. Relates to #1422
   - Clans v2: minimal restructure `clans` mod as new format. Closes #1419
   - Add mod `player_nametag` for managing displayed phrase. Closes #1427
   - Fix crash on clan player auto-kick. Closes #1430
   - NameTag Manager: add ability to pass params into `Segment:update()`. Relates to #1427
   - Clans: auto-kick: log error, if no `auth` for player found. Relates to #1430
   - NameTag Manager: add ability to use `Segment:update()` with values & ability to use function as `value`. Relates to #1427
   - Clans v2: use `player_nametag` mod. Relates to #1423
   - Clans v2: rename subscription functions. Relates to #1424
   - Clans v2: change callbacks signature; use own callbacks for nametags. Relates to #1423
   - Clans v2: unify change player nametsg; remove redundant functions. Relates to #1423
   - Clans v2: extract some nametag operations into separate file. Closes #1423
   - Clans v2: just reorder code in `callbacks.lua`. Relates to #1424
   - Clans v2: fix fogotten `require("clans.players.nametag")`. Relates to #1423.
   - Clans v2: rename & collect all subscribers callbacks in one array. Relates to #1424
   - Clans v2: rename callbacks types. Relates to #1424
   - Clans v2: rename `callbacks` => `Event`. Relates to #1424
   - Clans v2: unify `Event` subscription. Relates to #1424
   - Clans v2: unify `Event` subscribers notification. Relates to #1424
   - Clans v2: unify `Event` triggering. Closes #1424
   - Clans v2: fix typo. Relates to #1430
   - Fix nametag cleaning
   - Added on_clan_player_join/leave callbacks
   - Added on_clan_(un)blocked callbacks
   - Fixed review remark
   - Clans v2. Change `/clans.register` command. Add color. Closes #1440, #1435
   - Clans v2:  in several lines; add color for title. #1433
   - Beautified clans.list chat command
   - Improved clans.list and beautified clans.list
   - /lists writes localized strings now (#1447)
   - Clans: players must exist now (#1458). Closes #1421.
   - Converted lottblocks/sounds to mono. Fixes #1460. (#1462)
   - Created new mod lord_wooden_stuff. Relates to #1233
   - Moved wooden_stuff.lua to lord_wooden_stuff.api
   - %s/lottblocks/lord_wooden_stuff/g - relates to #1233.
   - Removed lord_planks textures dups. Relates to #1233
   - Removed ladder inventory images. Relates to #1233.
   - Moved textures to new mod. Relates to #1233.
   - Used optipng on textures and deleted metadata. Relates to #1233.
   - Renamed stick textures. Related to #1233
   - Removed wooden_stuff.lua from lottblocks init. Relates to #1233
   - Removed unknown namespace from api. Relates to #1233
   - Corrected stuff names. Relates to #1233
   - Replaced wooden stuff in other mods to new. Relates to #1233
   - Moved wood types to config. Related to #1233
   - Fixed some aliases. Relates to #1233
   - Documented register_wooden_stuff func :memo:
   - Moved locales to new mod. Relates to #1233
   - Replaced weird func with normal one
   - Handling legacy stuff. Relates to #1233
   - Fixed ladder texture. Relates to #1233
   - Created new "type" for wooden stuff def
   - Teached main registering func to work with new def
   - Fixed protected doors textures
   - Moved old legacy aliases to legacy.lua
   - Moved some checks from funcs to registering func
   - Changed LordWoodenStuffDef (separated name)
   - Handled legacy in another way :spaghetti:
   - Some renaming :truck:
   - Separated functions to files :recycle:
   - Fixed localization :globe_with_meridians:
   - Changed func arguments, some renaming :recycle:
   - Standardization of registration functions :recycle:
   - Added exceptions for wood stuff types :recycle:
   - Little enchancements everywhere
   - Fixed luacheck warnings
   - Some refactoring to fix cyclomatic complexity
   - Moved textures to folders.
   - Updating painting mod (#1482). Closes #1197.
   - Unregistered painting canvas 64x64 (it causes freezes)
   - Updated painting submodule
   - Add `http_client` mod skeleton. Relates to #1401 #1402
   - Add `lord_web_api` mod skeleton. Relates to #1401 #1333
   - Game-Web: add add skeleton for `lord_web_integration` mod Closes #1401. Relates to #1234, #1335, #1336, #1337, #1338, #1339
   - Added type hints for http defs (fixes #1403)
   - Add `HTTPApiTable` class definition into `mt-ide-helper`. Relates to #1402
   - Implement HTTP Client. Closes #1402
   - Game-Web: add `lord_web_api`. Closes #1333
   - Game-Web: rename mod `http_client` -> `http`. Relates to #1402
   - Move `Resource` class into `http` mod. Relates to #1402 #1333
   - Game-Web: rename `lord_web_api` -> `web_api` global ver. Relates to #1333
   - `http` mod fixes. Relates to #1402.
   - Game-Web: improve `lord_web_api`: check if `http` not init. Relates to #1333
   - Game-Web: add integrations for `player` creating & updating `last_login` on player join. Closes #1334. Closes #1335
   - Game-Web: add integration for `clan` creation & deletion. Closes #1336. Closes #1443
   - Game-Web: add integration for clan player add & del. Closes #1338, closes #1339
   - Game-Web: add intergation clan online/offline. Closes #1488
   - Add publuc access for `on_clan_[un]clocked` events. Relates to #1437, #1438
   - Game-Web: add intergation clan [un]blocked. Closes #1444
   - Direct poligon MT to production website
   - Fix typo in `set_unblocked()` func.
   - Food points in food items (lord). Relates to #1484
   - Food points in food items (mtg & various). Closes to #1484
   - Tmp tool for print food points.
   - Dirt blocks: replace all old names with new ones. Closes #1348
   - Dirt blocks: add aliases for ghost bloscks. Relates to #1348. Closes #1428
   - Temporary command `/bree`
   - Add alias for legacy `lottmapgen:default_grass`. Closes #1492
   - Update Lembas texture. Relates to #1491
   - Web API: fix parent class contructor call. Fixes #1495
   - Economics: Shops Analytics: add backbone for `web_api.shops`. Relates to #1478


## [2024.04.p4](https://github.com/lord-server/lord/releases/tag/2024.04.p4)
 - Add command `/center`, reserve command `/life`.
 - Change server descrioption & max players. Closes #1449

## [2024.04.p3](https://github.com/lord-server/lord/releases/tag/2024.04.p3)
 - Revert "Fixed paintings (#1383) Fixes #1302."
 - Fixed randomized palette
 - pngquant and removed metadata from canvases

## [2024.04.p2](https://github.com/lord-server/lord/releases/tag/2024.04.p2)
 - Fixed paintings (#1383) Fixes #1302.
 - Change deploymet: add submodules update; new restart method for prod.

## [2024.04.p1](https://github.com/lord-server/lord/releases/tag/2024.04.p1)
 - Fix prod config for Mordor Lands spreading. Relates to #1310
 - Fix lord_ores mithril drop. Closes #1352
 - Add music box
 - Temporary reduced mithril ingots x 10

## [2024.04](https://github.com/lord-server/lord/releases/tag/2024.04)
 - Добавление белого списка для прилавков (#1259)
 - Добавление густых веток сакуры и белого дерева (#1266). Closes #1260
 - Add plum tree own trunk (relates to #1288). Fix trunk trunslations - add trunk and slabs - correct growing from sapling - correct generation in biomes - add to list of WE_ext command //clear_trees
 - Wooden:
   - Add plum tree planks and their stairs & slabs. Relates to #1288
   - Add plum all wooden stuff. Relates #1288
 - Ground: add mixed dirts:
   - Coarse & Stony. Closes #1311
   - make possible cultivate the `lord_ground:coarse_dirt` & `lord_ground:stony_dirt` by hoe. Closes #1319
   - `lord_ground:coarse_dirt` & `lord_ground:stony_dirt` drops themselves. Relates to #1319
 - Add new rocks:
   - Андезит
   - Базальт
   - Диорит
   - Гранит
   - Серый кварцит
   - Серый туф
   - Перидотит
   - Розовый кварцит
   - Пироксенит
   - Красный туф
   - Глинистый сланец
   - Add rock biomes generation in deep caves. Relates to #1296 #1273
 - Ground:
   - Add Mordor Lands spreading!! Closes #1310
 - Электронный заместитель смотрителя (#1285)
 - Небольшие улучшения:
   - Теперь в центрифуге можно перекладывать предметы с shift+click (#1268)
   - Сброс пустой бутылки при крафте медовухи (#1300) Closes #41
 - Текстуры:
   - Обновление текстуры каменного блока (#1265). Relates to #1263
   - Обновление текстур лошади и пони (#1264)
   - Plants: Новая текстура тростника (#1294)
   - Ground: Dirt: for biomes: change grass colors: each biome have own. Closes #1320

 - Technical:
   - Delete unused texture zqzu.png (#1267)
   - [broken code] Refactoring `lottplants`: extract trees: just move everything related. Relates to #1262
   - [broken code] Refactoring `lottplants`: extract trees: rename nodes & files `lottplants_*` -> `lord_trees_*`. Relates to #1262
   - [broken code] Refactoring `lottplants`: extract trees: rename leaves & fruits. Relates to #1262
   - [broken code] Refactoring `lottplants`: extract trees: rename saplings. Relates to #1262
   - [broken code] Refactoring `lottplants`: extract trees: rename trunks. Relates to #1262
   - Refactoring `lottplants`: extract trees: finaly commit: add aliases for Ghost blocks. Closes #1262
   - Refactoring `lottplants`: extract planks into separate mod. Relates to #1238. Closes #1295
   - Add MT  class docs
   - Use our fork `lord-server/mt-chat-lp-api` for Discord LP API mod
   - [lord_bows] Частичное исправление луков (#1297) Relates to #966 #76
   - Disable http requests from LP-API for test & local
   - IDE helper: Add `EntityDefinition` & `ObjectProperties`
   - Refactor lord_bows (#1303)
   - Upadate `readme.md`: actualize contributors and theirs roles in the project
   - Add simple mod backbone creator. Relates to #1299
   - Refactoring `lottplants`: register public API for `lord_treea`. Relates to #1238, #1299
   - Extract textures folder detection in `Core`. Relates to #1233
   - Refactor planks: use trees API for regigiser planks. Relates #1238, #1236
   - Refactoring mountgen (#1306)
   - Ground: Dirt: add backbone for `lord_dirt` mod. Closes #1308
   - Ground: add dirt & sand APIs. Closes #1308
   - Ground: move `lottmapgen:mordor_sand` into `lord_ground`. Relates to #1309
   - Ground: move biomes gradded into `lord_ground`. Closes #1309
   - Ground: Dirt: collect `mixed_nodes` (forgotten). Relates to #1311
   - Rocks: Nodes:  add `lord_rocks` mod backbone. Relates to #1270 #1283
   - Update lord_rocks_diorite.png
   - Add Shale and Pyroxenite rocks; format config.lua. Relates to #1270 #1283
   - Add textures
   - Update texture granite and pyroxenite. Relates to #1296 #1273
   - Update texture quartzite & tuff
   - Add backbone TODO for adding walls for new rocks. Relates to #1298
   - Fix rock API; add  field to differentiate new oand existing ones; move magma to lord_ores. Relates to #1296 #1273
   - Rename localization files to match mod name; corrected names of some variables. Relates to #1296 #1273
   - Change existing detection mechanism. Relates to #1296 #1273
   - Add stair registration; move frozen_stone to lord_rocks; add mordor_sone via add_existing. Relates to #1296 #1273
   - Move mordor_stone to lord_rocks; add ore variants and their generation; make magma animated. Relates to #1296 #1273
   - Change all entries of lottmapgen:mordor_stone and lottmapgen_mordor_stone to the lord_rocks version. Relates to #1296 #1273
   - Fix small texture construction mistake. Relates to #1296 #1273
   - Fix localization problems for lord_rocks. Relates to #1296 #1273 (#1322)
   - Fix plum stuff traslations. Relates to #1288
   - Moved clans API to mod storage
   - Clans refactoring
   - Minetest type hinting enchancements
   - Fix Coarse/Stony Dirts localization. Relates to #1311

## [2024.03.p5](https://github.com/lord-server/lord/releases/tag/2024.03.p5)
 - Add members into International clan.

## [2024.03.p4](https://github.com/lord-server/lord/releases/tag/2024.03.p4)
 - Add members into "International" clan

## [2024.03.p3](https://github.com/lord-server/lord/releases/tag/2024.03.p3)
 - Add new clan "International"
 - Open clan chest only for players from any clans, not for regular players.

## [2024.03.p2](https://github.com/lord-server/lord/releases/tag/2024.03.p2)
 - Add human spawn point in Bree.
 - Add `Shishka_mason` into `Massons` clan.

## [2024.03.p1](https://github.com/lord-server/lord/releases/tag/2024.03.p1)
 - Add aliases for old & deleted nodes. Fixes #1258
 - Add forgotten traslations for new wooden blocks. Fixes #1257

## [2024.03](https://github.com/lord-server/lord/releases/tag/2024.03)
 - Lava cooling into mordor stone with mordor water
 - Interior: add `flowerpot` mod. Relates to #1245
 - Clay nodes: add walls for mordor clay & chamotte block/brick/masonries. Closes #1250
 - Weapons: change orcish sword craft. Closes #1221
 - Dungeons:
   - Add second bad & chest into right north corner. Relates to #1205
   - Add Dead Man spawn in rooms with chests. Relates to #1213
   - Add book shelves generation. Relates to #1205
   - Add brewer barrel. Relates to #1205
   - Add diner zone generation. Relates to #1205
   - Dwarf Tombs with drop below y -500. Closes #1206
 - MapGen:
   - Add fern and jungle grass into Mirkwood biome. Closes #1122
 - Wooden:
   - Add tapestry top from other woods. Closes #1229
   - Add Elm own trunk & slab, elm planks & all stairs. Relates to #1224
   - Add all stuff for Fir except doors. Relates to #1230
   - Add all stuff for Elm except doors. Relates to #1224
   - Add Beech own trunk, plank, stick & all wooden stuff. Closes #1251 Closes #832
   - Add Cherry tree(leaves,sapling,grow), planks & wooden staff. Closes #1253
   - Add Culumalda own trunk, plank, stick & all wooden stuff. Closes #1254
   - Change beech tree generation. Relates to #1237 #1238
 - Bug Fixes:
   - No chop planks stairs with swords, duggers,.. Fixes #1241
   - Fix typo 'оркский' -> 'орочий'.
   - MapGen: fix trunk for generated fir tree. Relates to #661

 - Technical:
   - Move `icicles` to `Generation`. Closes #1194. Relates #1079
   - `protector_lott`: Remove unnecessary textures & code. Relates to #1185
   - Generation: rename vars `c_***` into `id_***`. Relates #1084
   - Extract Dwarf Tomb in separate file. Relates to #1206
   - Add `io.file_exits()` & `os.DIRECTORY_SEPARATOR` helpers. Relates to #925
   - Refactoring: add `string.{starts_with,ens_with,contains}()` functions. Relates to #1247
   - Refactoring `wooden_stuff.lua`: separate functions for each registrating item. Relates to #1233
   - Refactoring `wooden_stuff.lua`: unify stanchion registration & names. Relates to #1233
   - Wooden blocks: Refactoring `lottplants`: move planks into separate file. Relates to #1236 #1238
   - Wooden blocks: Refactoring `lottplants`: move hardwood into `planks.lua`. Relates to #1236 #1238 #1233
   - Wooden blocks: Refactoring `lottplants`: move `hardwood` into this mod (and rename). Relates to #1236 #1233
   - Wooden blocks: Refactoring `lottplants`: extract `regiter_planks` function. Relates to #1236
   - Wooden blocks: Refactoring `lottplants`: fix fir planks texture name. Relates to #1236
   - Wooden blocks: Refactoring `lottplants`: add `planks` group. Relates to #1236
   - Wooden blocks: Refactoring `lottplants`: add `planks` API. Closes #1236
   - Wooden blocks: Refactoring `lottplants`: group planks textures. Relates to #1236 #1238
   - Wooden: refactoring `lottplant`: regicter `planks` API via `_G`: fix luacheck warn. Relates to #1236
   - Wooden: Refactoring `lottplants`: group textures. Relates to #1238, #1237
   - Wooden: refactoring `lottplants`: rename "wild" file and restruct src files. Relates to #1238
   - Wooden: refactoring `lottplants`: reorganize code & files. Relates to #1237 #1238
   - Wooden: refactoring `lottplants`: use `register_sapling()`. Relates to #1237 #1238
   - Wooden: refactoring `lottplants`: use `register_leaf()`. Relates to #1237 #1238
   - Wooden: refactoring `lottplants`: Fix doc-block. Relates #1237
   - Wooden: refactoring `lottplants`: use `register_trunk()`. Relates to #1237 #1238
   - Wooden: refactoring `lottplants`: log used textures names. Relates to #1237 #1238
   - Refactoring `lottplants`: functions: extract `add_roots()`. Relates to #1237 #1238
   - Refactoring `lottplants`: simlify functions code. Relates to #1237 #1238
   - Refactoring `lottplants`: extract branch functions. Relates to #1237 #1238
   - Refactoring `lottplants`: simplify diagonal branches generation. Relates to #1237 #1238
   - Refactoring `lottplants`: extract diagonal branch type gen. Relates to #1237 #1238
   - Refactoring `lottplants`: adapt rowan tree generation. Relates to #1237 #1238
   - Refactoring `lottplants`: adapt apple tree generation. Relates to #1237 #1238
   - Refactoring `lottplants`: add local APIs & iterators for trunks, leaves & saplings. Relates to #1238, #1238
   - Refactoring `lottplants`: extract `add_trunk()`. Relates to #1237 #1238 #942 #1248
   - Refactoring `lottplants`: remove dead code. Relates to #1237 #1238 #942
   - Refactoring `lottplants`: tree-gen: Ensure when places leaf and when trunk. Relates to #1237 #1238 #942. Closes #1248
   - Refactoring `lottplants`: tree-gen: reformat code & rename vars. Relates to #1237 #1238.
   - Refactoring `lottplants`: functions: extract sapling grow ABMs & register with sapling. Relates to #1237 #1238.
   - Refactoring `lottplants`: functions: extract `add_crown_at()`. Relates to #1237 #1238
   - Refactoring `lottplants`: functions: extract `is_crown_corners()`. Relates to #1237 #1238
   - Refactoring `lottplants`: tree-gen: use alternative leaf & property `no_leaves_on_corners`. Relates to #1237 #1238
   - Refactoring `lottplants`: tree-gen: 2x2 trunks. Relates to #1237 #1238
   - Refactoring `lottplants`: extract crown `CONE` type generation. Relates to #1237 #1238
   - Refactoring `lottplants`: unify crown for branches. Closes #1237. Relates to #1238
   - Refactoring `wooden_stuff.lua`: sort textures. Relates to #1233
   - Refactoring `lottmapgen`: fix luacheck errors. Relates to #1084
   - Refactoring `lottplants`: add `TRUNKED` branch type; simplify mallorn branches generation. Relates to #1237 #1238
   - Refactoring `lottplants`: extract `tree.Generator` class. Prepare to #661. Relates to #1238
   - Refactoring `lottplants`: decrease cyclomatic complexity. Closes #942
   - Remove our builtin translations. Closes #1187
   - Extract voxel manipulations wraper `minetest.with_map_part_do()`. Relates to #1084, #1058, #663, #661.
   - Fix linter warnings about line length. Relates to 1238


## [2023.12.p6](https://github.com/lord-server/lord/releases/tag/2023.12.p6)
 - Add player to clan Hansa.
 - Add Hansa Clan Cloack.

## [2023.12.p5](https://github.com/lord-server/lord/releases/tag/2023.12.p5)
 - Fix typo in clan name. Fixes #1249

## [2023.12.p4](https://github.com/lord-server/lord/releases/tag/2023.12.p4)
 - Death Hall: add orc spawn & hall positions config.
 - add clan "Hansa"

## [2023.12.p3](https://github.com/lord-server/lord/releases/tag/2023.12.p3)
 - Restore chest textures after New Year.

## [2023.12.p2](https://github.com/lord-server/lord/releases/tag/2023.12.p2)
 - Fix transparent sheeps. Fixes #1216
 - Add WE `//clear_trees` command.

## [2023.12.p1](https://github.com/lord-server/lord/releases/tag/2023.12.p1)
 - Fix on/off-line clan detection. Fixes #1215
 - Add forgotten locale for Clan Chest.
 - Add "alert bell" when Clan Chest raided
 - Fix translation typo

## [2023.12](https://github.com/lord-server/lord/releases/tag/2023.12)
 - Add walls for LOTT stones. Closes #998
 - Add clan chest
 - Add banisters for all woods. Closes #1048
 - MapGen: Dungeons:
   - add some bricks, stone & mossy cooble into walls. Closes #1140
   - add minimal interior. Closes #1141
   - DeadMen:
     - transparent & some like levitation. Relates to #1207
     - Ability to kill DeadMen. Closes #25
     - make dungeon more guarded:
       - increase DeadMan hp & damage, decrease received damage. Closes #1207
       - increase DeadMan spawn chance, interval & deep. Relates to #1213
 - Change pearl-item texture; Make pearl-block more trasparent. Closes #979.
 - Add `//select_chunks` worldedit command. Closes #1087
 - Add translations for `campfire`. Relates to #328, #1189
 - Fix cooking on campfire.
 - Technical:
   - Update ambience submodule. Also closes #241
   - Extract our admin pick & stick into separate mod. Closes #794
   - WE: delete unused; full update by add submodule from our fork. Closes #783.   Our locale translations lost & needs to be added into fork & then PR to upstream.
   - Upd WE: readd our translations in our fork. Relates to #783 #794
   - Change `ambience` submodule url to new one. Fix build. Fix #1183
   - Move `protector_lott` to our scope (`mods/lord/Blocks/`). Relates to #1185
   - Translate all builtin prases (`Core/builtin/`). Remove our partial translations. Closes #1186. Relates to #1174, #1186
   - Simplify "palantiri" achievement code. Remove `"GAME*"` usage. Relates to #1157, #686
   - Remove last `GAME<race>` privs usage. Drop `lord_base_commands`. Closes #1157, closes #1174
   - Update  submodule (ru translations)
   - Upadate builtin translations to latest version. Relates to #1186.
   - Readd WorldEdit submodule from upstream. Closes #1181
   - some readme fixes
   - Upd `areas`: get only translations from upstream. Relates to #1188, #328
   - Rename locale files. Fixes #1190.
   - Fix couple translations in `areas`. Relates to #1188, #328
   - Move `campfire` mod into our folder `lord/Blocks`. Closes #1189
   - MapGen: extend `minetest` with `.register_on_dungeon_generated()`. Relates to #1140, #1141
   - MapGen: extract Dwarf Tamb generation into separate file. Relates to #1140, #1141
   - MapGen: add detection of rooms walls in dungeons. Relates to #1140 #1141
   - MapGen: fix cyclomatic complexity in `find_room_walls()`
   - MapGen: add `lottmapgen:dwarf_chest_spawner`. Relates to #1141
   - MapGen: add ability to set nodes `param2` when generating dungeon. Relates to #1141
   - MapGen: Dungeons: corrected walls calc/finding. Relates to #1140, #1141
   - MapGen: Dungeons: more readable code. Relates to #1140, #1141
   - MapGen: Dungeons: rename var, fix type hint. Relates to #1140, #1141
   - Up To `5.8`: fix deprecations. Closes #1208
   - Deploy: add `set -e` to Polygon CI. Hope it will stops the job with error when it failed.
   - Re-add WorldEdit via https. (fix deploy)
   - Deploy: stop jobs with error when it fails (for prod).
   - To `5.8`: update MTG mods. Closes #1211
   - To `5.8.0`: Update `minetest.conf.example`. No changes in our configs needed. Closes #1209.
   - Mobs: Ability to specify `armor_groups`. (Copied from upstream). Relates to #25
   - Mobs: ability to use transparent textures. Relates to #1207
   - Add Discord LongPoll API mod (as submodule).
   - Add Discord submodule dir.
   - Configure Discord notifications for Polygon (test server).

## [2023.09.p2](https://github.com/lord-server/lord/releases/tag/2023.09.p2)
 - Temporary New Year textures for chests. Closes #1212.

## [2023.09.p1](https://github.com/lord-server/lord/releases/tag/2023.09.p1)
 - Fix duplication of lamps when inserting into frame. Closes #1204

## [2023.09](https://github.com/lord-server/lord/releases/tag/2023.09)
 - Nazguls can spawns in specified areas & not destroy it (#1109) (#1111)
 - One charcoal from one wood planks. Fixes #1112
 - Remove protection check for placing mobs. Fixes #1110 (#1114)
 - MapGen: Add gravel & desert gravel. Closes #1098 (#1115)
 - Horses:
   - One "horse" in slot. Fixes #1133
   - Fix stucked animation: walk when standing or stand when riding. Fixes #1132
 - Dwarf Tomb:
   - Add Dwarf Tomb nodes. #773
   - Dwarven Tomb achievement. Closes #773
   - MapGen: add dwarf tomb to dungeons rarely. Closese #1139
 - Add sound for chicken. Relates to #347 #1168
 - Add smoke for campfire. (You can use campfire as smoke from a chimney). Resolves #1176
 - Fix "Tourists" achievement
 - Fix obsidian drop chance.
 - Traders:
   - Traders: Different forms for different users. No theft. Fixes #1146
   - Traders: Ability to return goods for select new one & find out the price. Fixes #1145
   - Mobs: Traders: Return forgotten money to player or drop int world. Closes #1156
   - Traders: Use standard background on trading form. Closes #1152
   - Traders: No fraud: if your stack is almost full, the remaining items will be in your hand. Fixes #168
   - Mobs: Traders: ability to pass items by shift+click. Closes #1171
   - Mobs: Traders: persistent goods (money always appears for trading). Relates to #1173
   - Mods: Traders: endless money exchange. Closes #1173
   - Mobs: Traders: fix no price for boat from human trader. Fixes #1175
   - Mobs: Traders: add same race discount calc. Resolves #1159
   - Mobs: (Traders:) unify model size & collision box calc. Fixes #1172 hobbit fat.
   - Change prices for dwarf trader. Relates #1150
   - Fix translation error message on open trader form. Fixes #1151

 - Technical:
   - stale-bot: decrease `daysUntilStale`
   - Add "Check Cyclomatic Complexity" step to GitHub Actions.
   - fix typo in gh-action yml
   - Remove unused saplings from growing LBM. Fixes #711
   - Replace deprecated `:get_look_yaw()` calls with new `:get_look_horizontal() + pi/2`. Fixes #1047
   - IDE Hint: add `VoxelManip` & `VoxelArea` classes.
   - Refactoring: `Game` folder. (Move all mods). Closes #1142
   - Refactoring: `Entities` folder. (Move all mads). Closes #1142
   - Refactoring: move `legacy` & `nodes_dump` into `Core`. Relates to #967
   - Remove unused `alarm` mod. Relates to #967
   - Refactoring: move remaining mods into `Blocks`, `Game` & `World`. Closes #969, #970, #967
   - Mobs: Traders: Refactoring: clear var names & types. Relates to #1147, #1153
   - Mobs: Traders: Refactoring: extract form. Closes #1147
   - Mobs: Traders: Refactoring: use local var, simlify `add_goods`. Relates to #1153
   - Mobs: Traders: Refactoring: simplify `check_pay()` function. Relates to #1153
   - Mobs: Traders: Refactoring: make all helpers local. Relates to #1153
   - Mobs: Traders: Refactoring: make inventory callbacks local. Relates to #1153
   - Mobs: Traders: Refactoring: rename `special_mobs.lua` -> `traders.lua`. Relates to #1148
   - Mobs: Traders: Refactoring: extract common definition. Relates to #1148
   - Refactoring: `lottmobs`: reformat drops. Relates to #1162
   - Mobs: Traders; Move all files into `src/`. Relates to #1148
   - Mobs: Traders: Refactoring: extract inventory. Closes #1153
   - Mobs: Traders: Refactoring: change goods table format. Relates to #1159, #1149
   - Mobs: Traders: Refactoring: rename `TraderDef` -> `TraderConfig` & use local. Relates to #1170
   - Mobs: Traders: rename `TraderConfig` -> `trader.congig` & use only where required. Closes #1170
   - Mobs: Traders: REfactoring: move trader common entity & registration. Closes #1169
   - Mobs: Traders: extract to separate mod. Closes #1148
   - Add `string.is_one_of()`. Decrease cyclomatic complexity in trader/Inventory::on_move. Closes #933
   - Mobs: Traders: extract common goods. Relates to #1173.   also rename `items` -> `goods` in `trader_config`   fix bug: different config name & race for human trader
   - Mods: Traders: ability to configure price as number. Relates to #1159, #1149
   - Mobs: Traders: add check if item registered & not alias. Relates to #1175
   - Mobs: Traders: no race priv usage; detect same race for player & trader. Relates to #1159, #1157
   - Mobs: Traders: refactoring: move `on_move()`. Relates #1159
   - Add debug helpers `__FILE__()`, `__LINE__()`, `__FILE_LINE__()`, `__FUNC__()` into `Core/helpers`.


## [2023.08.p3](https://github.com/lord-server/lord/releases/tag/2023.08.p3)
 - Add drops of stone with coal and obsidian (#1161)
 - One charcoal from one wood planks. Fixes #1112
 - Torch from charcoal.
 - Sounds for `castle:*` nodes. Fixes #1126
 - Place planks always to north directed. Fixes #833
 - Animated mordor water. Fixes #611

## [2023.08.p2](https://github.com/lord-server/lord/releases/tag/2023.08.p2)
 - Add previews for elven clothes. Fixes #1144
 - Add craft for big chains. Fixes #1131
 - Up dwarven axe damage. Relates to #1128
 - Substituting player in Vassals clan.
 - Fix clan player name.

## [2023.08.p1](https://github.com/lord-server/lord/releases/tag/2023.08.p1)
 - Decrease wielded food when feed the riding animal. Fixes #1113
 - Add sounds for `castle:dungeon_stone` & `castle:bound_straw`. Fixes #1123
 - Add lighting for orc torch. Fix #1125
 - Add checks for alias recipes. Fix sign_wall & door_steel recipes. Fixes #1127
 - Add `table.keys_of` to `.luacheckrc`; fix lint.
 - Change throwing axes damsge by mass. Fixes #1128
 - Skeleton rotation ability. Fixes #1129
 - Detach player if horse is killed. Fixes #1102
 - Save horse hp in static data. Fixes #1124
 - Add new player into mason clan.

## [2023.08](https://github.com/lord-server/lord/releases/tag/2023.08)
 - Horses:
   - Take horse with hold `sneak` 
   - Show health for damaged non driven horse.
   - Store hp for teken into inventory horse. Fixes #1100
   - Check if inventory is full on take horse. Fixes #1101
   - Place horse only on surface & only near by. Fixes #513
   - Ability to feed horses. Closes #1104:
     - horses & pony: by carrot, recovers 5 hp
     - wargs: by rotten meat (6 hp) & orc food (5 hp)
 - Use standard bg for chest, workbench, shop & mail box. Relates to #17
 - Add Vassals clan cloak.
 - MapGen: add `farming:cotton_wild`. Add rarity drop itself. Resolves #1105
 - MapGen: add mordor clay. Fix some bugs. Resolves #1077
 - Login can be up to 24 symbols
 - Display clan name in player nametag. Resolves #1107
 - Change road craft. Fixes #1106
 - Added new crafts for walls (Due to MTG update):
   - wall for `"default:brick"`
   - walls for:
     - `"default:sandstone"`
     - `"default:sandstonebrick"`
     - `"default:sandstone_block"`
   - walls for:
     - `"default:stone"`
     - `"default:stonebrick"`
     - `"default:stone_block"`
   - walls for:
     - `"default:desert_stone"`
     - `"default:desert_stonebrick"`
     - `"default:desert_stone_block"`
   - walls for:
     - `"default:desert_sandstone"`
     - `"default:desert_sandstone_brick"`
     - `"default:desert_sandstone_block"`
   - walls for:
     - `"default:silver_sandstone"`
     - `"default:silver_sandstone_brick"`
     - `"default:silver_sandstone_block"`
   - walls for:
     - `"default:obsidian"`
     - `"default:obsidian_brick"`
     - `"default:obsidian_block"`

 - Bug Fixing:
   - Fix insertion lamp into frame & remove it items (use node). Fixes #1097
   - Move resistance while climbing the `default:leaves`. Fixes #683
   - Refactor `dig_tree()`: Fixes #64. Now torch fall down when tree dug.
   - Call `on_rightclick` of node if possible when `on_place` of horse. Fixes #1099
   - Take horse with hold `sneak`. Fixes take horse by arrow hit. Fixes #302
   - Allow ghosts for old upside_down stairs for replacing by ABM. Fixes `unknown` in Minas Tirith. Fix #263

 - Technical:
   - Update `minetest.conf.example` from 5.7.0. Closes #920 Ничего нового для серверной части. Т.о. оновлён только `....example`,   а в наши `....test` и `....prod` ничего не уехало.
   - Core/helpers: add `table.merge_values()`
   - Remove tnt textures, use red bg for egg. Closes #625
   - Change server description & `motd` msg.
   - Remove unused deprecated `default.generate_ore`. Relates to #1079
   - Extract ores generation into `World/Generation`. Relates to #1079
   - Update MTG mods to 5.7.0. Closes #919
     - Fix `player_api.set_model` not updating the animation
     - Flip item textures of glass doors (#3009)
     - Ensure chests close properly (#2965)
     - creative: Override hand after mods loaded... (#2984)
     - Fix crash if `/home` is executed with an invalid name (#3000)
     - Fix wall craft registrations (#3004)
     - Teach screwdriver to rotate 4dir nodes (#2992)
     - Beds: Replace hardcoded values of day interval with constants (#2990)
     - Add color_* groups to wool
     - Added and fixed translations of different languages


## [2023.07.p1](https://github.com/lord-server/lord/releases/tag/2023.07.p1)
 - Update `candles_3d`: Fix dark-{gray|green} candles craft. Fixes #1096
 - Restore bacteria texture. Fixes #1073
 - `junglewood` translations: тропический -> эвкалиптовый. Fixes #1006
 - Change glass stairs & doors textures to our style. Fixes #908

## [2023.07](https://github.com/lord-server/lord/releases/tag/2023.07)
 - Add "Frozen Stone" stairs & slab. Relates to #997
 - Add waterlily into shallow water. Closes #1086
 - Add our fork `candles_3d` as submodule. Closes #1088
 - Revert "lifetimer on for NPC" (Mobs not die; Gnomocide is possible again)
 - Add `:default:desert_gravel`
   - add Grinder recipes. Relates to 1082
   - add cooking `desert_gravel`. Relates to #1082
 - Add mason clan cloak

 - Technical:
   - MapGen: remove dead code. Relates to #1084, 1058
   - MapGen: rename vars. Relates to #1084
   - MapGen: remove `fimadep` (make code mo readable). Relates to #1084
   - MapGen: add measure gen time on lua-side. Relates to #1084
   - MapGen: simplify conditions; use constants. Relates to #1084
   - MapGen: extract `is_sand_layer()` detection. Relates to #1084
   - MapGen: add detection of beach & shallow water. Relates to #1084
   - Move our additional crafts `_overwrites/MTG/default` -> `lord_default`
   - Move `lottmapgen` -> `World/Generation/`. Relates to #1079, #969, #967
   - Move `mega_al` into `World`. Relates to #967, #969
   - Move `mountgen` into `World`. Relates to #967, #969
   - Move `lord_money` into `Tools`. Relates to #967, #968
   - Move `bones` into `Player`. Add `readme.md`. Relates to #967, #970

## [2023.06](https://github.com/lord-server/lord/releases/tag/2023.06)
 - Added mordor, desert & silver sand into map generation. Closes #1080
 - MapGen: add some mtg flowers to biomes & some grass. Closes #1083
   - `flowers:tulip_black` (new)
   - `flowers:chrysanthemum_green` (new)
   - `flowers:tulip`
   - `flowers:rose`
   - `flowers:viola`
   - `flowers:geranium`
   - `flowers:dandelion_white`
   - `flowers:dandelion_yellow`
 - Защищённая рамка. Closes #1050 (#1078)
 - Add `stainedglass` mod. Closes #835

 - Bug Fixing:
   - MapGet: remove `abandoned_fort` & `abandoned_tower` decorations. Closes #1081
   - Fix inventory preview with elven cloak. Closes #1085
   - Псевдо-рост растений без игрока (Добавление поля catch_up). Fixes #321 (#1070)
 - Technical:
   - Refactoring `lottmapgen`: extract `detect_current_biome()`. Relates to #1058, #1059
   - Refactoring `lottmapgen`: add biome constants. Relates to #1059
   - MapGen: Simplify code of grass caverage gen. Relates to #1059, #1058
   - Rename shadowing var. Relates to #1059, #1058
   - MapGen: Simplify code of "air" biome generation (flora, buildings). Relates to #1059, #1058
   - MapGen: `biome_fill_air()`: remove up-value dependency. Relates to #1059, #1058
   - MapGen: bring out flora/builings config & gen func `biome_fill_air()`. Relates to #1059, #1058
   - MapGen: add measure chunk gen time. Relates to #1059, #1058
   - MapGen: replace func names with locals. Relates to #1059
   - MapGen: bring out config & id vars from gen callback. Relates to #1059, #1058
   - MapGen: reduce vars quantity. Relates to #1059
   - MapGen: extract config; remove unused global. Relates to #1059
   - MapGen: just reformat. Relates to #1059
   - MapGen: extract functions (improve readability, reduce cyclomatic complexity). Relates to #1059, #1058
   - MapGen: use constants for biome detection. Relates to #1059
   - Remove commented deletion silver nodes, since added to mapgen. Relates to #1080

## [2023.05.p2](https://github.com/lord-server/lord/releases/tag/2023.05.p2)
 - Forgotten fix from prod. Difficult to reproduce fatal. Was found & fixed on prod. (#1067)
 - Now you can't dig not empty extractor. Fixes #1072 (#1074)
 - Fix mountain generation form. Fixes #1010 (#1075)
 - Книгу достижений теперь можно вставить в рамку. Fixes #1069. (#1076)
 - Исправление краша из-за формы сумок (fix 1066) (#1068)

## [2023.05.p1](https://github.com/lord-server/lord/releases/tag/2023.05.p1)
 -  Fix crash on login with wrong armor in slots. Closes #1060. (#1061)

## [2023.05](https://github.com/lord-server/lord/releases/tag/2023.05)
 - Add `/l` command as `/list` alias.
 - Add stairs & slabs for `lottblocks:snowycobble`. Closes #840.
 - Add Mordor Brick, Orc Stone, change crafts and textures. Closes #999. (#1045)
 - Add junglewood banister (new inv icon needed). Relates to #1048
 - Add mod lord_bricks, add 2 types of bricks (and their crafts). Closes #995. (#1002)
 - Increase achievements form height. Closes #340
 - Textures:
   - Новая текстура мраморного кирпича (#965)
   - Новые текстуры колец (#1035)
   - New textures for books (#1041)
   - Desert stone blocks textures fix (#1042)
   - Change default brick texture (#1056)
 - Bug Fixing:
   - Closes #980. Fix fences connection. Add hardwood fences (#981)
   - Closes #1003. Fix incorrectly referenced hardwood fence texture (#1004)
   - Исправление Ствол яблони в рамке не на русском (#1009)
   - Исправление переноса строки в книге палантиров (#1023)
   - Исправление механизма приручения (#1026) fixes #915
   - Fix corpse annihilation. Fixes #1027
   - Исправление целевой ноды достижения Тормоз! (fixes #1033) (#1036)
   - Исправление названий текстур в иконках достижений (#1037). Fixes #1031
   - Увеличенение радиуса опадения листвы ольхи с 2 до 3. Fixes #1001 (#1044)
   - Fir wood slab translation. Fixes #978
   - remove `legacy:dirt` node, add alias. Relates to #248
      - remove legacy `lottnpc:rohan_guard_spawner`. Closes #248
      - Fix removing `default:dirt` after fixing `legacy:dirt`. Relates to #248
   - Fix locked doors recieps & wooden locked door tranlation. Closes #1000
   - Closes #1052. Fix 'Raw Mordor Clay Block' grinder craft. Relates to #1002. (#1055)
   - Junglewood banister localization. Fixes #1053. Relates to #1048

 - Technical:
   - Experimental:
     - Lord bows _experimental. Relates to #76 (#700)
     - Увелечение скорости зарядки и полета стрелы (#982)
   - Builtin translations:
     - Переход на встроенные переводы `lottpotion` (#983)
     - Переход на встроенные переводы `mypos` (#991)
     - Переход на встроенные переводы `mail_list` (#990)
     - Переход на встроенные переводы `lottores` (#987)
     - Переход на встроенные переводы `lottfarming` (#986) Closes #949
     - Исправление template, добавление упущенных последних букв (#992). Relates to #987 (Переводы `lottores`)
     - Переводы: Исправление template, разбиение по файлам `lottpotion` (#993). Relates to #983
     - добавление localization template `bags` (#994)
     - Переход на встроенные переводы `lottclother` (#985) closes #948
     - Переход на встроенные переводы `lottother` (#988) closes #953
     - Переход на встроенные переводы `lottmobs` (#989) closes #951
     - Переход на встроенные переводы `bones` (#984) closes #328
     - Переход на встроенные переводы `lord_books` (#1022)
     - Переход на встроенные переводы `lottthrowing` (#1024) closes #955
     - Удаление захардкоженных переводов в lottachievements (fixes #1025) (#1030)
     - Переход на встроенные переводы `lottachievements` (#1032)
     - Исправление локализации реплики в `lottachievements` (#1014) (#1034)
   - Dev simplifying:
     - IDE hinting: add `ItemDefinition` & `NodeDefinition`
     - stale-bot: decrease `daysUntilStale`
     - IDE hinting: improve `InvRef`
     - IDE hinting: add `InvRef:get_location()`
     - LuaCheck: fully exclude `_minetest` & `_various`
     - IDE-helper: `ObjectRef.lua`
   - Refactoring:
     - Move `lottother` to `lord`. Relates to #871
     - Move `lottplants` into `lord`. Relates to #871.
     - Move `lottthrowing` into `lord`. Relates to #871.
     - #344: upd `lottfarming`: apply `paramtype2 = meshoptions`, `waving` & `light_source`
     - #344: upd `lottfarming`: add white maushroom
     - #344: upd `lottfarming`: use `barley_seed` naming insted `barley0`. Relates to #914
     - #344: upd `lottfarming`: use `corn_seed` naming instead `corn0`. Relates to #914.
     - #344: upd `lottfarming`: use `potato_seed` naming instead `half_of_potatoe`. Relates to #914.
     - #344: upd `lottfarming`: update couple textures
     - Move `lottfarming` into `lord`. Relates to #871
     - Decrease cyclomatic complexity in `bones`. Fixes #724
     - Decrease cyclomatic complexity in `defaults`. Fixes #725
     - move `lordlib` into `Core` folder
     - `Core/helpers`: add common `table` helpers
     - move `ru_lower_upper.lua` into `Core/helpers`; fix luacheck. relates to #922
     - `Core/helpers/string`: use locals, add doc-blocks. relates to #922
     - Use Core/helpers/table istead local functions. Closes #922
     - Decrease cyclomatic complexity in `lord_mail`. Closes #730
     - Decrease cyclomatic complexity in `mega_sl`. Closes #733
     - Remove: cmd , tabs command & privs. Closes #928
     - Refactoring `lord_info`: use common code for tabs. Relates to #927
     - Decrease cyclomatic complexity in `lord_info`. Relates #729
     - Decrease cyclomatic complexity in `lord_info`. Closes #729. Fixes #916
     - throwing: Remove unused self receiver on functions. Relates to #921 (#923)
     - Remove support of mods `inventory_plus`, `unified_inventory` & `inventory_enhanced`. Closes #754
     - Move bags into separate file. Relates to #934, #935
     - remove unnecessary debug logging
     - Drop `inventory_plus.set_inventory_formspec` usages in `lottinventory`. Separate form handlers. Main part of #930
     - Drop `inventory_plus` & usages in `lottarmor`&`lottclothing`. Closes #930
     - перенос заблудившегося кусочка кода в нужный обработчик формы сумок
     - Move files `lottinventory` -> `lord_books`. Relates #931
     - Rename `lottinventory` -> `lord_books`: items & files. Closes #931
     - Remove unused support of `player_textures` mod. Relates to #339
     - Add `Tools` aggregate folder; move mods in it. Relates to #967. Closes #968
     - `lottarmor`: remove `ethereal` & `moreores` support. Closes #972. Relates to #339.
     - `lottarmor`: remove configs support. Closes #973. Relates to #339.
     - `lottarmor`: remove unused vars. Closes #974. Relates to #339.
     - Use default form styles. Relates to #339
     - Extract inventory form into separate files. Closes #976   also decrease cyclomatic comlexity in detached armor inv. Relates to #732
     - Separate bags form from armor. Relates to #976 #339
     - Add `Player` aggregate folder; rename mod `player` -> `show_health`. Relates to #967, #970
     - `lottarmor`: extract wielded item into `appearance` mod. Closes #975
     - `lottarmor`: extract armor items into `lord_armor` mod. Closes #971
     - `lottarmor`: move inventory forms into `Player/lord_inventory`. Relates to #339. Closes #354.
     - `lottarmor`: move forgotten armor textures. Relates to #971, #339
     - `lottarmor`: move forgotten inventory textures. Relates to #354, #339.
     - move `lottclothes/clothing.lua` -> `lottarmor/clothing.lua`. Relates to #1015, #1016
     - `lottclothes`: move all items into `Tools`. Relates to #1015. Closes #1016
     - `lottarmor`: remove nonexistent button handler. Relates to #339, #1011
     - `lottarmor`: move `multiskin.lua` into `Player/appearance`. Relates to #339, #1011
     - move preview default into `appearance`. Relates to #339
     - `lottclothes`: extract detached inventory. Relates to #1015. Closes #1018
     - `lottclothes`: remove unused `clothing.textures`. Relates to #1015.
     - `lottclothes`: move clothes inv slots into `Player/lord_inventory`. Relates to #1015. Closes #1019.
     - move `death_handler` into `Player/`. Relates to #967, #970
     - `lord_inventory`: restructure files. Relates to #1020
     - `lord_inventory`: add `inventory.update()` API; class for inv main form. Relates to #1020
     - `Player/equipment`: API `for_player()::{get|set|delete}()` & `on_{change|set|delete}()`. Relates to #1021
     - Use `Player/equipment`(#1021). Relates to #1012, #1017
     - Refactoring `lottarmor`: move "shield" value of `armor.elements` into declaration. Relates to #339
     - `equipment.ForPlayer`: add `:clear(kind)`, `:items(kind)`, fix `:get()`. Closes #1021. Relates to #1012, #1017, #339
     - `equipment.ForPlayer`: add `:move_to(kind)`, `:items(kind)`, fix `:get()`. Relates to #1028, #1012, #1017, #339
     - Decrease armor/clothing/equipment dependencies. Relates to #339, #1012, #1017.
     - Add `equipment.Kind` & its registration. Relates to #1028
     - `equipment.Kind.register()`: Fix potential bug. Relates to #1028
     - `Player/equipment`: add `on_create` event. Relates to #1028
     - `Player/equipment`: add `on_load()` event. Relates to #1028.
     - `Player/equipment`: fix `Kind.register()`. Relates to #1028.
     - `Player/equipment`: fix `on_load()`. Relates to #1028
     - `Player/equipment`: fix passing `kind` for `Event` subscribers. Relates to #1028
     - Extract `Player/appearance` from armor & clothing. Relates to #1012 #1017
     - Refactoring: unify `equipment.on_load` callbacks for inventory. Relates to #1012, #1017
     - `Player/equipment`: add `on_load_all()` event. Relates to #1028.
     - `Player/appearance`: init armor & clothing on player join. Relates to #1012 #1017
     - Extract preview of armor & clothing into `Player/lord_inventory`. Relates to #1012 Closes #1017. Also fixes no clothing preview.
     - Refactoring `lottarmor`: remove unnecessary code. Relates to #339
     - Refactoring `lottarmor`: simplify `armor:set_player_armor()`. Relates to #339
     - Refactoring `lottarmor`: extract `collect_physics()`. Relates to #732, #339, #1012
     - Refactoring `lottarmor`: extract `rebuild_armor_groups()`. Relates to #732, #339, #1012
     - Refactoring `lottarmor`: simplify `handle_armor_wear`: extract `item_wear`. Closes #732. Relates to #339, #1012.
     - Refactoring `lottarmor`: use `equipment.on_load()`; remove delay. Relates to #339, #1012
     - create `Blocks` subfolder; move obvious mods. Closes #1049
     - create `World` subfolder; move obvious mods; change readme-s; Relates to #969, #967
     - Move some mods into `Blocks` folder. Relates to #1049
     - Move `lottachievements` into `lord/`. Relates to #671
     - Make human- & git- readable WE-schems
     - Hack-workaround of `on_take`, `on_put` call sequence. Closes #1029
     - Change deprecated `:get_entity_name()` -> `.name`. Relates to #1047
     - Change deprecated `:set_physics_override(num,num,num)` -> `.set_physics_override(table)`. Relates to #1047
     - Change hourly server message: add links
     - Move `lottmapgen` into `lord`. Closes #871
     - Fix nenya ring armor. Fixes #1054. Relates to #339


## [2022.12.p3](https://github.com/lord-server/lord/releases/tag/2022.12.p3)
 - Turn on forgotten initial stuff on PROD. Relates to #460, #826

## [2022.12.p2](https://github.com/lord-server/lord/releases/tag/2022.12.p2)
 - Fix infinite signs & fence_wood. Fixes #903.
 - Reward chest: fix infitite reward for not first player. Also fix congrats translation. Fixes #905.
 - Fix fir wood slab using pine wood texture. Fixes #906 (#907)
 - banisters: no consumption when place in node with another banister. Fixes #904
 - add MTG/keys as submodule. Fixes #910.
 - NPC Changer: fix player inventory position in form. Fixes #902.
 - Fix missing `silver_sandstone*` stairs & slabs. Fixes #909
 - Fix achivement popup form. Closes #658

## [2022.12.p1](https://github.com/lord-server/lord/releases/tag/2022.12.p1)
 - Исправлено появление неизвестных нод вместо листьев деревьев (#901)

## [2022.12](https://github.com/lord-server/lord/releases/tag/2022.12)
 - Добавлена новогодняя ёлка (#887)
 - Добавлены стеклянные соединяющиеся панели (+ из обсидианового стекла) (related to #835) (#837)
 - Добавлены каменные ограды из булыжника, замшелого булыжника и пустынного булыжника (related to #838) (#841)
 - На арене Барлогов теперь тоже показывается здоровье игрока (Настройка арен, на которых показывается здоровье игрока (#529))
 - Добавлены Месе светильники-столбики из яблони и эвкалипта (#885)
 - Добавлен сундук с наградой за прохождение квеста (для администраторского использования) #755 (#897)
 - Новый игрок получает небольшой инвентарь для старта. Closes #460 (#826)
 - Текстуры:
   - Новые текстуры для пшеницы(#810), хлопка (#811), ягод (#812)
   - Новые текстуры для HUD'а (#818)
 - Update MTG mods to `5.6.1`. Closes #848 (#866)
   - Сбалансирована громкость некоторых звуков, убран бесшумный вариант хождения по воде
   - Ключики стекаются, если имеют одинаковый "secret"
   - Вагонетки: исправления в движении
   - Исправление звуков печи
   - Улучшено первоначально положение ступенек при установке
   - Добавлены звуки открытия/закрытия в API дверей
   - Добавлены и исправлены переводы на разных языках
   - Множество других исправлений и фиксов
 - Разблокированы для администраторского использования silver_sand, blueberry (#885)
 - Исправления:
    - Замена дверей в схеме хоббитской норы (#806) Fixes #798
    - Исправлена прозрачность окна в Гондорской двери. (fixes #804) (#808)
    - Книгами больше нельзя драться и добывать. fixes #800 (#820)
    - Из формы настройки привата теперь можно выйти по `escape`. fixes #524 (#821)
    - Исправление поджигания блока угля факелом. Добавлена подсказка Fixes #697, fixes #560 (#825)
    - Исправление дверей в эльфийского дерева в Лихолесье (#882). Fixes #881
    - Исправление неизвестных пьедесталов Fixes #878. (#883)
    - Исправление ошибки с ростом и выпаданием сажецев. Remove 'default:junglesapling', use 'lottplants:mirksapling' instead. Closes #894 (#898)
 - Системное:
   - Deprecations:
     - Replace deprecated `vel` and `acc` attributes in bees. Fixes #828 (#834)
     - Fixes #853. Define use_texture_alpha for protector sign (set to clip) (#861)
     - Fixes #849. In game.conf: deprecated 'name' -> 'title'
     - Fixes #842. Replace deprecated get_mapgen_params -> get_mapgen_setting
   - Remove empty file creation hack in signs_lib (#816)
   - Replace deprecated calls with new ones (#819)
   - include MT configs from servers into repo
   - cleanup, reorganize & double-check MT configs for servers
   - just refactoring `skybox` mod. (for #829)
   - send sky changes to client only if needed. relates to #829
   - #267 Update MTG/default: move mapgen into overwrites. Closes #855
   - #267 Update MTG/default: upd mapgen from MTG 5.4.1
   - #268 #831 Remove creative mod. Closes #831 (#858)
   - Remove `default.creative` and its usages. Closes #857 (#859)
   - fix `mods/_minetest_game/readme.md`
   - #257 Update MTG/default: init.lua: move legacy `default.gui_*`
   - #257 Update MTG/default: init.lua: small sync code
   - #267 Update MTG/default: init.lua: move legacy `default.gui_*`. Closes #267 (#860)
   - Add `MTG/default` as submoudule. Closes #601 (#862)
   - Fixes #850. Fixes #851. mobs_fish, painting: depends.txt and description.txt -> mod.conf
   - Fixes #852. Doors: fix warning 'Not registering alias' for door_steel
   - Fixes #854. lottmapgen/functions.lua: declare local variable 'j'
   - Move `lottblocks` to `lord`. Relates to #871
   - Move `lottinventory` to `lord`. Relates to #871
   - Move `lottmobs` to `lord`. Relates to #871
   - Update configs from 5.6.1. Closes #874
   - update `mywalls` from upstream: fix mtg/walls translations (relates to #843)
   - Move `lottores` into `lord`. Relates to #871
   - add Code-Style rule for var names & empty lines
   - IDE hinting:
     - add `AreaStore:*` and almost all `minetest.*` methods
     - add `Player` methods
     - extract several classes into separate files
     - add MetaDataRef & all it inheritors
     - add ObjectRef & inheritors

## [2022.10.p3](https://github.com/lord-server/lord/releases/tag/2022.10.p3)
 - Fixes #873. Replace registered_player -> minetest.player_exists (#875)
 - Fixes 799. Check if item is registered, if it's not, return nil (#876)

## [2022.10.p2](https://github.com/lord-server/lord/releases/tag/2022.10.p2)
 - Fixes #865. Slightly renew nickname filter algorithm (#870)

## [2022.10.p1](https://github.com/lord-server/lord/releases/tag/2022.10.p1)
 - Исправлены бесконечные стаки дерева (#813, #814)

## [2022.10](https://github.com/lord-server/lord/releases/tag/2022.10)
 - Добавлены призрачные блоки для шерсти (#576, #737)
 - Добавлены плиты из стволов деревьев (#698, #739, #757, #765, #766)
 - Добавлены расширенные подсказки в описаниях в инвентаре, книжках и др формах (#589)
   Сейчас отображается:
   - Урон для топоров, мечей, кинжалов и др. оружия
   - Свечение для факелов, свеч и др. излучающих нод
   - Макс. урон для стрел и метательных топоров
 - Добавлены овцы и возможность стричь их (#769)
 - При обновлении Lottblocks добавлены (#771, #342):
   - Сундук гномов
   - Мифриловая лампа
   - Гонг
 - Добавлен штандарт Шира. (#358, #781)
 - Добавлены расовые двери (#789)
 - Добавлен урон от воды Мордора (#771, #342)
 - Добавлено "Ведро с водой Мордора" (#771, #342)
 - Исправления/доработки:
   - Исправление автоматического срубания дерева. (#756, #758)
   - Исправление дна расовых сундуков (#791)
   - Теперь после выпивания зелья остаётся бутылка (fixes #100) (#761)
   - Добавлены боковые текстуры люков из тех же пород дерева (#792)
 - Рефакторинг/системное:
   - Removed ping mod (#746)
   - Moved overwriting strings.lower, upper to lordlib mod (#745)
   - Moved palantiri storage from text file to mod meta (fixes #751) (#753)
   - Moved lottpotion from _lott/ to lord/ :building_construction: (#718) resolves #715
   - Add core_callbacks (#699)
   - stale-bot: decrease days until stale
   - Unify debug tools (#747)
   - Updated ambience with submodule (fixes #161)
   - #267 Update MTG/default: insignificant changes (#763)
   - Lottblocks update (#771) closes #342
   - Beautify README (#775)
   - Lottblocks i18n: Migration to built-in translation system (#776) Resolves #772
   - Add basic definitions for built-in functions and tables (#778)
   - EditorConfig: same rules as \`*.lua\` for \`.luacheckrc\`
   - MTG/doors update (#708)
   - CI: Deploy WFs: add `--recurse-submodules` to fix deploy
   - Implemented races.can_open_stuff (#787)
   - Рефакторинг `defaults:` (#790)
   - lottmapgen_update: refactoring chest spawners
   - lottmapgen_update: removed mythical fog
   - lottplants_update: moved overwrites to correct place
   - lottmapgen_update: changed localization to built-in
   - Switch some MTG mods to submodules. Relates to #601. All switched mods from 5.4.1 commit (42baede):
     - beds - downgrade to 5.4.1 (removed: check player attached, locale/beds.eo.tr)
     - bucket
     - carts
     - doors
     - dye
     - farming
     - fire
     - downgrade to 5.4.1 (locale/fire.eo.tr deleted)
     - flowers
     - player_api
     - screwdriver
     - sethome
     - sfinv
     - stairs
     - vessels
     - wool
   - correct GH-actions for work with submodules
   - CI: increase `actions/checkout` `fetch-depth` (fix build)

## [2022.08.p3](https://github.com/lord-server/lord/releases/tag/2022.08.p3)
 - Added green marble stairs and slabs (fixes #762) (#764)

## [2022.08.p2](https://github.com/lord-server/lord/releases/tag/2022.08.p2)
 - Исправлено падение сервера при разрушении трупа
 - Исправлен перевод блока льда

## [2022.08.p1](https://github.com/lord-server/lord/releases/tag/2022.08.p1)
 - Исправление исчезнувших ступенек сена (#742) fixes #741.

## [2022.08](https://github.com/lord-server/lord/releases/tag/2022.08)
 - добавлены серебряные, стальные и оловянные лампы (#548);
 - заменена текстура берёзы (#692);
 - орочья еда больше не вредит оркам (fixes #656) (#681);
 - новые реечные заборы (#602 и #706);
 - lord bees (#623):
   - добавлен блок воска
   - добавлен блок медовых сот
   - добавлены фоны диалоговых окон ульев и центрифуги
   - обновлены текстуры центрифуги
   - имитация вылета пчёл из ульев (вылетают только при наличии матки)
 - добавлены блоки мрамора (#574):
   - Marble with gold
   - Marble with gems
 - Исправление ошибок:
   - исправлен баг с запятыми в имени палантира (fixes #189) (#668);
   - исправлено неправильное покачивание (waving) листвы (fixes #660) (#673);
   - отмычка больше не расходует ресурс в creative #170 (#666 😈)
   - удален несуществующий в мире `default:bush_leaves` (fixes #650) (#684);
   - исправлен баг с негаснущими под водой факелами (fixes #551) (#693);
 - Администраторские:
   - команда `/list`:
     - добавлен поиск по minetest'овской локализации (fixes #419) (#669);
     - реализован поиск по нажатию Enter;
     - переработка и чистка кода;
     - призрачные ноды перенесены в конец списка;
   - убрана возможность выкинуть админский жезл (fixes #367) (#647)
   - призрачные ноды убраны из меню креатива
 - Рефакторинг/системные:
   - переработка "расовых" сундуков (#666 😈);
   - обновление lottplants (fixes #350) (#328);
   - небольшая переработка lord_money (#652)
   - переработка lord_boats (fixes #535) (#615);
   - реализована вспомогательная функция lord.give_or_drop (fixes #597) (#675);
   - реализована вспомогательная функция `lord.each_value_equals` (fixes #688) (#689);
   - `mega_sl` теперь использует mod security (fixes #594) (#695);
   - чистка устаревших depends.txt и других предупреждений (#614 и #712);
 - Экспериментальные:
   - добавлен инструмент lord_replacer (#713 и #720)

## [2022.07.p3](https://github.com/lord-server/lord/releases/tag/2022.07.p3)
 - Fix iron chest craft with default:chest (fixes #690) (#691)

## [2022.07.p2](https://github.com/lord-server/lord/releases/tag/2022.07.p2)
 - Fix leaf decay with using default.register_leafdecay (fixes #662) (#677)
 - Fix bug with endless rails (fixes #627) (#672)
 - Fix papyrus growth (fixes #670) (#671)

## [2022.07.p1](https://github.com/lord-server/lord/releases/tag/2022.07.p1)
 - Enable tree decay on both types of trunks (#657)

## [2022.07](https://github.com/lord-server/lord/releases/tag/2022.07)
 - Добавлен новый блок: зелёный мрамор. Доступен только на официальных прилавках (#571)
 - Новая иконка игры L.O.R.D. #518 (#604)
 - Обновление текстур:
   - Брусчатки (#567)
   - Кристалов и драг. камней (#577)
   - Руд в инвентаре (#570)
   - Бумаги, бумаги с текстом, лицензии магазина (#618)
 - Обновления модов:
   - `MTG/flowers` #278 (#488)
   - `MTG/carts` #273 (#531) + #642 (#645)
   - `MTG/sethome` #573 (#580)
   - `MTG/default`: upd nodes.lua, functions.lua & trees.lua #267 (#563) + #631 (#632) + #636 (#644)
   - `MTG/farming` #276 (#453) + #630 (#655, #643)
   - Добавлен `MTG/sfinv` #634 (#635)
 - Исправление ошибок:
   - Восстановлен декоративный кактус #488 (#566)
   - Fix Mount-gen fill: Place dirt where air or plantlike #607 (#608)
   - Fix warnings in logs #362 (#612)
   - Доработка работы формы рабочего стола (#622)
   - `lottmobs`: add previously skipped tnt texture. fix (#372) (#616)
   - Fix crash when player leaves after drinking wine (fixes #291) (#649)
   - Fix sound & textures for ice. Closes #626 (#633)
   - Use `default.chest.get_chest_formspec()` in LOTT chests (fixes #653) (#654)
 - А также:
   - Removing temporary changes in `MTG/stairs`. Fixes #510 (#603)
   - Add nodes_dump as a submodule #588 (Closes  #586)
   - New PR template (#638, #639, #641)
   - Move luacheck from Travis CI to GitHub Actions (fixes #526) (#648)


## [2022.02.p4](https://github.com/lord-server/lord/releases/tag/2022.02.p4)
 - Check nodes for their existence in areas (#617)

## [2022.02.p3](https://github.com/lord-server/lord/releases/tag/2022.02.p3)
 - New coal and charcoal textures (#591)
 - Classic textures (#592)
 - marble texture (#593)
 - Fixes mountain tool (#537, Closes #425)
 - Update mount tool (#606, relates to #547)

## [2022.02.p2](https://github.com/lord-server/lord/releases/tag/2022.02.p2)
 - Fix LuaCheck build. (Fixes #578)
 - Fix pearl transparency #559 (#579)
 - Fix crosshair.png symmetry. Add object_crosshair.png (#581)
 - Fix wooden axe #461 (#583)
 - Add Diamond Block stairs & slabs #437 (#584)
 - Fix new player hunger #383 (#585)

## [2022.02.p1](https://github.com/lord-server/lord/releases/tag/2022.02.p1)
 - Исправления багов:
   - Check that mob is not nil when punch #555 (#556)
   - Fix arrow collision calculation #542 (#545)
 - Релизный процесс:
   - Always switch back to master on deploy
   - Reconfigure ci: `dev` branch to polygon; version tags to prod & tags can have patch segment
   - reconfigure ci: add merge master to dev on deploy to prod; add release description
 - Перенос модов с сервера в репозиторий (#305)
   - Copy mod `skybox` from prod server. Relates to #305.
   - Copy mod `arena` from prod server. Relates to #305
   - Copy mod `alarm` from prod server. Relates to #305
   - Copy mod `painting` from prod server. Relates to #305
   - Copy mod `ping` from prod server. Relates #305
   - Copy mod `server_message` from prom server. Relates to #305
   - Copy mod `ambience` from prod server. Relates to #305
   - Copy mod `lists` from prod server. Relates to #305
   - Copy mod `mail_list` from prod server. Relates to #305
   - Copy mod `mobs_fish` from prod server. Relates to #305
   - Copy mod `mypos` from prod server. Relates to #305
   - Copy mod `sethome` from prod server. Relates to #305

## [2022.02](https://github.com/lord-server/lord/releases/tag/2022.02)
 - Обновлён мод `MTG/beds`. Исправлен #312 сброс скорости после сна (#429)
 - Обновлён мод `MTG/vessels` #281 (#506)
 - Обновлён мод `MTG/dye` #275 (#507)
 - Обновлён мод `MTG/wool` #281 (#509)
 - Обновлён мод `MTG/screwdriver` #280 (#516)
 - Обновлён мод `MTG/player_api` #279 (#528)
 - Обновление и перенос мода `MTG/boats` в `lord/lord_boats` #270 (#534)
 - Частично обновлён мод `MTG/default` #267:
   - удалены дублирующие ступеньки и плиты из `pine_wood`
   - добавлен блок из песчаника `sandstone_block` (добавлены, но пока не доступны `desert_sandstone`, `desert_sandstone_brick`, `desert_sandstone_block`)
   - добавлена mese-лампа `meselamp`
   - добавлены обсидиановые кирпич `obsidianbrick` и блок `obsidian_block`
   - добавлен каменный блок `stone_block` (добавлен, но пока не доступн `desert_stone_block`)
   - add `default:large_cactus_seedling` & grow funcs, move `default:dirt` recipe
   - добавлено изготовление камня `default:stone` из замшелого булыжника `default:mossycobble` и пустынного камня `default:desert_stone` из пустынного булыжника `default:desert_cobble`
   - перебалансировка топлива:
     - из разных стволов деревьев (стволы разных пород горят разное время)
     - из разных досок
     - из разных саженцев
     - из разных заборов
     - и некоторых других вещей
   - добавлены, не пока недоступны сухая трава `dry_grass_#`, папоротник `fern_#`, песчаный тростник `marram_grass_#`
 - Добавлены переводы для inner & outer stairs #508 (#511)
 - Добавлен инструмент для построения графа зависимостей модов dependency graph (#363)
 - Исправление кроватей в данжах #500 (#502)
 - Исправление расположения текстур #432 (#494)
 - Исправлена бесплатная починка в магазинах `lord_money` #512 (#536)
 - Исправлен краш при смерти моба #538 (#539)
 - Исправлен краш при выстреле амбразуры #540 (#541)
 - Исправлено падение при поиске в книгах крафта #497 (#496, #544)
 - Перенесён мод `bones` из MTG в lord. Fixes #271 (#486)
 - Перенесено всё, что относится к `charcoal` в наш внутренний мод `lord_default`. (требуется для #267) (#491)
 - Переход на minetest `5.4.1`:
   - Исправления по устаревшему API #499, #498, #286, #285, #505, #409 (#501, #503, #412, #549)
 - Hotfix: Fix screwdriver #554

## [2021.11](https://github.com/lord-server/lord/releases/tag/2021.11)
 - Добавлены новые блоки для дорог с бордюром (#381)
 - Добавлены новые лампы в золотой и бронзовой окантовке (#465)
 - Добавлено отображение цены и товара у менялы (#450)
 - Добавлена `is_creative_enabled` для дальнейшего перехода на 5.4. Во избежание #438
 - Ранее встроенный в `MTG/fire` мод `campfire` вынесен в отдельный мод. (Closes #455)
 - Обновлён `MTG/fire`. (Closes #277)
 - Обновлён `MTG/bucket`. (Closes #272)
 - Удалён неиспользуемый мусор: `lord.mod_loaded`, `lord.load`, `lordlib/signals.lua` (`lord.emit`, `lord.on`) (#475)
 - Добавлена информация о contributor'ах и инфа о code-style
 - Исправление отображения текста на табличках (таблички требуется переустановить)
 - Исправление падения при прожигании неизвестной ноды (#436)
 - Исправление бага с менялой (Fixes #413)
 - Quick-fix при обновлении `MTG/fire`: удалён звук для синего пламени (#480)

## [2021.09](https://github.com/lord-server/lord/releases/tag/2021.09)
 - Обновление мода `lottclothes` из LoTT (последнее)
 - Перенос `lottclothes` в папку `lord`
 - Обновлена модель: теперь отображается одежда
 - Отображение скина в инвентаре (#338)
 - Исправление отображения скина при первоначальном выборе расы новым игроком (отображается тень) (#398)
 - Добавлен админский магазин (#314)
 - Игрокам Оркам стало легче жить и добывать в шахтах: гномы теперь не спаунятся при оркских факелах, но спаунятся оркри, тролли и пауки (#360)
 - Обновлены текстуры слитков
 - Конфигуратор для горного посоха (#396)
 - Ускорение работы горного посоха (#424)
 - Добавлены новые блоки для Полосатого гномьего камня: с одной полосой и с двумя на одной плоскости
 - Подготовка к обновлению сервера: Переход на встроенную систему переводов MT в папке `lord` (#367) (#328)
 - Исправление падения сервера при входе в "Справку" (#393)
 - Исправление поиска на русском для встроенной системы переводов MT

## [2021.08](https://github.com/lord-server/lord/releases/tag/2021.08)
 - Доработки для дальнейшего перехлда на версию 5.3
 - Явное разделение стандартных, наших и сторонних модов и добавлено описание
 - Обновление `MTG/stairs`
 - Добавлено описание `development.md` для разработчиков с минимальными инструкциями
 - Исправлен баг в установке areas
 - Обновление `lottpotion` из LOTT. Relates to #288
 - Исправление стрел с зельями #288 #289
 - Исправлена ошибка #264 'Unknown node: `lottblocks:dwarf_bottom`'
 - Набросок тулзы для создания гор (пока не используем) (#293) beta version
 - Появился админский доступ к магазинам
 - Исправление полёта стрел (#292 #299 #300)
 - Добавлено отображение HP на Арене (ID=2316) (#301)
 - Мод `spawn` добавлен в основной репозиторий на GH
 - Добавлена команда `/death` и унифицирован механизм спаунов (#309 #327 #369)
 - Добавлен инфо-моб и моб-меняла (#307 #306 #334 #333)
 - Настраиваимый спаун для разных рас #311
 - Обновление мода `MTG/default`: текстуры, звуки, модельки, переводы, вынесены наши изменнеия; у сундуков поднимается крышка и многое другое
 - Исправлена высота посадки на лошадь
 - Обновление `lottarmor` из lott и вынесение в папку `lord`
 - Улучшение Барлога: увеличина скорость fireball'а, не поражают друг друга
 - Добавлена команда `/dice` - выдаёт случайное число
 - Хоббиты получают урон на земле мордора. Closes #310
 - На Тень теперь не наподают мобы

## [2021.01](https://github.com/lord-server/lord/releases/tag/2021.01)
 - Обновлено API игрока
 - Исправлены модели мобов
 - Улучшения кактуса и тростника (можно рубить нижний, верхние срубаются автоматически)
 - Обновлён мод stairs: добавлены угловые блоки, теперь [можно так](https://github.com/lord-server/lord/issues/253).
 - Добавлены скрипты авто выкладки на тестовый и боевой сервера
 - Исправлены ошибки с отсутствующими текстурами (добавлены из minetest_game)

## [2020.04](https://github.com/lord-server/lord/releases/tag/2020.04)
- Исправления: Перевод на новый API игрока из Minetest 5.x DefaultGame
- Исправлена опечатка: "Заменитель мордерского камня" -> "Заменитель мордорского камня"

## [2019.12](https://github.com/lord-server/lord/releases/tag/2019.12)
 - Обновлён мод `carts`: ЖД звуки, повороты на развилках
 - Добавлены участники проекта в `readme.md`
 - Исправлена ошибка #250: в книгах крафта при повторном поиске не сбрасывалась страница
 - Исправлена ошибка: падение при первом открытии книги доспехов
 - Добавлена секция `Contributing / Помощь проекту` в `readme.md`
 - Для NPC включен таймер жизни
 - Добавлена Ель
 - Добавлен Навес
 - Добавлены Стойки
 - Обновлены тележки

## [2019.11](https://github.com/lord-server/lord/releases/tag/2019.11)
 - Добавлены ступеньки и плиты для стекла
 - Поиск в книгах "Основы крафта" и "Все рецепты"
 - Добавлена поддержка "фракций" (Если вы орк, вас атакуют люди, эльфы и пр.; если вы человек или эльф, то вас атакую орки, варги и пр.)
 - Изменена текстура мордорского камня
 - Исправлены белые мобы
 - В `readme.md` добавлены секции: о сервере L.O.R.D.; список `contributors` с ролями; секция `Contributing` о том как помочь проекту
 - Добавлены шаблоны для описания ошибки (bug'а) и для описания идеи (feature request)
 - Исправлена загрузка настроек creative_mode (подгружаем только один раз)

## [2019.10](https://github.com/lord-server/lord/releases/tag/2019.10)
 - Правки модели игрока под версию 5.*
 - Правки моделек мобов под версию 5.*
 - Правки HUD под версию 5.*
 - Индикация здоровья мобов
 - Уничтожение мобов со здоровьем меньше 0
 - Обновление `chatcommands` из нового LOTT

## [2019.01](https://github.com/lord-server/lord/releases/tag/2019.01)
 - Появились котята и мышата
 - Появились орки-лучники
 - Изменились текстуры топоров и крекера
 - Добавлены звуки металла
 - Исправлена цена у тогрговцев
 - Исправление работы печей и дробилки
 - Исправления в сталактитах
 - Исправлено отображение превью кольца воды в инвентаре
 - Исправление установки ствола дерева на пьедестал
 - Хот-фикс с боевого: проверка сети палантира
 - Переписан движок стрельбы/метания
 - Арбалеты, луки и пр. перенесено на новый движок
 - Рефакторинг использования кеша в расах
 - Рефакторинг дробилки
 - Использование функций для звуков металла и гравия
 - Удаление лишних алиасов, лишнего кода, лишних крафт схем, текстур
 - Исправления опечаток в названиях блоков и предметов (бутыльки)
 - Добавлена интеграция с Travis для прогона LuaCheck
 - Вычищен код по всем замечаниям от LuaCheck
 - Убрано использование устаревшей `intllib.Getter()`
 - Добавлена иконка к игре
