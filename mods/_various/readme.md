Сторонние разрозненные моды
===========================

### Submodules
Подключены submodule'м, url см `.gitmodules`:
 - `ambience`
 - `candles_3d` (наш fork) 
 - `mywalls`
 - `stainedglass`
 - `WorldEdit`

### `areas`
 - [minetest-mods/areas](https://github.com/minetest-mods/areas)
 - из изменений только перевод

### `bees`
 - из [bas080/bees](https://github.com/bas080/bees) ([форум](https://forum.minetest.net/viewtopic.php?t=6743))
 - есть развитие мода: [TenPlus1/bees](https://notabug.org/TenPlus1/bees) ([MT.ContentDB](https://content.minetest.net/packages/TenPlus1/bees/))
 - есть наши изменения:
   - перевод
   - корректировка баланса еды
   - фиксы и пр.

### `castle`
 - возможно из [Philipbenr/castles](https://github.com/Philipbenr/castles), теперь есть: [minetest-mods/castle](https://github.com/minetest-mods/castle)
 - изменения, фиксы, ...

### `help_modpack`
  - собрано из:
    - `tt`: [ContentDB](https://content.minetest.net/packages/Wuzzy/tt/), [git](https://repo.or.cz/minetest_tt.git)
    - `tt_base`: [ContentDB](https://content.minetest.net/packages/Wuzzy/tt_base/), [git](https://repo.or.cz/minetest_tt_base.git)
  - доп. переводы взяты из: [MCL2/tt](https://git.minetest.land/MineClone2/MineClone2/src/branch/master/mods/HELP/mcl_tt/locale)
  - т.к. нет нормально вынесенных (на GH, например) модов — чтобы просто подключить submodule'м,  
    а приходится собирать из разных мест и скрещивать, то возможно стоит перенести к нам и поддерживать самим

### `hud_modpack`
 - модпак создан из следующих модов:
   - hbhunger (https://repo.or.cz/w/minetest_hbhunger.git)
   - hbsprint (https://github.com/GunshipPenguin/sprint)
   - hbarmor (http://repo.or.cz/w/minetest_hbarmor.git) 
   - hudbars (http://repo.or.cz/w/minetest_hudbars.git)
 - изменения:
   - принудительное размещение HUD-баров в нужной последовательности

### `icicles`
 - из [RealTest Game](https://github.com/sda97ghb/realtest/tree/master/mods/icicles) ([форум](https://forum.minetest.net/viewtopic.php?f=50&t=2671))

### `intllib`
 - из [minetest-mods/intllib](https://github.com/minetest-mods/intllib)
 - [DEPRECATED] нужно переходить на встроенный API (практически все моды уже поддерживают, просто обновиться)

### `itemframes`
 - ? https://gitlab.com/VanessaE/homedecor_modpack/-/tree/master/itemframes ?
 - ? https://content.minetest.net/packages/TenPlus1/itemframes/ (https://notabug.org/TenPlus1/itemframes) ?
 - ???

### `mobs`
 - это "фреймворк" для создания мобов
 - сами мобы находятся в:
   - `mods/lord/Entities/lottmobs`
   - `mods/lord/Entities/lord_traders`
   - `mods/_various/mobs_fish`
 - форум: https://forum.minetest.net/viewtopic.php?t=9917
 - contentDb: https://content.minetest.net/packages/TenPlus1/mobs/
 - code: https://codeberg.org/tenplus1/mobs_redo

### `mobs_fish`
 - когда-то скопировано из старой версии
 - сейчас это часть мод-пака `mobs_water`
 - code: https://codeberg.org/tenplus1/mobs_water/src/branch/master/mobs_fish
 - contentDb: https://content.minetest.net/packages/TenPlus1/mobs_water/

### `painting`
 - https://github.com/HybridDog/painting

### `new_campfire`
 - https://content.minetest.net/packages/VanessaE/new_campfire/

### `signs_lib`
 - ? https://content.minetest.net/packages/VanessaE/signs_lib/ ?
 - ? https://forum.minetest.net/viewtopic.php?t=13762 ?
 - ? https://gitlab.com/VanessaE/signs_lib/ ?

### `technic_chests`
 - выпилено из мода Technic, ссылку привести не могу поскольку сейчас слишком много веток стало. (Badger)

### `torches`
 - ??? это было примерно в 2015 году, искал 3D факелы вместо плоских. Думаю и мода этого уже не осталось. (Badger)
