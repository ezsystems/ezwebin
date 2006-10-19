{* Infobox - Full view *}

<div class="content-view-full">
    <div class="class-infobox">
		
		<div class="attribute-header">
			{attribute_view_gui attribute=$node.object.data_map.header}
		</div>
		
		<div class="attribute-image">
			{attribute_view_gui attribute=$node.object.data_map.image image_class='infoboximage'}
		</div>
		
		<div class="attribute-content">
			{attribute_view_gui attribute=$node.object.data_map.content}
		</div>
		
		<div class="attribute-url">
			{attribute_view_gui attribute=$node.object.data_map.url}
		</div>
		
    </div>
</div>