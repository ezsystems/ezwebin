{def $root_node=fetch( 'content', 'node', hash( 'node_id', $module_result.path[1].node_id ) )
	 $left_menu_items=fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
	 												  'sort_by', $root_node.sort_array,
													  'class_filter_type', 'include',
													  'class_filter_array', array( 'folder', 'forum', 'documentation_page', 'gallery', 'feedback_form', 'forums', 'event_calender' ) ) )}
<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

		<h4>{$module_result.path[1].text}</h4>
	
	{if ne( $module_result.content_info.class_identifier, 'documentation_page' )}
	
		{if $left_menu_items|count}
        <ul class="menu-list">
       {foreach $left_menu_items as $item}
	   		<li><div><a href={$item.url_alias|ezurl} {if eq( $item.node_id, $module_result.path[2].node_id )}class="selected"{/if}>{$item.name}</a></div>

	   		{if and( is_set( $module_result.path[2].node_id ), $item.node_id, eq( $module_result.path[2].node_id, $item.node_id ) )}
	   		{def $left_menu_subitems=fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
																	 'sort_by', $item.sort_array,
													  				 'class_filter_type', 'include',
													  				 'class_filter_array', array( 'folder', 'forum', 'documentation_page', 'gallery', 'feedback_form', 'forums', 'event_calender' ) ) )}
			{if $left_menu_subitems|count}
			<ul class="submenu-list">
	   		{foreach $left_menu_subitems as $subitem}
				<li><div><a href={$subitem.url_alias|ezurl} {if eq( $subitem.node_id, $module_result.path[3].node_id )}class="selected"{/if}>{$subitem.name}</a></div></li>
	   		{/foreach}
	   		</ul>
	   		{/if}

	   		{/if}
	   		</li>
	   {/foreach}
	    </ul>
	    {/if}
	
	{else}

		<div class="boxcontent">

		<map id="contentstructure">

{def $current_node=fetch( content, node, hash( node_id, $module_result.node_id ) )
	 $chapter_container=fetch( content, node, hash( node_id, $current_node.path_array[2] ) )
     $class_filter=ezini( 'TreeMenu', 'ShowClasses', 'contentstructuremenu.ini' )
     $depth=is_set( $current_node.path_array[3] )|choose( 4, 0 )
     $node_to_unfold=is_set( $current_node.path_array[3] )|choose(0 , $current_node.path_array[3] )
     $contentStructureTree = content_structure_tree( $chapter_container.node_id, $class_filter, $depth, 0, 'false', false(), $node_to_unfold )}

	{include uri='design:simplified_treemenu/show_simplified_menu.tpl' contentStructureTree=$contentStructureTree is_root_node=true() skip_self_node=true() current_node_id=$module_result.node_id unfold_node=$node_to_unfold chapter_level=0}

		</map>

		</div>
	{/if}
</div></div></div></div></div>
</div>