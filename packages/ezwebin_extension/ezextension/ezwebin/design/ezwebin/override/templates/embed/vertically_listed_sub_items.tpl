<div class="content-view-embed">

    <h2>{$object.name|wash()}</h2>
	
		<div class="box-embgv">
		<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
	{def $children = array()
	     $limit = 3
	     $offset = 0}

	{if is_set( $object_parameters.limit )}
		{set $limit = $object_parameters.limit}
	{/if}

	{if is_set( $object_parameters.offset )}
		{set $offset = $object_parameters.offset}
	{/if}
	
    {set $children=fetch( content, list, hash( 'parent_node_id', $object.main_node_id, 
											   'limit', $limit,
											   'offset', $offset,
											   'sort_by', $object.main_node.sort_array ) ) }

	<div class="content-view-children float-break">
	{if $children|count()}
    {foreach $children as $child}
         {node_view_gui view=line content_node=$child}
    {/foreach}
	{/if}
    </div>
	
			</div></div></div></div></div>
		</div>
</div>