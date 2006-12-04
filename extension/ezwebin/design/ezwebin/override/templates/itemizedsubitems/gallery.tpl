<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

<div class="content-view-embed">
	<div class="class-gallery">
	{def $children = array()
	     $limit = 5
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
											   'class_filter_type', 'include',
											   'class_filter_array', array( 'image' ),
											   'sort_by', $object.main_node.sort_array ) ) }
    <h2><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash()}</a></h2>
	
	{if $children|count()}

	<ul>
    {foreach $children as $child}
       <li><div><a href={$child.url_alias|ezurl}>{$child.name|wash()}</a></div></li>
    {/foreach}
    </ul>
	
	{/if}
	</div>
</div>

</div></div></div></div></div>
</div>