<div class="topmenu-design">
    <!-- Top menu content: START -->
	<ul>
    {def $root_node=fetch( 'content', 'node', hash( 'node_id', $indexpage ) )
         $top_menu_items=fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
		 												 'sort_by', $root_node.sort_array ) )}
    {set $pagerootdepth = $root_node.depth}
    {if $top_menu_items|gt(0)}
       {foreach $top_menu_items as $item}
            {if eq( $item.class_identifier, 'link')}
            <li id="node_id_{$item.node_id}"><div><a href={$item.data_map.location.content|ezurl} target="_blank">{$item.name|wash()}</a></div></li>
            {else}
      		<li id="node_id_{$item.node_id}" {if and(gt($module_result.path|count, $pagerootdepth), eq( $item.node_id, $module_result.path[$pagerootdepth].node_id ))}class="selected"{/if}><div><a href={$item.url_alias|ezurl}>{$item.name}</a></div></li>
    		{/if}
      	{/foreach}
    {/if}
    {undef $top_menu_items $root_node}
    </ul>
    <!-- Top menu content: END -->
</div>