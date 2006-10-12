{include uri='design:parts/editor_toolbar.tpl'}

{def $frontpagestyle='noleftcolumn norightcolumn'}


{if $node.object.data_map.left_column.has_content}
	{set $frontpagestyle='leftcolumn norightcolumn'}
{/if}

{if eq( $frontpagestyle, 'leftcolumn norightcolumn')}
	{if $node.object.data_map.right_column.has_content}
		{set $frontpagestyle='leftcolumn rightcolumn'}
	{/if}
{else}	
	{if $node.object.data_map.right_column.has_content}
		{set $frontpagestyle='noleftcolumn rightcolumn'}
	{/if}
{/if}


<div class="content-view-full">
	<div class="class-frontpage {$frontpagestyle}">

	<div class="attribute-billboard">
		{content_view_gui view=billboard content_object=$node.object.data_map.billboard.content}
	</div>

	<div class="columns-frontpage">
		<div class="left-column-position">
			<div class="left-column">
        	<!-- Content: START -->
       			{attribute_view_gui attribute=$node.object.data_map.left_column}
        	<!-- Content: END -->
			</div>
		</div>
    	<div class="center-column-position">
			<div class="center-column float-break">
				<div class="overflow-fix">
        		<!-- Content: START -->
        			{attribute_view_gui attribute=$node.object.data_map.center_column}
        		<!-- Content: END -->
        		</div>
			</div>
		</div>
    	<div class="right-column-position">
			<div class="right-column">
        	<!-- Content: START -->
      			{attribute_view_gui attribute=$node.object.data_map.right_column}
        	<!-- Content: END -->
			</div>
		</div>
	</div>

	<div class="attribute-bottom-column">
		{attribute_view_gui attribute=$node.object.data_map.bottom_column}
	</div>

	</div>
</div>
