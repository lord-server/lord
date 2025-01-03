# Change Log

## [2024.12](https://github.com/lord-server/lord/releases/tag/2024.12)
 - Artisan Benches: Anvil: racial items can be crafted only by player of the same race. Closes #1852
 - Update book tooltip with book title on book use

 - Exterior:
   - add vase with handles. Relates to 1870
   - add vase without handles. Closes #1870

 - New bow and throwing system - Lord Archery:
   - Add new throwing engine:
     - Damage is based on projectile speed and base damage
     - Projectile speed differs with the bow and crossbow
     - Projectiles to shoot are detected in all of player's main inventory
   - New throwing axes (steel, bronze, galvorn, mithril):
     - Hold RMB or touchscreen to charge
     - Release to throw
   - New bows:
     - Hold RMB or touchscreen to charge
     - Release to shoot
   - New crossbows:
     - Hold RMB or touchscreen to charge
     - Release won't trigger shooting
     - When fully charged click RMB or short-hold touchscreen to shoot
   - New arrows:
     - Flint Arrow
     - Bronze Arrow
     - Galvorn Arrow
   - New bolts:
     - Bronze Bolt
     - Galvorn Bolt
   - New sound effects for projectiles, bows and crossbows
   - Mobs are now using new projectiles, bows and crossbows
   - Balrog, Nazgul and Witch King projectiles:
     - explode on collision
     - Balrog projectile deals fire damage on player or entity hit
     - Nazgul and Witch King projectiles deal soul damage on player or entity hit

 - Textures:
   - Change palantir texture. Update model uv. Closes #795
   - Update tools textures (closes #1877)

 - Technical:
   - Remove `lord_bows` mod.
   - Remove mods: Arrows, Throwing, Lottthrowing (closes #921)
   - Turn off deployments. (for new server move)
   - Craft System: ability to know recipe while `minetest.get_craft_result()`. Relates to #1852
   - Add races names constants. Relates to #1852
   - Translations: `protector_lott`. Related to #328 (#1871)
   - Lord Archery: Base: extract mods from branch (it was PR #1772 in `dev`). Relates to #1773
   - Lord Archery: Mobs-archers: add hitter:is_player() check
   - Lord Archery: Changed Processing, so a projectile is taken before charging
   - Lord Archery: Archery item (bow or crossbow) now preserves a loaded projectile
   - Lord Archery: Changed speed and damage calculation formulas so it makes more sense
   - Lord Archery: Add 3 stages for crossbows (closes  #1862)
   - Lord Archery: Move api for (cross-)bow registration to archery
   - Lord Archery: Add bows and crossbows (closes #1861, #1858)
   - Lord Archery: Move the archery mods out of _experimental (closes  #1774, #1775)
   - Lord Archery: Added stable support for Throwable (closes #1866)
   - Lord Archery: Add new throwing axes (closes #1867, #1868)
   - Lord Archery: Move all arrows, bows etc. to the new archery engine (closes #1523, #1863)
   - Lord Archery: Mobs are now using new archery engine
   - Lord Archery: Fire ball and dark ball now explode on collision
   - Lord Archery: Add crafts
   - Lord Archery: Mobs are now aggroed on hit (closes #1874)
   - Lord Archery: Add localization

## [2024.11.p2](https://github.com/lord-server/lord/releases/tag/2024.11.p3)
 - New Year textures for chests. Closes #1827
 - Add a chatcommand to teleport to event area (#1880)

## [2024.11.p2](https://github.com/lord-server/lord/releases/tag/2024.11.p2)
 - Orc medicine: add `selection_box`, `groups`, `sounds`, description & not `walkable`. Closes #1848. Closes #1849
 - Melee weapon: change attack distance (`range`). Closes #1841
 - Update extractor form every LBM. Closes #1851

## [2024.11.p1](https://github.com/lord-server/lord/releases/tag/2024.11.p1)
 - Add Dwarves Spawn into prod conf.
 - Vessels: Pint: add groups for dig node. Closes #1838
 - Merge branch 'dev'
 - Vesseld: Bowl: fix crafting. Fixes #1846
 - Make Orc Medicine glass similar to alcohol. Relates to #1836
 - Переименовать "Limpё" в "Лимпэ" · Issue #1839 · lord-server/lord (#1847)

## [2024.11](https://github.com/lord-server/lord/releases/tag/2024.11)
 - Increase Hobbit Dagger usages. Fixes #1724
 - Forms: Palantiri Guide: channge form. Closes #1727
 - Candles: update from our fork. Closes #1092. Closes #1729
 - Changing salt to salt_block as product of water bucket
 - Salt crafting solved via bottle_with_water -> bottle_with_salt -> salt. Closes #1792 (#1804)
 - Adding stone spear to newcomers' inventories. Closes #1810
 - Tooltips:
   - add Durability info. Relates to #1602
 - Interior:
   - add `vessels:shelf`. Closes #1754
   - add wooden Pint. Closes #1244
   - ability to put small flower pot in world. Closes #1246
   - add 6 plates/bowls randomly placed by the `Bowl` item. Closes #1243
   - ability to place glasses. Closes #1760
   - redraw glass & all items "liquid in glass" (alcohol). Closes #1759
   - add sounds for alcohol glasses. Relates to #1760
 - Exterior:
   - `steel_bottle`: use model, change texturese; rename to Steel Can. Closes #1755
   - `steel_bottle`/`can`: no walk through the Can. Relates to #1755
 - New Potions:
   - New Ones:
     - Elixir of Athelas
     - Orcish Brew
     - Ent Draught
     - Shelob's Bonds
     - Miruvor
     - Dol Guldur's Fetters
     - Limpë
     - Breath of Morgoth
   - add full descriptions. Relates to 1731
   - add nice tooltips & snippet for potions. Closes #1731
   - Remove potion arrows -- convert them into potions. Relates #717, #1736
   - reconfigure effects, powers & times. Closes #1732
   - add groups for potion effects. -- true effect apply & neutralization. Closes #1821
   - reset all effects on player leave or die. Closes #1832. Closes #1833
 - Sounds: Mobs: Racial: add for Nazgul. Closes #1745
 - Economics: balance dwarven ring. Closes #1801
 - Artisan Benches:
   - Workbench:
     - correcting form background. Closes #1743
     - remake model & texture. Closes #1740
     - 3d-model: Workbench: new one. Closes #1781
   - Grinder, Laboratory & Barrel now works on timers
 - Add ability to see content of `mail_chest` for admins. Closes #1776
 - Forms: General Styles: remove `listcolors` in all project forms. Closes #1738
   - now tooltips in all forms looks identically (semi-transparent bg, same colors)

 - Textures:
   - Change clan chest textures. Closes #1742
   - Armor:
     - update for inventory & previews. Optimize all. Closes #1828
   - Alcohol: improve inventory image. Relates to #1759

 - Bug Fixing:
   - Store meta data of items when sort chest content. Fixes #1711
   - Fix translation of pine trunks. Fixes #1689
   - Use new names for grass textures in achievements. Fixes #1646
   - Add plums as leaf into `leafdecay`. Now the plums are falling. Fixes #1330
   - Fix mordor water transparence. Closes #1239
   - Fix Grinder fool with fuel. Closes #1784
   - Solving white mushroom spore problem. Closes #1799 (#1800)

 - Technical:
   - Forms: General: add styled textarea helpers. Closes #1728
   - `ide-helper`: improve `ItemDefinition` class docs.
   - Refactoring: `lottpotions`: sort textures in folders. Relates to #717
   - Tooltips: ability to specify custom `_tt_luminance` for tooltips. Relates to #1729
   - Effects Integration: `lord_potions`: experimetal version. Closes #1679
   - Effects Int: add `lord_potions` first version. Closes #1679
   - Optimize textures: for clan chest. Relates to #1742
   - Refactoring: `Core`: add `minetest.get_mod_translator()`. Closes #1753
   - Refactoring: `lottpotion`: extract `lord_vessels`; rewrite code. Closes #1750
   - Refactoring: `lottpotion`: extract alcohol. Part of #717. Closes #1751. Relates to #1759, #1760'
   - Refactoring: `lottpotions`: extract recipes system. Closes #1769. Relates to #717
   - Sounds: Mobs: Racial: Nazgul: fix distance, fix `animal`->`monster`. Relates to #1745
   - Refactoring: `lottpotion`: remove `effects` chat command. Relates to #717
   - Refactoring: `lottpotion`: extract `aka_api.lua`. Relates to #1771, #717
   - Refactoring: `lottpotion`: extract `potions.lua` itself. Relates to #1771, #717
   - Refactoring: `lottpotion`: extract handling functions into `aka_api`. Relates to #1771, #717
   - Refactoring: `lottpotion`: move `arrows.lua`. Relates to #1771, #717
   - Refactoring: `lottpotion`: aggregate `benches` files; extract `benches/helpers.lua`. Relates to #1771, #717
   - Refactoring: `lottpotion`: just rename files. Relates to #1771, #717
   - Refactoring: `lottpotion`: separate barrel recipes & nodes definition. Relates to #1771, #717
   - Refactoring: `lottpotion`: separate laboratory ingredients, recipes & nodes definition. Relates to #1771, #717
   - Effects Int: Potions: prepare potions aliases. Relates to #1736
   - Refactoring `lottpotion`: remove potion arrows; add aliases, prepare new aliases. Relates #717, #1736
   - Add mods: projectiles and lord_projectiles
   - Add helper functions for table class
   - PvP: Lord Bows: Base: add stub `archery` to dev, it needs for projectiles mods from #1772. Relates to #1773
   - Refactoring: `lottpotion`: reorder files move alcohol recipes int our mod. Closes #1771. Relates to #717
   - Refactoring: `lottpotion`: remove debug garbage. Relates #1771.
   - Refactoring: `lottpotion`: prettify caudron code; add top img for empty; make water transparent. Relates to #1752, #717
   - Refactoring: `lottpotion`: extract caudron into `lord_artisan_benches`. Relates to #1752, #717
   - Refactoring: `lottpotion`: extract barrel & laboratory into `lord_artisan_benches`. Relates to #1752, #717
   - Refactoring: `lottpotion`: decrease CC for laboratory. Relates to #1752, #943, #717
   - Refactoring: `lottpotion`: laboratory: extract ABM helpers. Relates to #1752, #943, #717
   - Refactoring: `lottpotion`: laboratory: extract ABM helpers. Relates to #1752, #943. Clases #717
   - Refactoring: `lottpotion`: move alcohol recipes into config. Relates to #1751
   - Refactoring: `lottpotion`: move localization of alcohol. Relates to #1751
   - Refactoring: `lottpotion`: move localization of barrel & laboratory. Relates to #1752, #717
   - Refactoring: `lottpotion`: move textures of barrel & laboratory. Relates to #1752, #717
   - [broken code] Refactoring: `lottpotion`: just move files to keep git-history & then add ingresients reg & config. Relates to #1752, #717
   - Effects Int: Potions: add ingredients for potions. Closes #1779
   - Effects Int: Potions: prepare aliases for ingredients. Relates to #1736
   - ide-helper: add `NodeTimerRef` class docs.
   - Artisan Benches: Fuel Device: make grinder recipe system close to native. Closes #1785
   - `Core`: ability to add crafts of type `cooking` for custom `method`s. Closes #1786
   - Artisan Benches: Fuel Device: migrate Grinder to `Core/builtin.craft.method` system. Closes #1791
   - Artisan Benches: Grinder: rework `grinding_possible()`, fix using new craft system. Relates to #1791
   - Artisan Benches: Grinder: fix grinding possibility check, reset meta-counters on deactivate. Relates to #1784
   - Artisan Benches: Grinder: extract common definition & inventory_callbacks. Relates to #1787
   - Artisan Benches: Refactoring: Grinder: just rename vars.
   - Artisan Benches: Grinder: migrate to node timer. Closes #1063
   - Refactoring: extract and replace in project `minetest.swap_node_if_not_same()`. Closes #1793
   - Refactoring: Grinder: replace quotes. Relates to #1787
   - Refactoring: Grinder: use only internal class vars & constants. Relates to #1787
   - Refactoring: Grinder: rename SL->S; rework translations; use local globals. Relates to #1787
   - Refactoring: Grinder: rename `form.get()` -> `form.get_spec()`. Relates to #1787
   - Artisan Benches: Fuel Device: first mod version: extract `Device` class from `grinder`. Relates to #1787
   - Artisan Benches: Fuel Device: extract `Processor` from `grinder` mod. Relates to #1787
   - Localization: Исправлено `"лимп"` на `"лимпэ"`. Closes #1240
   - Artisan Benches: Fuel Device: extract nodes registrations and common definitions from `grinder`. Closes #1787. Closes #1788
   - Artisan Benches: Fuel Device: ability to specify inventories size(s). Relates to #1788, #1789
   - Artisan Benches: Fuel Device: fix fogotten node name. Relates to #1787
   - `Core`: `builtin`: ability to specify items count for registering recipes. Closes #1802
   - Artisan Benches: Fuel Device: small improvements, fix `get_craft_result()` `width`. Relates to #1787
   - `Core`: `builtin`: custom craft method takes exactly from the same input cell.
   - Artisan Benches: Fuel Device: add inv sizes, `:init()`, `:is_empty()` into `Device` & reuse it. Relates to #1787, #1789
   - Artisan Benches: Fuel Device: add LBM for re-init Device. Relates to #1787, #1789
   - Artisan Benches: Fuel Device: migrate Barrel to FuelDevice. Relates to #1789
   - Artisan Benches: Fuel Device: Barrel: extract common nodes def & Form. Closes #1789
   - Artisan Benches: Fuel Device: migrate `lord_alcohol` to new recipes for Barrel. Relates to #1789
   - Artisan Benches: Fuel Device: migrate Laboratory to FuelDevice. Closes #1790
   - Effects System: control breath effects. Closes #1678, Closes #1676
   - Effects Int: Potions: add potions for breath. Closes #1733
   - Effects Int: Potions: migrate recipes for ingredients. Relates to #1734
   - `Core`: `builtin`: fix validation false positive error. Relates to #1734
   - Effects Int: Potions: add recipes for lord_potions. Closes #1734
   - Effects/Potions: REMOVE `lottpotion`! Closes #1736. Closes #943
   - `Core`: `builtin`: crafts: ability to find custom crafts via `core.get_craft_recipe()`. Closes #1814
   - `Core`: `helpers`: add `table.count()` for assoc arrays
   - `Core`: Base form: ability to pass args into `:get_spec()` via `:open()`. Relates to #1735
   - Forms: General Styles: extend `forms.Spec` from `minetest.formspec` & change usages. Closes #1815
   - Effects Int: Potions: use new lord potions & crafts in book. Relates to #1816
   - Artisan Benches: prepare modpack backbone. Relates to #1798, #1752
   - Artisan Benches modpack: move `grinder`. Relates to #1798
   - Artisan Benches modpack: extract `anvil`. Relates to #1798
   - Artisan Benches modpack: extract `workbench`. Relates to #1798
   - Artisan Benches modpack: extract `cauldron`. Relates to #1798
   - Artisan Benches modpack: extract `barrel`, rename. Relates to #1798, #1752
   - Artisan Benches modpack: fix `cauldron` aliases. Relates to #1798
   - Artisan Benches modpack: replace `cauldron` names with new ones. Relates to #1798
   - Artisan Benches modpack: replace `barrel` names with new ones. Relates to #1798, #1752
   - Artisan Benches modpack: extract `laboratory`, rename. Closes #1798. Closes #1752
   - `lottpotion`: clean up the remains. Closes #717
   - Artisan benches: add forgotten dependencies. Relates to #1798
   - `Core`: `helpers`: rename/refactor `table.{apply_function_to_every_value->map}()`; cleanup debug.
   - `ide-helper`: add `physics_override_table` annotation.
   - `Core`: `helpers`: add `table.{add|sub|mul|div}_values(t1,t2)` functions.
   - `physics`: ability to add/sub/mul/div. Closes #1819
   - Effects Int: Potions: add groups for potion effects. Closes #1821
   - Effects System: ability to pass additional args into `:start()`/`:stop()` via `:apply()`. Closes #1823
   - `Physics`: ability to specify reason and manage by reson. Closes #1824
   - Effects System: ability to specify reason for effect & stop running effect early. Closes #1825
   - Effects System: apply physics from armor with reason. Closes #1829
   - Effects System: apply effects with reason & theirs physics with reason. Closes #1830
   - Potions Int: potions consumption. Fixes #1822
   - `Core`: `helpers`: add `table.values()`
   - Effects Int: Potions: crafts in book paged by groups, ordered by power. Closes #1816
   - Effects System: ability to get all effects currently acting on player. Closes #1669
   - Artisan Benches: Workbench: update model texture. Relates to #1781
   - Artisan Benches: Barrel: change sequence in ricipes. Relates to #1826
   - Fuel device: fix imediatly result on first step. Fixes #1834

## [2024.09.p2](https://github.com/lord-server/lord/releases/tag/2024.09.p2)
 - Rebalanse spears
 - Add information about Telegram-channel

## [2024.09.p1](https://github.com/lord-server/lord/releases/tag/2024.09.p1)
 - Hotfix: fix Player Inventory tabs. Fixes #1722
 - Escape formspec values. Fixes #1723

## [2024.09](https://github.com/lord-server/lord/releases/tag/2024.09)
 - Ability to give mute privileges for spawn Keepers. Added j_mute mod (fixes #1387) (#1682).
 - Racial weapons:
   - Add human & hobbit weapons. Closes #1691
   - Change racial weapon crafting. Closes #1690
   - Add symmetrical (mirrored) craft for Orcish Sword. Closes #1721
 - Player Inventory:
   - Add "Crafting" image for `en` lang. Closes #1020
   - Bags: add buttons for each bag on bag content page. Closes #1705
   - Make bags as tab; Closes #1698. Relates to #1020
   - Add About tab (v1). Closes #1701
   - Remember opened tab/subtab.
 - Shop:
   - add multi-exchange. Closes #731 (#1707)
 - Stone/Rocks/Ores Blocks:
   - `walls` now connects to marble & different sandstones. Relates to #996
   - Add bricks+blocks for all rocks. Relates to #1304
   - Add stairs & slabs for bricks & blocks from rocks. Relates to #1304
   - Add crafts for Frozen-Stone & Snowy-Cobble. Closes #1327
   - Add White-Tuff. Closes #1342
   - Add damage from magma. Closes #1343
   - Update `lord_rocks_shale.png` (#1413)
 - Forms:
   - Book:
     - Improve readability;
     - Add title into tooltip;
     - Remake book gui. Closes #1715
 - Remove commands `/news`|`/info` and theirs forms. Closes #927

 - Bug Fixing:
   - Fix banister replacing blocks; Fixes #1493 (#1663)
   - Fix steel torch craft count.
   - Fix armor missing helmet. Fix equipment `ForPlayer:not_empty(kind)` iterator. Fixes #1694

 - Technical:
   - Utils: `mt-maker`: recursively walk through `templates` dir.
   - Utils: `mt-maker`: improve mod template.
   - Physics: refactoring: move mod from `_experimental` -> `Core`. Relates to #1666
   - Debug: add `/physics.{get|set}` commands for non `"production"` `environment` setting.
   - Physics: Refactoring: add API; ability to `:set()|:get()` for player; store locally & merge new values in `:set()`. Relates to #1666
   - Physics: Refactoring: extract `Game/lord_physics`. Closes #1666
   - Physics: Refactoring: add forgotten dependency. Relates to #1666
   - Effects System: add `Core/effects` mod backbone. Closes #1656
   - Refactoring: `equipment`: add `equipment.ForPlayer:not_empty()` iterator.
   - Effects System: add ability to register new `Effect` with own `:on_{start|stop}()` functions. Closes #1667
   - Effects System: ability to register & apply effect. Closes #1667. Closes #1668
   - Effects System: `lord_effect`: add mod backbone & register our effects for `speed`,`jump`,`health`. Relates to #1676
   - Technical: fix `get_mail()` from `mail_list` command.
   - Artisan Benches: move `castle:workbench`. Closes #1653
   - `Core/base_classes`: add `DetachedInventory` base class. Closes #1683
   - `Core`: `builtin`: ability to add custom craft methods for `minetest.{register_craft|get_craft_result}()`. Closes #1685
   - `Core`: `builtin`: fix return value for `minetest.get_craft_result`. Relates to #1685
   - `Core`: `builtin`: support `group:*` for custom craft recipes. Closes #1686
   - `Core`: ability to `:return_forgotten()` in `base_classes.DetachedInventory`. Closes #1687
   - `Core`: `base_classes`: add Form Mixin `WithDetached`. Closes #1684
   - `Builtin`: custom craft: decrease input with `groups`; make response fully compatible with MT. Relates to #1685, #1686
   - Artisan Benches: refactor anvil. Closes #1654
   - `Builtin`: fix search of corresponding recipe. Relates to #1685
   - `Builtin`: custom craft: fix decrease of input. Relates to #1685
   - Inventories: extract `lord_forms` for forms styling. Closes #1693
   - Revert "Hack-workaround of `on_take`, `on_put` call sequence. Closes #1029". Closes #1051.
   - Player Inv: Refactoring: move detached inv registration into `lord_equipment`. Relates to 1020
   - `Core`: `base_classes`: refactor `WithTabs` mixin & its usage. Relates to #1695
   - `Core`: `base_classes`: add `Element.Tab` class. Closes #1695
   - `Core`: `base_classes`: ability to add tabs in forms with `WithTabs` mixin. Relates to #1696.
   - `Core`: `base_classes`: change mixer system for Form Mixins. Relates to #1696
   - Player Inventory: remove `sfinv` submodule. Relates to #1020
   - `Core`: `base_clases`: improve Form Mixins. Relates to #1696, #1020
   - `Core`: `base_classes`: ability to pass args into `Form.Base::{register|open|close}()` & catch in `::on_{register|open|close}()`. Closes #1697
   - `Core`: `base_classes`: `WithTabs` mixin: ability to specify form spec "head". Closes #1700
   - Player Inventory: Refactoring: refactoring & make Main as Tab. Closes #1699. Relates to #1020
   - `Core`: `base_classes`: `WithTabs` mixin: ability to specify own handling for each tab. Closes #1702
   - `Core`: `base_classes`: `Personal` mixin: ability to specify to not clear opened form. Closes #1704
   - `Builtin`: add `minetest.FormSpec` & `minetest.FormSpec.Style`. Closes #1706
   - Rework lord_money.shop; fix localization. Closes #731 (#1707)
   - Increase speed (so damage) of hobbit dagger. Relates to #1691
   - `ide-helper`: improve `NodeDefinition` & `ObjectProperties`
   - Add rock bricks+blocks; move chamotte and mordor bricks+blocks into separate files; save untranslated definition for rocks to use it in other blocks registration. Relates to #1304
   - Stony Blocks: restructure code in `lord_bricks`. Relates to #1304
   - Stones: add bricks & blocks overlays; refactor node regs. Relates to #1304
   - Stone Blocks: deduplicate `mordor_stone_{brick|block}` & stairs|slab. Closes #1712
   - Add helper `minetest.register_mirrored_crafts()`. Closes #492
   - Fix `equipment.ForPlayer:not_empty()` iterator. Closes #1716.
   - Forms: remove legacy `default.{gui_bg[_img]|gui_slots}`. Relates to #1708
   - Forms: extract common form elements from `AboutTab` into `forms.spec` api. Relates to #1708
   - Forms: General Styles: ability to configure default styles. Closes #1708
   - Stones/Ores: magma no flowing. Closes #1719
   - Rocks: add localization for White Tuff. Fixes #1720

## [2024.08.p4](https://github.com/lord-server/lord/releases/tag/2024.08.p4)
 - Try to fix `newbie` in chat messages
 - No clan detection by player for blocked clans. Fixes player `nametag` for blocked clan.
 - Limit defense value. Closes #1680

## [2024.08.p3](https://github.com/lord-server/lord/releases/tag/2024.08.p3)
 - Fix repair via shop

## [2024.08.p2](https://github.com/lord-server/lord/releases/tag/2024.08.p2)
 - Fix the crash when throwing a potion arrow into player. Closes #1674 (#1675)

## [2024.08.p1](https://github.com/lord-server/lord/releases/tag/2024.08.p1)
 - Fix tapestry collision_box; convert tapestry.lua to tabs. Closes #1645 (#1661)
 - Fix not returning an empty bottle on drinking honey. Closes #1649 (#1662)
 - Fix banister replacing blocks; Fixes #1493 (#1664)
 - Fix a typo: poisen -> poison; Closes #1670 (#1671)

## [2024.08](https://github.com/lord-server/lord/releases/tag/2024.08)
 - New Damage System:
   - Now dead men attacks with `soul` damage. Closes #1631
   - Apply defense groups for armors (from `fire`, from `soul`, ...); change tooltips. Closes #1639
     - add `fire` defense for galvorn armor. Closes #1630
     - add `poison` defense for silver armor. Closes #1636
     - add `soul` defense for gold armor. Closes #1638
   - Weapons:
     - Add Human Sword with `fire` damage;
     - Add `poison` damage for Orcish sward. Closes #1629.
     - Decrease `soul` damage for Elven sword. Closes #1637.
   - Damaging nodes now damages with specific damage:   Closes #1641
     - Lava, Fire, CampFire, ... damages with `fire`. Closes #1628
     - Mordor water, ... with `poison`.
     - and now we add defense from specific node damage for armors.

 - Media:
   - Textures:
     - Armor:
       - ALL armors were redrawn! Closes #1651

 - Bug Fixing:
   - Fix painting brushes crafting (#1617). Fixes #1544

 - Translations:
   - Translations: `signs_lib`: move to native. Closes #1526
   - Trabslations: `technic_chests`: move to native. Closes #1527. Fixes #1606. Fixes #1223
   - Add translations for mese-lamps. Also fixes #1547
   - Translations: `torches`: move to native. Fix luminance in tooltips. Closes #1528. Fixes #1616

 - Technical:
   - Helpers: add `math.limit`/`math.clamp` function.
   - Refactoring: `hbarmor`: minimal changes; reformat; doc-blocks. Relates to #1610
   - Refactoring: `hbarmor`: rename & reorder functions. Relates to #1610
   - Add ObjectState class. Closes #1515
   - Refactoring `lottarmor`: extract `defense` mod into `_experimental`. Relates to #1012, #1610
   - Refactoring `lottarmor`: restruct `defense` mod. Relates to #1012
   - Refactoring `lottarmor`/`defense`: store calculated values. Relates to #1012, #1610
   - Refactoring `lottarmor`/`hbarmor`: remove usage global var `armor` of legacy LOTT. Closes #1610, Relates to #1012
   - Refactoring `lottarmor`: extract `physics` mod. Relates to #1012
   - `defense`: no recalc `damage_avoid_chance` on each punch; use pre-calc. Closes #1614
   - Fix luacheck. Relates to #1012
   - Refactoring `lottarmor`: move models & textures into `appearance` mod. Relates to #1012
   - Refactoring: REMOVE `LOTTARMOR` !!!!!  Closes #1012, Closes #339
   - IDE-helper: add `PlayerHPChangeReason` description.
   - Signs Lib: minimal refactoring. Fixes #1613
   - Updated painting mod submodule (#1618)
   - Added areas as submodule (#1619). Fixes #1188.
   - mt-maker: fix `init.lua` file creation.
   - Fix `mod.logger` lazy loading.
   - Damage System: add basic `Core/damage` & `Game/lord_damage`. Closes #1622
   - Damage System: Basic: add `damage.Type`; and events; add external API. Closes #1620. Closes #1509
   - Damage System: add usege example into `lord_damage`. Relates to #1623, #1626
   - Damage System: register our (LORD) `damage.Types`. Closes #1623
   - Damage System: add `damage.Type` detection for damaging nodes. Relates to #1626
   - Damage System: add damage types for damaging nodes; add tooltipd sedcription. Closes #1628
   - Damage System: add particles for each `damage.Type`. Closes #1624
   - Damage System: pass damage type to `on_damage` subscribers. Relates to #1509, #1620
   - Damage System: add `damage.Type` detection for hitting tools. Closes to #1626
   - Damage System: fix typo. Relates to #1626
   - Damage System: init & use all `damage.Type`s for `defense` mod. Closes #1632
   - IDE-helper: add descriptions for `Entity` class
   - Damage System: detect `damage.Type` of Playey|Entity hand. Closes #1634
   - Refactoring: `Defense`: move into `Core`. Relates to #1635
   - Refactoring: `Defense`: remove unused; rename mod. Relates to #1635
   - Refactoring: `Defense`: move `set_armor_groups` into `PlayerDefense`. Relates to #1635
   - Refactoring: `Defense`: rename var; fix `for_player()`. Relates to #1635
   - Refactoring: `Defense`: separate `lord_defense` mod. Closes #1635
   - Refactoring: `Defense`: add Events `on_init()` & `on_change`; use for hud. Closes #1640
   - Refactoring: `Defense`: apply defense groups for armors; change tooltips. Closes #1639
   - Damage System: ability to integrate damage modifier. Closes #1642
   - Damage System: add ability to apply periodical damage. Closes #1625
   - Update `readme.md` roles.
   - Update `readme.md`: add `play` button.
   - Artisan Benches: move `castle:anvil` into separate mod. Closes #1652

## [2024.07.II](https://github.com/lord-server/lord/releases/tag/2024.07.II)
 - Balance: Food:
   - change all points for all food;
   - add satiety for egg;
   - remove satiety from salt-block. Closes #1571. Closes #1576. #1581.
   - reduce spawn of riding animals (except warg). Closes #1574
   - decrease yavannamire yield; increase satiety of fruit. Closes #1575
   - bread from dough recipe. Closes #1577
   - add `bucket:bucket_salt` and recipes. Relates to #1573
   - change satiety for salted food. Closes #1573
   - add `Baked corn`
 - Tooltips: descriptions:
   - for armor
   - also for buffs/effects. Closes #1588
   - remake for digging tools. Relates to #1587
   - remake for food. Relates to #1587
   - add `luminance` to `Properties` group. Relates to #1587
 - Balance:
   - melee weapon:
     - daggers (&range:2); rename 'training'->'wooden'. Closes #1590
     - spears. Closes #1591
     - swords. Closes #1592
     - batleaxes. Closes #1593
     - warhammers. Closes #1594
     - racial. Closes #1599
   - range weapon:
     - arrows,
     - bolts,
     - throwing axes. Closes #1600
   - armor:
     - change all points for all armor sets. Closes #1595
     - add wear for Nenya ring. Closes #1601
 - Balance: reduce dwarf ring uses. Closes #1603

 - Icons:
   - Change salt icon. Closes #1579
   - Change corn ear icon. Closes #1580

 - Add `international` cloak (+ some refactoring `clans_clothes`). Closes #1378

 - Technical:
    - Add `controls` mod as submodule. Relates to #1550
    - IDE Helper: reformat `ItemDefinition`, add `SimpleSoundSpec`.
    - Refactoring: add `minetest.foreach_player_every(sec, callback)`. Closes #1553
    - Refactoring: extract `controls` mod from `lordlib`. Closes #1550.
    - Replace `string.gsub()` to `string.replace()` where appropriate. Closes #932
    - Add params description for `/clans.show` command. Fixes #1554
    - Refacroring replace to `string:starts_with()` if possible. Closes #1247
    - Replace `io.<...>` file operations with `io.read_from_file()` and `io.write_to_file()`. Closes #925
    - Add `minetest.mod()` helper. Relates to #913
    - Add unified `require()`; add `minetest.get_mod_require()`; now `minetest.mod()` automatically exchaenge `require()` for mod. Relates to #913
    - Use new unified `require()` via `minetest.mod()` in all mods. Closes #913.
    - Util: `./lord mod` cli-cmd: Change `init.lua` generation for use new `minetest.mod()`. Relates to #913
    - Refactoring: `controls`: rename `lord` -> `controls`; isolate internal funcs|vars. Realates #1557
    - Refactoring: `controls`: extract `Event` class. Realates to #1557
    - Refactoring: `controls`: improve readability. Closes #1557
    - Refactoring: extract `wield_item` api mod. Closes #1552
    - Refactoring: `lordlib`: move `give_or_drop()` -> `builtin`; `each_value_equals()` -> `helpers`. Closes #1559.
    - Refactoring: move `equipment` into `Core`. Cloaes #1560. Relates to #967
    - Refactoring: add unified `debug` mode. Closes #1561
    - IDE-helper: extract `utilities.lua`
    - Refactoring: add `helpers.Logger` class. Relates to #1556
    - Refactoring: add lazy loading field `logger` into `minetest.Mod`. Realates to #1556
    - Fix impossibility of obtaining http API. Broken while #913
    - Refactoring: use `helpers.Logger` in `web_integration`. Closes №1556
    - Remove forgotten unused code; rename param. Relates #1556
    - Improve `./lord mod <name>`: use templates, add globsl api var init.
    - Refactoring: add `base_classes.Event` class. Relates to #1558
    - Refactoring: use base `Event` in `controls` mod. Relates to #1558
    - Refactoring: use base `Event` in `wield_item` & `clans`. Closes #1558
    - `helpers`: add `debug.get_function_code()`
    - `base_classes`: improve `Event`: ability to link generated by `:on()` to another object. Needs for #1565
    - Refactoring: `base_classes`: add `BaseForm` first version (no mixins). Relates to #1565
    - `helpers`: add `_G.errorf` & `_G.errorlf` functions with `string.format()` applying
    - `helpers`: Fix `_G.errorlf()` set level == 2 for `_G.errorf()`. No luackeck & MT warnings.
    - `base_classes`: add mixin system for Form. Relates to #1565
    - `base_classes`: add `ForNode` & `WithTabs` minxins for `Form`s. Relates to #1565
    - `base_classes`: add `Personal` form mixin (extract from `Form.Base`. Relates to #1565
    - `base_classes`: clean doc-blocks for forms classes; move fogotten `on_close` to `Personal. Relates to #1565
    - Refactoring: `base_classes`: `Form`: use new forms for `quest_node:reward_chest`. Relates to #1565
    - Refactoring: `base_classes`: `Form`: use new forms for `clan_node:chest`. Relates to #1565
    - `base_classes`: `Event`: improve `:extended()`, clean doc-blocks. Relates to #1558, #1565
    - `base_classes`: `Form`: improve `Form.Event:extended()`; fix form events subscriptions. Relates to #1565
    - Refactoring: `base_classes`: `Form`: use new forms for `lord_traders`. Relates to #1565
    - Translations: move `hud_modpack`. Closes #1529
    - Refactoring: `lottarmor`: separate wear handling. Relates to #339, #1012. Closes #977
    - Refactoring: `lottarmor`: move armor wear into `equipment_armor`. Relates to #339, #1012
    - Refactoring: combine `equipment_armor` and `equipment_clothing` into single `lord_equipment` mod.
    - Refactoring: `lottarmor`: remove unused. Relates to #339, #1012.
    - Refactoring: `lottarmor`: extract `get_armor_healing_chance()` function. Relates to #339, #1012
    - Refactoring: `lottarmor`: no globalstep, use `register_on_punchplayer()` for check healing on hit. Relates to #339, #1012.
    - Refactoring: `lottarmor`: extract healing into separate file. Relates to #339, #1012.
    - Refactoring: `lottarmor`: mini restruct function. Relates to #339, #1012.
    - Refactoring: `lottarmor`: fix healing (damage avoid). Relates to #339, #1012.
    - Refactoring: `lottarmor`: rename "armor-heal" to "armor-damage-avoid". Now it works! Relates to #339, #1012.
    - Refactoring: `lottarmor`: remove now unused `armor.player_hp`. Relates to #339, #1012.
    - Refactoring: `lottarmor`: no negative damage. Now player not pulls by hit. Relates to #339, #1012. Fixes #1289.
    - Balance: Food: remove overwrites and multiplier from `hbhunger`. Closes #1569, closes #1579.
    - Remove strange pearl block craft.
    - `Core`: `helpers`: fix `table.contains` as of minetest/minetest#14906
    - `Core`: `builtin` extension: add `minetest.get_all_craft_recipes_from(ingredient)` helper. Relates to #1501, #1573
    - IDE-helper: add `RecipeEntryTable` class & `minetest.get_all_craft_recipes()` descriptions.
    - IDE-helper: full docs for `ItemStack`
    - Refactoring: just restruct `debugtools`
    - `debugtools`: add `/crafting_from` command. Relates to #1501, #1573, #1469
    - Return valid value from require(module) for `web_api/config.lua`. Closes #1585
    - Rename alias for `lottmapgen:mordor_sand` (fogotten for `defaults:`). Closes #1563
    - Add declaration of global `lord_wooden_stuff`. Fixes #1541
    - Fix hardcoded `ingredient` in `/crafting_from` command.
    - Fix textures for clans cloaks. Fixes #1598
    - Tooltips: add lord-like damage desc. Closes #1584. Relates to #1587
    - Tooltips: restructure code. Relates to #1587
    - Tooltips: remove unused var. Relates to #1587
    - Tooltips: decrease cyclomatic complexity for `snippet.digging`. Relates to #1587
    - Tooltips: copy remaining snippet `node_info` ad is. Relates to #1587
    - Tooltips: remove `tt_base` mod. Closes #1587
    - Tooltips: collect all Properties together.
    - Balance: melee weapon: mini-refactoring. Closes #1597

## [2024.07.p3](https://github.com/lord-server/lord/releases/tag/2024.07.p3)
 - Spawners: some refactoring & fix `night_only: {true|false|"disabled"}`

## [2024.07.p2](https://github.com/lord-server/lord/releases/tag/2024.07.p2)
 - Spawners: fix not enough light & not enough space. Remove `-- print(...)`.

## [2024.07.p1](https://github.com/lord-server/lord/releases/tag/2024.07.p1)
 - Fix `/web_sync_clans` command. Relates to #1538. Fixes #1549.

## [2024.07](https://github.com/lord-server/lord/releases/tag/2024.07)
 - Extended Tooltips: add properties description. Closes #1490
 - Lighting: add mese lamps from our woods. Closes #886
 - Update discord mod for: display info about join/left player race. Closes #1517
 - Add first version of Mob-Spawners (`lord_spawners`).
 - Integration with website:
   - Sync Players: update `race`, `gender`, `is_online`, when `last_login`
   - Sync Clans:   update on create/del/block, add/del players, update when clan `is_online`

 - Bug fixes:
   - Remove craft stick by group: fixing crafts of other wood types. Fixes #1546

 - Technical:
   - Add `io.write_to_file()` helper. Relates to #925. Needs for #1502
   - Rebalance: Food: take ru titles for analytics document. Closes #1502
   - Extended Tooltips: add original `tt` & `tt_base` as submodules. Closes #1503
   - Lord Bows: add damge info to arrows description. Closes #1457
   - Planks: add `planks.get_lord_nodes()` into API. Now needs for #886
   - Rebalance: Food: extract `hbhunger` overwrites. Closes #1507
   - Rebalance: Food: Research: add `/satiety.{get|set}` commands for testing. CLoses #1506
   - Add/Move `/armor.{get|set}` command(s) into `dev` from `lord_damage` branch. Relates to # 1509
   - Move `castle` to builtin translations. Closes #1363. Fixes #1514
   - Move several mods from `_various` into `lord`. Relates to #328
   - Refactor `core_function`: check if last controls already inited. Extract `notify_subscribers()`. Fixes #1533. Fixes #936.
   - Game-Web: turn off integration on Poligon. Relates to lord-server/infrastructure#7
   - Game-Web: Players: update `race`, `gender`, `is_online`. Closes #1530. Fixes #1534
   - Game-Web: pass as player `last_login` "now()" and not previous last-login. Fixes #1535
   - Game-Web: add tmp command for register clan players on webside. Closes #1532
   - Game-Web: add `409 Conflict` handling. Closes #1442
   - Game-Web: extract sync_command into separate file. Relates to #1538
   - Game-Web: make `for_players` & `for_clans` returns classes. Relates to #1538
   - Game-Web: Refatoring classes for player & clan integration. Make then nor consistent. Relates to #1538
   - Game-Web: add clan id sync. Closes #1538
   - Add `mod.conf` for mod `lord_food`. Fix warning in logs.
   - `http.Client`: add `http.debug` setting for dumping `request` & `result`.
   - Game-Web: add|del player to clan: add workaround for minetest/minetest#14846 . Closes #1539
   - Mobs: Refactoring: `lottmobs`: initial restructure. Closes #1543
   - Fix `luacheck` warnings for `lord_spawners`.


## [2024.06.p3](https://github.com/lord-server/lord/releases/tag/2024.06.p3)
 - Game-Web: change passed player `last_login` as `now()`. Relates to #1436
 - Add spawns of cave mobs on `lord_rocks`. Closes #1468
 - Fix lost mordor blocks|bricks and theirs stairs|slabs. Fixes #1512. Relates to #1233

## [2024.06.p2](https://github.com/lord-server/lord/releases/tag/2024.06.p2)
 - Game-Web: turn on integration on production. Relates to lord-server/infrastructure#7
 - Add `spawn_to` privilege. Closes #1511

## [2024.06.p1](https://github.com/lord-server/lord/releases/tag/2024.06.p1)
 - Changed painting mod to lord fork
 - Reduce nazgul spawn in nazgul area.

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
