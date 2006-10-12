<div class="topmenu-design">
    <!-- Top menu content: START -->
	<ul>
	{def $root_node=fetch( 'content', 'node', hash( 'node_id', 2 ) )
		 $top_menu_items=fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
		 												 'sort_by', $root_node.sort_array ) )}
		{foreach $top_menu_items as $item}
			{if eq( $item.class_identifier, 'link')}
			<li><a href={$item.data_map.location.content|ezurl}>{$item.name|wash()}</a></li>
			{else}
      		<li {if and(gt($module_result.path|count, 1), eq( $item.node_id, $module_result.path[1].node_id ))}class="selected"{/if}><a href={$item.url_alias|ezurl}>{$item.name}</a></li>
			{/if}
	  	{/foreach}
	{undef $top_menu_items $root_node}
    </ul>
    <!-- Top menu content: END -->
</div>