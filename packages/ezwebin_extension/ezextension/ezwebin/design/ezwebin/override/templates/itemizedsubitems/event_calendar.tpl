<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
	
<div class="content-view-embed">
	<div class="class-event-calendar">
	{def $children = array()
	     $limit = 5
	     $offset = 0
	     $curr_ts = currentdate()}

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
											   'class_filter_array', array( 'event' ),
			                                   'sort_by', array( 'attribute', true(), 'event/from_time' ),
											   'attribute_filter', array( 'or',
					                              array( 'event/from_time', '>=', $curr_ts  ),
					                              array( 'event/to_time', '>=', $curr_ts  )
			)	)) }
    <h2><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash()}</a></h2>
	
	{if $children|count()}
    
	<ul>
    {foreach $children as $child}
       <li>
	   		<a href={$child.url_alias|ezurl}>{$child.name|wash()}</a>
			<div class="attribute-byline float-break">
       			<p class="date">{$child.object.data_map.from_time.content.timestamp|datetime( 'custom', '%d %M %Y %H:%i' )}</p>
        		<p class="author">{attribute_view_gui attribute=$child.object.data_map.category}</p>
    		</div>
	   </li>
    {/foreach}
    </ul>
	
	{/if}
	</div>
</div>

</div></div></div></div></div>
</div>