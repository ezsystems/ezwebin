{* Folder - Full view *}

{include uri='design:parts/editor_toolbar.tpl'}

<div class="box-mc">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-view-full">
    <div class="class-folder">

		<div class="attribute-header">
        	<h1>{attribute_view_gui attribute=$node.data_map.name}</h1>
		</div>
		
        {if $node.object.data_map.short_description.has_content}
            <div class="attribute-short">
                {attribute_view_gui attribute=$node.data_map.short_description}
            </div>
        {/if}

        {if $node.object.data_map.description.has_content}
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.description}
            </div>
        {/if}

        {if $node.object.data_map.show_children.data_int}
            {def $page_limit=10
				 $classes=array( 'infobox' )
				 $children=array()
				 $children_count=''}
				 
			{if le( $node.depth, '3')}
				{set $classes=array( 'infobox', 'folder' )}
			{/if}
			
            {set $children=fetch_alias( 'children', hash( parent_node_id, $node.node_id,
                                                             offset, $view_parameters.offset,
                                                             sort_by, $node.sort_array,
                                                             class_filter_type, exclude,
                                                             class_filter_array, $classes,
                                                             limit, $page_limit ) )
                 $children_count=fetch_alias( 'children_count', hash( parent_node_id, $node.node_id,
                                                             class_filter_type, exclude,
                                                             class_filter_array, $classes ) )}

            <div class="content-view-children">
                {foreach $children as $child }
                    {node_view_gui view='line' content_node=$child}
                {/foreach}
            </div>

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

        {/if}
    </div>
</div>

</div></div></div></div></div>
</div>