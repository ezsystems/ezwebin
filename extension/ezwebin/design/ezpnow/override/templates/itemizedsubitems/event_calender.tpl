<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
	
<div class="content-view-embed">
	<div class="class-event-calender">
	
    {def $children=fetch( content, list, hash( 'parent_node_id', $object.main_node_id, 
											   'limit', 5,
											   'class_filter_type', 'include',
											   'class_filter_array', array( 'event' ),
											   'sort_by', array( 'attribute', false(), 'event/from_time' ) ) ) }
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