<div class="content-view-embed">
    {def $children=fetch( content, tree, hash( 'parent_node_id', $object.main_node_id, 
											   'limit', 5,
											   'sort_by', $object.main_node.sort_array ) ) }
    <h2>{$object.name|wash()}</h2>
		<div class="box">
	<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">
    <ul>
    {foreach $children as $child}
       <li><a href={$child.url_alias|ezurl}>{$child.name|wash()}</a></li>
    {/foreach}
    </ul>
	</div></div></div></div></div>
	</div>
</div>