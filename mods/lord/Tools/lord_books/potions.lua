local SL = minetest.get_translator("lord_books")

local form    = {}
--- @type string
form.NAME     = "potions_book_form"
--- @param page string
--- @return string
form.get_spec = function(page)
	if page=="potions" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."background[5,5;1,1;books_formbg.png;true]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potions2;;false;false;books_next_press.png]"
               .."image[6,1;1,1;books_previous_inactive.png]"
               .."label[0,1;"..SL("Base Potions:").."]"
               --First potion
               .."label[1,2.2; "..SL("Mese Base Potion").."]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,2;1,1;default:mese_crystal_fragment;zcg:mese_crystal_fragment;]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               --Second
               .."label[1,3.2; "..SL("Geodes Base Potion").."]"
               .."item_image_button[4,3;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,3;1,1;lottores:geodes_crystal_1;zcg:geodes_crystal_1;]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               --Third
               .."label[1,4.2; "..SL("Seregon Base Potion").."]"
               .."item_image_button[4,4;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,4;1,1;lottplants:seregon;zcg:seregon;]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
	end
     if page=="potions2" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potions3;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potions;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Orc Draught (Hurting Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
               .."item_image_button[5,2;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:orcdraught_power1;zcg:orcdraught_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:orcdraught_power1;zcg:orcdraught_power1;]"
               .."item_image_button[5,3;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:orcdraught_power2;zcg:orcdraught_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:orcdraught_power2;zcg:orcdraught_power2;]"
               .."item_image_button[5,4;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:orcdraught_power3;zcg:orcdraught_power3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
     end
     if page=="potions3" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potions4;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potions2;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Spider Poison (Speed Weakening Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
               .."item_image_button[5,2;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:spiderpoison_power1;zcg:spiderpoison_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:spiderpoison_power1;zcg:spiderpoison_power1;]"
               .."item_image_button[5,3;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:spiderpoison_power2;zcg:spiderpoison_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:spiderpoison_power2;zcg:spiderpoison_power2;]"
               .."item_image_button[5,4;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:spiderpoison_power3;zcg:spiderpoison_power3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potions4" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potions5;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potions3;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Limpe (Breathing Underwater Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               .."item_image_button[5,2;1,1;lord_trees:yavannamire_leaf;zcg:yavannamireleaf;10]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:limpe_power1;zcg:limpe_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:limpe_power1;zcg:limpe_power1;]"
               .."item_image_button[5,3;1,1;lord_trees:yavannamire_leaf;zcg:yavannamireleaf;10]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:limpe_power2;zcg:limpe_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:limpe_power2;zcg:limpe_power2;]"
               .."item_image_button[5,4;1,1;lord_trees:yavannamire_leaf;zcg:yavannamireleaf;10]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:limpe_power3;zcg:limpe_power3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potions5" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potions6;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potions4;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Miruvor (Jump Boost Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               .."item_image_button[5,2;1,1;lord_trees:yavannamire_fruit;zcg:yavannamirefruit;2]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:miruvor_power1;zcg:miruvor_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:miruvor_power1;zcg:miruvor_power1;]"
               .."item_image_button[5,3;1,1;lord_trees:yavannamire_fruit;zcg:yavannamirefruit;2]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:miruvor_power2;zcg:miruvor_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:miruvor_power2;zcg:miruvor_power2;]"
               .."item_image_button[5,4;1,1;lord_trees:yavannamire_fruit;zcg:yavannamirefruit;2]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:miruvor_power3;zcg:miruvor_power3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potions6" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potions7;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potions5;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Athelas Brew (Healing Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               .."item_image_button[5,2;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:athelasbrew_power1;zcg:athelasbrew_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:athelasbrew_power1;zcg:athelasbrew_power1;]"
               .."item_image_button[5,3;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:athelasbrew_power2;zcg:athelasbrew_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:athelasbrew_power2;zcg:athelasbrew_power2;]"
               .."item_image_button[5,4;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:athelasbrew_power3;zcg:athelasbrew_power3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potions7" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potionsN;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potions6;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Ent Draught (Healing & Jump Weakening Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               .."item_image_button[5,2;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:entdraught_power1;zcg:entdraught_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:entdraught_power1;zcg:entdraught_power1;]"
               .."item_image_button[5,3;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:entdraught_power2;zcg:entdraught_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:entdraught_power2;zcg:entdraught_power2;]"
               .."item_image_button[5,4;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:entdraught_power3;zcg:entdraught_power3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
	if page=="potionsN" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."background[5,5;1,1;books_formbg.png;true]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potionsN2;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potions7;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Base Potions Of Negative:").."]"
               --First potion
               .."label[1,2.2; "..SL("Obsidian Base Potion").."]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,2;1,1;default:obsidian_shard;zcg:obsidian_shard;]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:glass_bottle_obsidian;zcg:glass_bottle_obsidian;]"
               --Second
               .."label[1,3.2; "..SL("Bonedust Base Potion").."]"
               .."item_image_button[4,3;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,3;1,1;bones:bonedust;zcg:bonedust;]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:glass_bottle_bonedust;zcg:glass_bottle_bonedust;]"
               --Third
               .."label[1,4.2; "..SL("Mordor Base Potion").."]"
               .."item_image_button[4,4;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,4;1,1;lottplants:brambles_of_mordor;zcg:brambles_of_mordor;]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:glass_bottle_mordor;zcg:glass_bottle_mordor;]"
	end
     if page=="potionsN2" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potionsN3;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potionsN;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Orc Draught (Healing Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mordor;zcg:glass_bottle_mordor;]"
               .."item_image_button[5,2;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:orcdraught_corruption1;zcg:orcdraught_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:orcdraught_corruption1;zcg:orcdraught_corruption1;]"
               .."item_image_button[5,3;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:orcdraught_corruption2;zcg:orcdraught_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:orcdraught_corruption2;zcg:orcdraught_corruption2;]"
               .."item_image_button[5,4;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:orcdraught_corruption3;zcg:orcdraught_corruption3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
     end
     if page=="potionsN3" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potionsN4;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potionsN2;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Spider Poison (Jump And Speed Boost Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mordor;zcg:glass_bottle_mordor;]"
               .."item_image_button[5,2;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:spiderpoison_corruption1;zcg:spiderpoison_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:spiderpoison_corruption1;zcg:spiderpoison_corruption1;]"
               .."item_image_button[5,3;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:spiderpoison_corruption2;zcg:spiderpoison_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:spiderpoison_corruption2;zcg:spiderpoison_corruption2;]"
               .."item_image_button[5,4;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:spiderpoison_corruption3;zcg:spiderpoison_corruption3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potionsN4" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potionsN5;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potionsN3;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Limpe (Breathing Underwater Block Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_obsidian;zcg:glass_bottle_obsidian;]"
               .."item_image_button[5,2;1,1;lord_trees:yavannamire_leaf;zcg:yavannamireleaf;10]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:limpe_corruption1;zcg:limpe_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:limpe_corruption1;zcg:limpe_corruption1;]"
               .."item_image_button[5,3;1,1;lord_trees:yavannamire_leaf;zcg:yavannamireleaf;10]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:limpe_corruption2;zcg:limpe_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:limpe_corruption2;zcg:limpe_corruption2;]"
               .."item_image_button[5,4;1,1;lord_trees:yavannamire_leaf;zcg:yavannamireleaf;10]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:limpe_corruption3;zcg:limpe_corruption3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potionsN5" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potionsN6;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potionsN4;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Miruvor (Jump Block Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_obsidian;zcg:glass_bottle_obsidian;]"
               .."item_image_button[5,2;1,1;lord_trees:yavannamire_fruit;zcg:yavannamirefruit;2]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:miruvor_corruption1;zcg:miruvor_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:miruvor_corruption1;zcg:miruvor_corruption1;]"
               .."item_image_button[5,3;1,1;lord_trees:yavannamire_fruit;zcg:yavannamirefruit;2]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:miruvor_corruption2;zcg:miruvor_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:miruvor_corruption2;zcg:miruvor_corruption2;]"
               .."item_image_button[5,4;1,1;lord_trees:yavannamire_fruit;zcg:yavannamirefruit;2]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:miruvor_corruption3;zcg:miruvor_corruption3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potionsN6" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;books_next.png;potionsN7;;false;false;books_next_press.png]"
               .."image_button[6,1;1,1;books_previous.png;potionsN5;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Athelas Brew (Hurting Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_bonedust;zcg:glass_bottle_bonedust;]"
               .."item_image_button[5,2;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:athelasbrew_corruption1;zcg:athelasbrew_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:athelasbrew_corruption1;zcg:athelasbrew_corruption1;]"
               .."item_image_button[5,3;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:athelasbrew_corruption2;zcg:athelasbrew_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:athelasbrew_corruption2;zcg:athelasbrew_corruption2;]"
               .."item_image_button[5,4;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:athelasbrew_corruption3;zcg:athelasbrew_corruption3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
     if page=="potionsN7" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image[7,1;1,1;books_next_inactive.png]"
               .."image_button[6,1;1,1;books_previous.png;potionsN6;;false;false;books_previous_press.png]"
               .."label[0,1;"..SL("Ent Draught (Boost And Control Lose Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_bonedust;zcg:glass_bottle_bonedust;]"
               .."item_image_button[5,2;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,2;1,1;books_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:entdraught_corruption1;zcg:entdraught_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:entdraught_corruption1;zcg:entdraught_corruption1;]"
               .."item_image_button[5,3;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,3;1,1;books_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:entdraught_corruption2;zcg:entdraught_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:entdraught_corruption2;zcg:entdraught_corruption2;]"
               .."item_image_button[5,4;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,4;1,1;books_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:entdraught_corruption3;zcg:entdraught_corruption3;]"
               .."background[5,5;1,1;books_formbg.png;true]"
	end
end

--- @param player Player
--- @param page string
form.show     = function(player, page)
	minetest.show_formspec(player:get_player_name(), form.NAME, form.get_spec(page))
end


---@param player    Player
---@param form_name string
---@param fields    table
minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= form.NAME then
		-- HACK: До рефакторинга все формы книг обрабатывали все прилетающие поля со всех форм, не учитывая `form_name`,
		--       с кучей запутанных вызовов.
		--       Теперь нет, однако на форме `lord_books:master_book` есть кнопка `potions`,
		--       которая открывает эту форму, но обрабатывается она здесь
		if form_name == zmc.form.NAME and fields.potions then
			form.show(player, "potions")
		end
		return
	end

	if fields.potions then
		form.show(player, "potions")
	elseif fields.potions2 then
		form.show(player, "potions2")
	elseif fields.potions3 then
		form.show(player, "potions3")
	elseif fields.potions4 then
		form.show(player, "potions4")
	elseif fields.potions5 then
		form.show(player, "potions5")
	elseif fields.potions6 then
		form.show(player, "potions6")
	elseif fields.potions7 then
		form.show(player, "potions7")
	end
	--Negative-potions--
	if fields.potionsN then
		form.show(player, "potionsN")
	elseif fields.potionsN2 then
		form.show(player, "potionsN2")
	elseif fields.potionsN3 then
		form.show(player, "potionsN3")
	elseif fields.potionsN4 then
		form.show(player, "potionsN4")
	elseif fields.potionsN5 then
		form.show(player, "potionsN5")
	elseif fields.potionsN6 then
		form.show(player, "potionsN6")
	elseif fields.potionsN7 then
		form.show(player, "potionsN7")
	end
end)

minetest.register_tool("lord_books:potions_book",{
    description = SL("Book of Potions"),
    inventory_image = "potion_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    groups = {cook_crafts=1, book=1, paper=1},
    on_use = function(itemstack, player, pointed_thing)
          form.show(player,"potions")
          return itemstack; -- nothing consumed, nothing changed
    end,
})
