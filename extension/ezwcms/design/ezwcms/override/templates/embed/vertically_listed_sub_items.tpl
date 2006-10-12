<div class="content-view-embed">
	
    <h2>{$object.name|wash()}</h2>
	
		<div class="box-embgv">
			<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
	
    {def $children=fetch( content, list, hash( 'parent_node_id', $object.main_node_id, 
											   'limit', 3,
											   'sort_by', $object.main_node.sort_array ) ) }

	<div class="content-view-children">
    {foreach $children as $child}
         {node_view_gui view=line content_node=$child}
    {/foreach}
    </div>
	
			</div></div></div></div></div>
		</div>
</div>