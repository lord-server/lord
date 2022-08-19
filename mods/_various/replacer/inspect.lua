
replacer.image_replacements = {};

-- support for RealTest
if(    minetest.get_modpath("trees")
   and minetest.get_modpath("core")
   and minetest.get_modpath("instruments")
   and minetest.get_modpath("anvil")
   and minetest.get_modpath("scribing_table")) then
	replacer.image_replacements[ "group:planks" ] = "trees:pine_planks";
	replacer.image_replacements[ "group:plank"  ] = "trees:pine_plank";
	replacer.image_replacements[ "group:wood"   ] = "trees:pine_planks";
	replacer.image_replacements[ "group:tree"   ] = "trees:pine_log";
	replacer.image_replacements[ "group:sapling"] = "trees:pine_sapling";
	replacer.image_replacements[ "group:leaves" ] = "trees:pine_leaves";
	replacer.image_replacements[ "default:furnace" ] = "oven:oven";
	replacer.image_replacements[ "default:furnace_active" ] = "oven:oven_active";
end

minetest.register_tool( "replacer:inspect",
{
    description = "Node inspection tool",
    groups = {}, 
    inventory_image = "replacer_inspect.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    liquids_pointable = true, -- it is ok to request information about liquids
--[[
    -- the tool_capabilities are of no intrest here; it is not for digging
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            fleshy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            snappy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            choppy={times={[3]=0.90}, maxwear=0.05, maxlevel=0}
        }
    },
--]]
    node_placement_prediction = nil,

    on_use = function(itemstack, user, pointed_thing)

       return replacer.inspect( itemstack, user, pointed_thing, nil, true ); --false );
    end,

    on_place = function(itemstack, placer, pointed_thing)

       return replacer.inspect( itemstack, placer, pointed_thing, nil, true );
    end,
})


replacer.inspect = function( itemstack, user, pointed_thing, mode, show_receipe )

	if( user == nil or pointed_thing == nil) then
		return nil;
	end
	local name = user:get_player_name();
	local keys = user:get_player_control();
	if( keys["sneak"] or keys["aux1"]) then
		show_receipe = true;
	end
 
	if(     pointed_thing.type == 'object' ) then
		local text = 'This is ';
		local ref = pointed_thing.ref;
		if( not( ref )) then
			text = text..'a borken object. We have no further information about it. It is located';
		elseif( ref:is_player()) then
			text = text..'your fellow player \"'..tostring( ref:get_player_name() )..'\"';
		else
			local luaob = ref:get_luaentity();
			if( luaob and luaob.get_staticdata) then
				text = text..'entity \"'..tostring( luaob.name )..'\"';
				local sdata = luaob:get_staticdata();
				if( sdata ) then
					sdata = minetest.deserialize( sdata );
					if( sdata.itemstring ) then
						text = text..' ['..tostring( sdata.itemstring )..']';
						if( show_receipe ) then
							-- the fields part is used here to provide additional information about the entity
							replacer.inspect_show_crafting( name, sdata.itemstring, { pos=pos, luaob=luaob} );
						end
					end
					if( sdata.age ) then
						text = text..', dropped '..tostring( math.floor( sdata.age/60 ))..' minutes ago';
					end
				end
			else
				text = text..'object \"'..tostring( ref:get_entity_name() )..'\"';
			end

		end
		text = text..' at '..minetest.pos_to_string( ref:get_pos() );
		minetest.chat_send_player( name, text );
		return nil;
	elseif( pointed_thing.type ~= 'node' ) then
		minetest.chat_send_player( name, 'Sorry. This is an unkown something of type \"'..tostring( pointed_thing.type )..'\". No information available.');
		return nil;
	end
	
	local pos  = minetest.get_pointed_thing_position( pointed_thing, mode );
	local node = minetest.get_node_or_nil( pos );
       
	if( node == nil ) then
		minetest.chat_send_player( name, "Error: Target node not yet loaded. Please wait a moment for the server to catch up.");
		return nil;
	end

	local text = ' ['..tostring( node.name )..'] with param2='..tostring( node.param2 )..' at '..minetest.pos_to_string( pos )..'.';	
	if( not( minetest.registered_nodes[ node.name ] )) then
		text = 'This node is an UNKOWN block'..text;
	else
		text = 'This is a \"'..tostring( minetest.registered_nodes[ node.name ].description or ' - no description provided -')..'\" block'..text;
	end
	local protected_info = "";
	if( minetest.is_protected(     pos, name )) then
		protected_info = 'WARNING: You can\'t dig this node. It is protected.';
	elseif( minetest.is_protected( pos, '_THIS_NAME_DOES_NOT_EXIST_' )) then
		protected_info = 'INFO: You can dig this node, but others can\'t.';
	end
	text = text..' '..protected_info;
