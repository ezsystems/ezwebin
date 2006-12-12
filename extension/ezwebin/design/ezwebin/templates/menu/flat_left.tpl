<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

		<h4>{$module_result.path[$pagerootdepth].text}</h4>
	
{if ne( $module_result.content_info.class_identifier, 'documentation_page' )}
   {def $root_node=fetch( 'content', 'node', hash( 'node_id', $module_result.path[$pagerootdepth].node_id ) )
	    $left_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
	 												  'sort_by', $root_node.sort_array,
													  'class_filter_type', 'include',
													  'class_filter_array', array( 'folder', 'forum', 'documentation_page', 'gallery', 'feedback_form', 'forums', 'event_calendar' ) ) )
	     $left_menu_items_count = $left_menu_items|count()
		 $li_class = array()
		 $a_class = array()
		 $current_node_in_path_2 = cond(and($current_node_id, $pagedepth|gt($pagerootdepth|inc)), $path_array[$pagerootdepth].node_id, 0  )
		 $current_node_in_path_3 = cond(and($current_node_id, $pagedepth|gt($pagerootdepth|sum(2))), $path_array[$pagerootdepth|inc].node_id, 0  )}
	
		{if $left_menu_items_count}
        <ul class="menu-list">
       {foreach $left_menu_items as $key => $item}
            {set $a_class = cond($current_node_in_path_2|eq($item.node_id), array("selected"), array())
                 $li_class = cond( $key|eq(0), array("firstli"), array() )}

            {if $left_menu_items_count|eq( $key|inc )}
                {set $li_class = $li_class|append("lastli")}
            {/if}
            {if $item.node_id|eq( $current_node_id )}
                {set $a_class = $a_class|append("current")}
            {/if}
	   		<li{if $li_class} class="{$li_class|implode(" ")}"{/if}><div class="second_level_menu"><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$item.name|wash()}</a></div>

	   		{if and( is_set( $module_result.path[$pagerootdepth|inc].node_id ), $item.node_id, eq( $module_result.path[$pagerootdepth|inc].node_id, $item.node_id ) )}
	   		{def $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
																	 'sort_by', $item.sort_array,
													  				 'class_filter_type', 'include',
													  				 'class_filter_array', array( 'folder', 'forum', 'documentation_page', 'gallery', 'feedback_form', 'forums', 'event_calendar' ) ) )
			     $sub_menu_items_count = $sub_menu_items|count}
			{if $sub_menu_items_count}
			<ul class="submenu-list">
	   		{foreach $sub_menu_items as $subkey => $subitem}
	   		    {set $a_class = cond($current_node_in_path_3|eq($subitem.node_id), array("selected"), array())
                     $li_class = cond( $subkey|eq(0), array("firstli"), array() )}
                {if $sub_menu_items_count|eq( $subkey|inc )}
                    {set $li_class = $li_class|append("lastli")}
                {/if}
                {if $subitem.node_id|eq( $current_node_id )}
                    {set $a_class = $a_class|append("current")}
                {/if}
				<li{if $li_class} class="{$li_class|implode(" ")}"{/if}><div class="third_level_menu"><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$subitem.name|wash()}</a></div></li>
	   		{/foreach}
	   		</ul>
	   		{/if}
            {undef $sub_menu_items $sub_menu_items_count}
	   		{/if}
	   		</li>
	   {/foreach}
	    </ul>
	    {/if}
   {undef $root_node $left_menu_items $left_menu_items_count $a_class $li_class $current_node_in_path_2 $current_node_in_path_3}
{else}

	<div class="boxcontent">
		<map id="contentstructure">

   {def $current_node=fetch( content, node, hash( node_id, $module_result.node_id ) )
	    $chapter_container=fetch( content, node, hash( node_id, $current_node.path_array[$pagerootdepth|inc] ) )
        $class_filter=ezini( 'TreeMenu', 'ShowClasses', 'contentstructuremenu.ini' )
        $depth=is_set( $current_node.path_array[$pagerootdepth|sum(2)] )|choose( $pagerootdepth|sum(3), 0 )
        $node_to_unfold=is_set( $current_node.path_array[$pagerootdepth|sum(2)] )|choose(0 , $current_node.path_array[$pagerootdepth|sum(2)] )
        $contentStructureTree = content_structure_tree( $chapter_container.node_id, $class_filter, $depth, 0, 'false', false(), $node_to_unfold )}

	{include uri='design:simplified_treemenu/show_simplified_menu.tpl' contentStructureTree=$contentStructureTree is_root_node=true() skip_self_node=true() current_node_id=$module_result.node_id unfold_node=$node_to_unfold chapter_level=0}

    {undef $current_node $chapter_container $class_filter $depth $node_to_unfold $contentStructureTree}
		</map>
	</div>
{/if}
</div></div></div></div></div>
</div>