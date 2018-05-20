# Smithy
Smithy Mod for Minetest. A wip mod that adds anvils, cauldrons, and alloy furnaces to MineTest for slightly more difficult metal forging.
## Features
### Anvil
Anvil uses the Cottages mod's anvil as a base, and will add more functionality than just fixing tools. Metal craft items will have to be made through the anvil. Uses "glooptest_tool_steelhammer.png" for the hammer (what mod with an anvil doesn't?) and "default_stone.png" for the anvil texture.
### Alloy Furnace
The alloy furnace is used for alloying different metals together to create new metals. Currently, this doesn't work nor are there any built-in recipes yet. Based off of the Lord Of The Test game's dual furnace. Looks just like a normal furnace and uses the same textures, with the exception of the front side. It uses a combination of LOTT's dual furnace's front texture and the default furnace front texture.
### Cauldron
Cauldrons are used to store water and to cool down hot ingots (any item with the group "hot_ingot" set to 1).  These originally came from LOTT, but the textures were changed to use "default_furnace_bottom.png" from the default mod and a combination of the "LOTT_cauldron_top.png" and "default_furnace_bottom". I changed the original cauldron code from LOTT a lot. I reorganized the code, added a function other mods can use to add other types of cauldrons, new ways to fill them, and (of course) added a way to cool hot ingots (current method is punching the cauldron).
### Glass Bottle (Water)
Added glass bottle filled with water. Vessels was lacking it, so I added it. Can be used fill a cauldron to 1/3 more than what it was. Texture based off of "vessels_glass_bottle.png" and (I think) "default_water.png".