-- no longer spam the chat; the craft guide is more informative
--	minetest.chat_send_player( name, text );
	
	if( show_receipe ) then
		-- get light of the node at the current time
		local light = minetest.get_node_light(pos, nil);
		if( light==0 ) then
			light = minetest.get_node_light( {x=pos.x,y=pos.y+1,z=pos.z});
		end
		-- the fields part is used here to provide additional information about the node
		replacer.inspect_show_crafting( name, node.name, {pos=pos, param2=node.param2, light=light, protected_info=protected_info} );
	end
	return nil; -- no item shall be removed from inventory
end

-- some common groups
replacer.group_placeholder = {};
replacer.group_placeholder[ 'group:wood'  ] = 'default:wood';
replacer.group_placeholder[ 'group:tree'  ] = 'default:tree';
replacer.group_placeholder[ 'group:sapling']= 'default:sapling';
replacer.group_placeholder[ 'group:stick' ] = 'default:stick';
replacer.group_placeholder[ 'group:stone' ] = 'default:cobble'; -- 'default:stone';  point people to the cheaper cobble
replacer.group_placeholder[ 'group:sand'  ] = 'default:sand';
replacer.group_placeholder[ 'group:leaves'] = 'default:leaves';
replacer.group_placeholder[ 'group:wood_slab'] = 'stairs:slab_wood';
replacer.group_placeholder[ 'group:wool'  ] = 'wool:white';


-- handle the standard dye color groups
if( minetest.get_modpath("dye") and dye and dye.basecolors) then
	for i,color in ipairs( dye.basecolors ) do
		local def = minetest.registered_items[ "dye:"..color ];
		if( def and def.groups ) then
			for k,v in pairs( def.groups ) do
				if( k ~= 'dye' ) then
					replacer.group_placeholder[ 'group:dye,'..k ] = 'dye:'..color;
				end
			end
			replacer.group_placeholder[ 'group:flower,color_'..color ] = 'dye:'..color;
		end
	end
end 

replacer.image_button_link = function( stack_string )
	local group = '';
	if( replacer.image_replacements[ stack_string ] ) then
		stack_string = replacer.image_replacements[ stack_string ];
	end
	if( replacer.group_placeholder[ stack_string ] ) then
		stack_string = replacer.group_placeholder[ stack_string ];
		group = 'G';
	end		
-- TODO: show information about other groups not handled above
	local stack = ItemStack( stack_string );
	local new_node_name = stack_string;
	if( stack and stack:get_name()) then
		new_node_name = stack:get_name();
	end
	return tostring( stack_string )..';'..tostring( new_node_name )..';'..group;
end

