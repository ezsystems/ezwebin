<div class="content-view-embed">
	<div class="class-gallery">
	
    {def $children=fetch( content, list, hash( 'parent_node_id', $object.main_node_id, 
											   'limit', 5,
											   'class_filter_type', 'include',
											   'class_filter_array', array( 'image' ),
											   'sort_by', $object.main_node.sort_array ) ) }
    <h2><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash()}</a></h2>
	
	{if $children|count()}
	<div class="box-em">
	<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
    

    {foreach $children as $child}
			<div class="attribute-image">
       			{attribute_view_gui href=$child.url_alias|ezurl() image_class=articlethumbnail attribute=$child.object.data_map.image}
    		</div>
			<div class="attribute-image-cpation">
				{attribute_view_gui attribute=$child.object.data_map.caption}
			</div>
			<div class="break"></div>
    {/foreach}
	
	</div></div></div></div></div>
	</div>
	{/if}
	</div>
</div>