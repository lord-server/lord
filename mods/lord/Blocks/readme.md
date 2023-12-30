**Внимание:** это черновой вариант и в некоторых модах могут всё ещё содержаться не только блоки.
Эти моды по-хорошему нужно разделить и разнести в соответствующие подпапки (Blocks, Items, ...)

----

Сюда перенесены все моды, которые содержат блоки.

### `defaults`
 - генерация проходимых призрачных блоков, которые делаются призрачным посохом 
 - похоже из [ghostblocks](https://github.com/pchickn/ghostblocks)
 - но много переработано...

### `lamps`
 - наш мод с лампами, цепями, гаечным ключом для поворота цепей
 - напрашивается разделение и разнесение по модам
 - [см. #465](https://github.com/lord-server/lord/pull/465)
 - by VanicGame

### `lord_blocks`
 - наши допилы поверх lott или default
 - `default:blackout`->`lord_blocks:blackout`
 - `marble_*` , `dwarfstone_*`

### `lord_doors`
 - двери Гондора (выдаются админом за заслуги)
 - расовые двери
 - модификации поверх MTG

### `lord_flowers`
 - пока только `:flowers:cactus_decor`

### `lord_homedecor`
 - изначально собрано из обрывков старых разрозненных модов
 - свалка всего подряд
 - сейчас большинство этого можно найти в [homedecor_modpack](https://github.com/mt-mods/homedecor_modpack)

### `lord_mail`
 - "Почтовый ящик", `:default:book`, `:default:paper`, `lord_mail:paper_with_text`

#### `lord_wool`
 - ступени и плиты из шерсти `stairs:{stair,slab}_wool<colorname>`

### `protector_lott`
- когда-то взят здесь: https://forum.minetest.net/viewtopic.php?f=11&t=9376
- сейчас мод развился(вается): https://content.minetest.net/packages/TenPlus1/protector/ (https://codeberg.org/tenplus1/protector)
- ничего принципиального не добавлено, поэтому выносить в `_various` и подключать submodule'м нет смысла
- однако есть переводы на 6 языков, которые стоит подтянуть: [#1185](https://github.com/lord-server/lord/issues/1185)

### `roads`
 - мод для дорог с бордюрами [см. #381](https://github.com/lord-server/lord/pull/381)
 - мод разработан нами (by VanicGame)
