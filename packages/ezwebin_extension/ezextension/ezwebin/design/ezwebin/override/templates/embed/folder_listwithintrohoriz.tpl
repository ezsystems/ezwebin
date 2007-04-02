<div class="content-view-embed">
    <div class="class-folder">
    {def $children=fetch_alias( children, hash( parent_node_id, $object.main_node_id, limit, 5 ) ) }
	
    <h2>{$object.name|wash()}</h2>
	<div class="box">
	<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
	
	<div class="attribute-short">
    	{attribute_view_gui attribute=$object.data_map.short_description}
	</div>
	
    {foreach $children as $child}
         <a href={$child.url_alias|ezurl}>{$child.name}</a>

         {delimiter modulo=4}
         	<br />
         {/delimiter}
    {/foreach}
	</div></div></div></div></div>
	</div>
   </div>
</div>