replacer.add_circular_saw_receipe = function( node_name, receipes )
	if( not( node_name ) or not( minetest.get_modpath("moreblocks")) or not( circular_saw ) or not( circular_saw.names) or (node_name=='moreblocks:circular_saw')) then
		return;
	end
	local help = node_name:split( ':' );
	if( not( help ) or #help ~= 2 or help[1]=='stairs') then
		return;
	end
	help2 = help[2]:split('_');
	if( not( help2 ) or #help2 < 2 or (help2[1]~='micro' and help2[1]~='panel' and help2[1]~='stair' and help2[1]~='slab')) then
		return;
	end
--	for i,v in ipairs( circular_saw.names ) do
--		modname..":"..v[1].."_"..material..v[2]

-- TODO: write better and more correct method of getting the names of the materials
-- TODO: make sure only nodes produced by the saw are listed here
help[1]='default';
	local basic_node_name = help[1]..':'..help2[2];
	-- node found that fits into the saw
	receipes[ #receipes+1 ] = { method = 'saw',          type = 'saw',          items = { basic_node_name }, output = node_name};
	return receipes;
end

replacer.add_colormachine_receipe = function( node_name, receipes )
	if( not( minetest.get_modpath("colormachine")) or not( colormachine )) then
		return;
	end
	local res = colormachine.get_node_name_painted( node_name, "" );

	if( not( res) or not( res.possible  ) or #res.possible < 1 ) then
		return;
	end
	-- paintable node found
	receipes[ #receipes+1 ] = { method = 'colormachine', type = 'colormachine', items = { res.possible[1] }, output = node_name};
	return receipes;
end


replacer.inspect_show_crafting = function( name, node_name, fields )
	if( not( name )) then
		return;
	end

	local receipe_nr = 1;
	if( not( node_name )) then
		node_name  = fields.node_name;
		receipe_nr = tonumber(fields.receipe_nr);
	end
	-- turn it into an item stack so that we can handle dropped stacks etc
	local stack = ItemStack( node_name );
	node_name = stack:get_name();

	-- the player may ask for receipes of indigrents to the current receipe
	if( fields ) then
		for k,v in pairs( fields ) do
			if( v and v=="" and (minetest.registered_items[ k ]
			                 or  minetest.registered_nodes[ k ]
			                 or  minetest.registered_craftitems[ k ]
			                 or  minetest.registered_tools[ k ] )) then
				node_name = k;
				receipe_nr = 1;
			end
		end
	end

	local res = minetest.get_all_craft_recipes( node_name );
	if( not( res )) then
		res = {};
	end
	-- add special receipes for nodes created by machines
	replacer.add_circular_saw_receipe( node_name, res );
	replacer.add_colormachine_receipe( node_name, res );

	-- offer all alternate creafting receipes thrugh prev/next buttons
	if(     fields and fields.prev_receipe and receipe_nr > 1 ) then
		receipe_nr = receipe_nr - 1;
	elseif( fields and fields.next_receipe and receipe_nr < #res ) then
		receipe_nr = receipe_nr + 1;
	end

	local desc = nil;
	if(     minetest.registered_nodes[ node_name ] ) then
		if(     minetest.registered_nodes[ node_name ].description
		    and minetest.registered_nodes[ node_name ].description~= "") then
			desc = "\""..minetest.registered_nodes[ node_name ].description.."\" block";
		elseif( minetest.registered_nodes[ node_name ].name ) then
			desc = "\""..minetest.registered_nodes[ node_name ].name.."\" block";
		else
			desc = " - no description provided - block";
		end
	elseif( minetest.registered_items[ node_name ] ) then
		if(     minetest.registered_items[ node_name ].description 
		    and minetest.registered_items[ node_name ].description~= "") then
			desc = "\""..minetest.registered_items[ node_name ].description.."\" item";
		elseif( minetest.registered_items[ node_name ].name ) then
			desc = "\""..minetest.registered_items[ node_name ].name.."\" item";
		else
			desc = " - no description provided - item";
		end
	end
	if( not( desc ) or desc=="") then
		desc = ' - no description provided - ';
	end
		
	local formspec = "size[6,6]"..
		"label[0,5.5;This is a "..minetest.formspec_escape( desc )..".]"..
		"button_exit[5.0,4.3;1,0.5;quit;Exit]"..
		"label[0,0;Name:]"..
		"field[20,20;0.1,0.1;node_name;node_name;"..node_name.."]".. -- invisible field for passing on information
		"field[21,21;0.1,0.1;receipe_nr;receipe_nr;"..tostring( receipe_nr ).."]".. -- another invisible field
		"label[1,0;"..tostring( node_name ).."]"..
		"item_image_button[5,2;1.0,1.0;"..tostring( node_name )..";normal;]";

	-- provide additional information regarding the node in particular that has been inspected
	if( fields.pos ) then
		formspec = formspec.."label[0.0,0.3;Located at "..
			minetest.formspec_escape( minetest.pos_to_string( fields.pos ));
		if( fields.param2 ) then
			formspec = formspec.." with param2="..tostring( fields.param2 );
		end
		if( fields.light ) then
			formspec = formspec.." and receiving "..tostring( fields.light ).." light";
		end
		formspec = formspec..".]";	
	end

	-- show information about protection
	if( fields.protected_info and fields.protected_info ~= "" ) then
		formspec = formspec.."label[0.0,4.5;"..minetest.formspec_escape( fields.protected_info ).."]";
	end

	if( not( res ) or receipe_nr > #res or receipe_nr < 1 ) then
		receipe_nr = 1;
	end
	if( res and receipe_nr > 1 ) then
		formspec = formspec.."button[3.8,5;1,0.5;prev_receipe;prev]";
	end
	if( res and receipe_nr < #res ) then
		formspec = formspec.."button[5.0,5.0;1,0.5;next_receipe;next]";
	end
	if( not( res ) or #res<1) then
		formspec = formspec..'label[3,1;No receipes.]';
		if(   minetest.registered_nodes[ node_name ]
		  and minetest.registered_nodes[ node_name ].drop ) then
			local drop = minetest.registered_nodes[ node_name ].drop;
			if( drop ) then
				if(     type( drop )=='string' and drop ~= node_name ) then
					formspec = formspec.."label[2,1.6;Drops on dig:]"..
						"item_image_button[2,2;1.0,1.0;"..replacer.image_button_link( drop ).."]";
				elseif( type( drop )=='table' and drop.items ) then
					local droplist = {};
					for _,drops in ipairs( drop.items ) do
						for _,item in ipairs( drops.items ) do
							-- avoid duplicates; but include the item itshelf
							droplist[ item ] = 1;
						end
					end
					local i = 1;
					formspec = formspec.."label[2,1.6;May drop on dig:]";
					for k,v in pairs( droplist ) do
						formspec = formspec..
							"item_image_button["..(((i-1)%3)+1)..","..math.floor(((i-1)/3)+2)..";1.0,1.0;"..replacer.image_button_link( k ).."]";
						i = i+1;
					end
				end
			end
		end
	else
		formspec = formspec.."label[1,5;Alternate "..tostring( receipe_nr ).."/"..tostring( #res ).."]";
		-- reverse order; default receipes (and thus the most intresting ones) are usually the oldest
		local receipe = res[ #res+1-receipe_nr ];
		if(     receipe.type=='normal'  and receipe.items) then
			local width = receipe.width;
			if( not( width ) or width==0 ) then
				width = 3;
			end
			for i=1,9 do
				if( receipe.items[i] ) then
					formspec = formspec.."item_image_button["..(((i-1)%width)+1)..','..(math.floor((i-1)/width)+1)..";1.0,1.0;"..
							replacer.image_button_link( receipe.items[i] ).."]";
				end
			end
		elseif( receipe.type=='cooking' and receipe.items and #receipe.items==1
		    and receipe.output=="" ) then
			formspec = formspec.."item_image_button[1,1;3.4,3.4;"..replacer.image_button_link( 'default:furnace_active' ).."]".. --default_furnace_front.png]"..
					"item_image_button[2.9,2.7;1.0,1.0;"..replacer.image_button_link( receipe.items[1] ).."]"..
					"label[1.0,0;"..tostring(receipe.items[1]).."]"..
					"label[0,0.5;This can be used as a fuel.]";
		elseif( receipe.type=='cooking' and receipe.items and #receipe.items==1 ) then
			formspec = formspec.."item_image_button[1,1;3.4,3.4;"..replacer.image_button_link( 'default:furnace' ).."]".. --default_furnace_front.png]"..
					"item_image_button[2.9,2.7;1.0,1.0;"..replacer.image_button_link( receipe.items[1] ).."]";
		elseif( receipe.type=='colormachine' and receipe.items and #receipe.items==1 ) then
			formspec = formspec.."item_image_button[1,1;3.4,3.4;"..replacer.image_button_link( 'colormachine:colormachine' ).."]".. --colormachine_front.png]"..
					"item_image_button[2,2;1.0,1.0;"..replacer.image_button_link( receipe.items[1] ).."]";
		elseif( receipe.type=='saw'          and receipe.items and #receipe.items==1 ) then
			--formspec = formspec.."item_image[1,1;3.4,3.4;moreblocks:circular_saw]"..
			formspec = formspec.."item_image_button[1,1;3.4,3.4;"..replacer.image_button_link( 'moreblocks:circular_saw' ).."]"..
					"item_image_button[2,0.6;1.0,1.0;"..replacer.image_button_link( receipe.items[1] ).."]";
		else
			formspec = formspec..'label[3,1;Error: Unkown receipe.]';
		end
		-- show how many of the items the receipe will yield
		local outstack = ItemStack( receipe.output );
		if( outstack and outstack:get_count() and outstack:get_count()>1 ) then
			formspec = formspec..'label[5.5,2.5;'..tostring( outstack:get_count() )..']';
		end
	end
	minetest.show_formspec( name, "replacer:crafting", formspec );
end

-- translate general formspec calls back to specific calls
replacer.form_input_handler = function( player, formname, fields)
        if( formname and formname == "replacer:crafting" and player and not( fields.quit )) then
		replacer.inspect_show_crafting( player:get_player_name(), nil, fields );
                return;
        end
end

-- establish a callback so that input from the player-specific formspec gets handled
minetest.register_on_player_receive_fields( replacer.form_input_handler );


minetest.register_craft({
        output = 'replacer:inspect',
        recipe = {
                { 'default:torch' },
                { 'default:stick' },
        }
})
