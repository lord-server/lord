local SL = lord.require_intllib()

local get_formspec = function(player,page)
	if page=="potions" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."background[5,5;1,1;craft_formbg.png;true]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potions2;;false;false;zcg_next_press.png]"
               .."image[6,1;1,1;zcg_previous_inactive.png]"
               .."label[0,1;"..SL("Base Potions:").."]"
               --First potion
               .."label[1,2.2; "..SL("Mese Base Potion").."]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,2;1,1;default:mese_crystal_fragment;zcg:mese_crystal_fragment;]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               --Second
               .."label[1,3.2; "..SL("Geodes Base Potion").."]"
               .."item_image_button[4,3;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,3;1,1;lottores:geodes_crystal_1;zcg:geodes_crystal_1;]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               --Third
               .."label[1,4.2; "..SL("Seregon Base Potion").."]"
               .."item_image_button[4,4;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,4;1,1;lottplants:seregon;zcg:seregon;]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
	end
     if page=="potions2" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potions3;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Orc Draught (Hurting Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
               .."item_image_button[5,2;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:orcdraught_power1;zcg:orcdraught_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:orcdraught_power1;zcg:orcdraught_power1;]"
               .."item_image_button[5,3;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:orcdraught_power2;zcg:orcdraught_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:orcdraught_power2;zcg:orcdraught_power2;]"
               .."item_image_button[5,4;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:orcdraught_power3;zcg:orcdraught_power3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
     end
     if page=="potions3" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potions4;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions2;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Spider Poison (Speed Weakening Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
               .."item_image_button[5,2;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:spiderpoison_power1;zcg:spiderpoison_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:spiderpoison_power1;zcg:spiderpoison_power1;]"
               .."item_image_button[5,3;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:spiderpoison_power2;zcg:spiderpoison_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:spiderpoison_power2;zcg:spiderpoison_power2;]"
               .."item_image_button[5,4;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:spiderpoison_power3;zcg:spiderpoison_power3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potions4" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potions5;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions3;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Limpe (Breathing Underwater Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               .."item_image_button[5,2;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:limpe_power1;zcg:limpe_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:limpe_power1;zcg:limpe_power1;]"
               .."item_image_button[5,3;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:limpe_power2;zcg:limpe_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:limpe_power2;zcg:limpe_power2;]"
               .."item_image_button[5,4;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:limpe_power3;zcg:limpe_power3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potions5" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potions6;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions4;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Miruvor (Jump Boost Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               .."item_image_button[5,2;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:miruvor_power1;zcg:miruvor_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:miruvor_power1;zcg:miruvor_power1;]"
               .."item_image_button[5,3;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:miruvor_power2;zcg:miruvor_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:miruvor_power2;zcg:miruvor_power2;]"
               .."item_image_button[5,4;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:miruvor_power3;zcg:miruvor_power3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potions6" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potions7;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions5;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Athelas Brew (Healing Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               .."item_image_button[5,2;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:athelasbrew_power1;zcg:athelasbrew_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:athelasbrew_power1;zcg:athelasbrew_power1;]"
               .."item_image_button[5,3;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:athelasbrew_power2;zcg:athelasbrew_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:athelasbrew_power2;zcg:athelasbrew_power2;]"
               .."item_image_button[5,4;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:athelasbrew_power3;zcg:athelasbrew_power3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potions7" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potionsN;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions6;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Ent Draught (Healing & Jump Weakening Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               .."item_image_button[5,2;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:entdraught_power1;zcg:entdraught_power1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": 2]"
               .."item_image_button[4,3;1,1;lottpotion:entdraught_power1;zcg:entdraught_power1;]"
               .."item_image_button[5,3;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:entdraught_power2;zcg:entdraught_power2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": 3]"
               .."item_image_button[4,4;1,1;lottpotion:entdraught_power2;zcg:entdraught_power2;]"
               .."item_image_button[5,4;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:entdraught_power3;zcg:entdraught_power3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
	if page=="potionsN" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."background[5,5;1,1;craft_formbg.png;true]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potionsN2;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions7;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Base Potions Of Negative:").."]"
               --First potion
               .."label[1,2.2; "..SL("Obsidian Base Potion").."]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,2;1,1;default:obsidian_shard;zcg:obsidian_shard;]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:glass_bottle_obsidian;zcg:glass_bottle_obsidian;]"
               --Second
               .."label[1,3.2; "..SL("Bonedust Base Potion").."]"
               .."item_image_button[4,3;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,3;1,1;bones:bonedust;zcg:bonedust;]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:glass_bottle_bonedust;zcg:glass_bottle_bonedust;]"
               --Third
               .."label[1,4.2; "..SL("Mordor Base Potion").."]"
               .."item_image_button[4,4;1,1;lottpotion:glass_bottle_water;lottpotion:glass_bottle_water;]"
               .."item_image_button[5,4;1,1;lottplants:brambles_of_mordor;zcg:brambles_of_mordor;]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:glass_bottle_mordor;zcg:glass_bottle_mordor;]"
	end
     if page=="potionsN2" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potionsN3;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potionsN;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Orc Draught (Healing Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mordor;zcg:glass_bottle_mordor;]"
               .."item_image_button[5,2;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:orcdraught_corruption1;zcg:orcdraught_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:orcdraught_corruption1;zcg:orcdraught_corruption1;]"
               .."item_image_button[5,3;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:orcdraught_corruption2;zcg:orcdraught_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:orcdraught_corruption2;zcg:orcdraught_corruption2;]"
               .."item_image_button[5,4;1,1;lottmobs:rotten_meat;zcg:meat_raw;5]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:orcdraught_corruption3;zcg:orcdraught_corruption3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
     end
     if page=="potionsN3" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potionsN4;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potionsN2;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Spider Poison (Jump And Speed Boost Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mordor;zcg:glass_bottle_mordor;]"
               .."item_image_button[5,2;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:spiderpoison_corruption1;zcg:spiderpoison_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:spiderpoison_corruption1;zcg:spiderpoison_corruption1;]"
               .."item_image_button[5,3;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:spiderpoison_corruption2;zcg:spiderpoison_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:spiderpoison_corruption2;zcg:spiderpoison_corruption2;]"
               .."item_image_button[5,4;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:spiderpoison_corruption3;zcg:spiderpoison_corruption3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potionsN4" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potionsN5;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potionsN3;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Limpe (Breathing Underwater Block Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_obsidian;zcg:glass_bottle_obsidian;]"
               .."item_image_button[5,2;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:limpe_corruption1;zcg:limpe_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:limpe_corruption1;zcg:limpe_corruption1;]"
               .."item_image_button[5,3;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:limpe_corruption2;zcg:limpe_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:limpe_corruption2;zcg:limpe_corruption2;]"
               .."item_image_button[5,4;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:limpe_corruption3;zcg:limpe_corruption3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potionsN5" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potionsN6;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potionsN4;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Miruvor (Jump Block Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_obsidian;zcg:glass_bottle_obsidian;]"
               .."item_image_button[5,2;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:miruvor_corruption1;zcg:miruvor_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:miruvor_corruption1;zcg:miruvor_corruption1;]"
               .."item_image_button[5,3;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:miruvor_corruption2;zcg:miruvor_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:miruvor_corruption2;zcg:miruvor_corruption2;]"
               .."item_image_button[5,4;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:miruvor_corruption3;zcg:miruvor_corruption3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potionsN6" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image_button[7,1;1,1;zcg_next.png;potionsN7;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potionsN5;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Athelas Brew (Hurting Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_bonedust;zcg:glass_bottle_bonedust;]"
               .."item_image_button[5,2;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:athelasbrew_corruption1;zcg:athelasbrew_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:athelasbrew_corruption1;zcg:athelasbrew_corruption1;]"
               .."item_image_button[5,3;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:athelasbrew_corruption2;zcg:athelasbrew_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:athelasbrew_corruption2;zcg:athelasbrew_corruption2;]"
               .."item_image_button[5,4;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:athelasbrew_corruption3;zcg:athelasbrew_corruption3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
     if page=="potionsN7" then
		return "size[8,5.5]"
			   .."listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
               .."label[0,0;"..SL("Book of Potions").."]"
               .."button_exit[6,0;2,0.5;quit;"..SL("Exit").."]"
               .."image[7,1;1,1;zcg_next_inactive.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potionsN6;;false;false;zcg_previous_press.png]"
               .."label[0,1;"..SL("Ent Draught (Boost And Control Lose Potion):").."]"
               --First potion
               .."label[1,2.2; "..SL("Power Level")..": -1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_bonedust;zcg:glass_bottle_bonedust;]"
               .."item_image_button[5,2;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:entdraught_corruption1;zcg:entdraught_corruption1;]"
               --Second
               .."label[1,3.2; "..SL("Power Level")..": -2]"
               .."item_image_button[4,3;1,1;lottpotion:entdraught_corruption1;zcg:entdraught_corruption1;]"
               .."item_image_button[5,3;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:entdraught_corruption2;zcg:entdraught_corruption2;]"
               --Third
               .."label[1,4.2; "..SL("Power Level")..": -3]"
               .."item_image_button[4,4;1,1;lottpotion:entdraught_corruption2;zcg:entdraught_corruption2;]"
               .."item_image_button[5,4;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:entdraught_corruption3;zcg:entdraught_corruption3;]"
               .."background[5,5;1,1;craft_formbg.png;true]"
	end
end

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if fields.potions then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions"))
	end
     if fields.potions2 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions2"))
	end
     if fields.potions3 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions3"))
	end
     if fields.potions4 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions4"))
	end
     if fields.potions5 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions5"))
	end
     if fields.potions6 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions6"))
	end
     if fields.potions7 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions7"))
	end
	--Negative-potions--
     if fields.potionsN then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potionsN"))
	end
     if fields.potionsN2 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potionsN2"))
	end
     if fields.potionsN3 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potionsN3"))
	end
     if fields.potionsN4 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potionsN4"))
	end
     if fields.potionsN5 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potionsN5"))
	end
     if fields.potionsN6 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potionsN6"))
	end
     if fields.potionsN7 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potionsN7"))
	end
end)

minetest.register_tool("lottinventory:potions_book",{
    description = SL("Book of Potions"),
    inventory_image = "lottinventory_potion_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    groups = {cook_crafts=1, book=1, paper=1},
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            fleshy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
            snappy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
            choppy={times={[3]=0.90}, uses=20, maxlevel=0}
        }
    },
    on_use = function(itemstack, player, pointed_thing)
          inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions"))
          return itemstack; -- nothing consumed, nothing changed
    end,
})
