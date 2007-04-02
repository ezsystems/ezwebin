<div class="content-view-embed">
	{def $children = array()
	     $limit = 5
	     $offset = 0}

	{if is_set( $object_parameters.limit )}
		{set $limit = $object_parameters.limit}
	{/if}

	{if is_set( $object_parameters.offset )}
		{set $offset = $object_parameters.offset}
	{/if}

    {set $children=fetch( 'content', 'tree', hash( 'parent_node_id', $object.main_node_id, 
											       'limit', $limit,
											       'offset', $offset,
											       'sort_by', $object.main_node.sort_array ) ) }
    <h2>{$object.name|wash()}</h2>
	<div class="box">
	<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
	
	{if $children|count()}
    
	<ul>
    {foreach $children as $child}
       <li><a href={$child.url_alias|ezurl}>{$child.name|wash()}</a></li>
    {/foreach}
    </ul>
	
	{/if}
	</div></div></div></div></div>
	</div>
</div>