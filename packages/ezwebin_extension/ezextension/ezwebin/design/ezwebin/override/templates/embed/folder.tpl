<div class="content-view-embed">
	<div class="class-folder">
	
    {def $children=fetch( content, list, hash( 'parent_node_id', $object.main_node_id, 
											   'limit', 5,
											   'sort_by', $object.main_node.sort_array ) ) }
    <h2><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash()}</a></h2>
	
	{if $children|count()}
	<div class="box">
	<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
    
	<ul>
    {foreach $children as $child}
       <li><a href={$child.url_alias|ezurl}>{$child.name|wash()}</a></li>
    {/foreach}
    </ul>
	
	</div></div></div></div></div>
	</div>
	{/if}
	</div>
</div>