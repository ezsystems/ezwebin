<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

<div class="content-view-embed">
	<div class="class-forum">
	
    {def $children=fetch( content, list, hash( 'parent_node_id', $object.main_node_id, 
											   'limit', 5,
											   'sort_by', array( 'modified_subnode', false() ) ) ) }
    <h2><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash()}</a></h2>
	
	{if $children|count()}
    
	<ul>
    {foreach $children as $child}
       <li>
	   		<a href={$child.url_alias|ezurl}>{$child.name|wash()}</a>
			<div class="attribute-byline float-break">
       			<p class="date">{$child.object.published|datetime( 'custom', '%d %M %Y %H:%i' )}</p>
        		<p class="author">{$child.object.owner.name}</p>
    		</div>
	   </li>
    {/foreach}
    </ul>
	
	{/if}
	</div>
</div>

</div></div></div></div></div>
</div>