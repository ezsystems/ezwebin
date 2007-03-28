<div class="content-view-line">
    <div class="class-infobox">
        <div class="attribute-header">
            <h2>{attribute_view_gui attribute=$node.object.data_map.header}</h2>
        </div>
        <div class="attribute-content">
			{if $node.object.data_map.image.has_content}
            <div class="attribute-image"> 
				{attribute_view_gui attribute=$node.object.data_map.image href=$node.object.data_map.image_url.data_text image_class=articlethumbnail} 
			</div>
			{/if}
            
			{attribute_view_gui attribute=$node.object.data_map.content}
            
			<div class="attribute-url">
				<p>{attribute_view_gui attribute=$node.object.data_map.url}</p>
			</div>
			
			{if or( $node.object.can_edit, $node.object.can_remove)}
			<div class="controls">
			<form action={"/content/action"|ezurl} method="post">
				{if $node.object.can_edit}
					<input type="image" name="EditButton" src={"edit_ico.png"|ezimage} alt="Edit" />
					<input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
				{/if}
				 
				{if $node.object.can_remove}
					<input type="image" name="ActionRemove" src={"trash.png"|ezimage} alt="Remove" />
				{/if}
				  	<input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
  					<input type="hidden" name="NodeID" value="{$node.node_id}" />
  					<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
			</form>
			</div>
			{/if}
			
        </div>
    </div>
</div>