{* Children menu, a inline menu to use in xml blocks *}
<div class="object-{if is_set($align)}{$align}{else}left{/if} itemized_sub_items itemized_children_menu">
<div class="content-view-embed">
    <div class="class-{$#node.class_identifier}">

    <h2>{if is_set($title)}{$title}{else}{$#node.name|wash()}{/if}</h2>

    <div class="border-box">
    <div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
    <div class="border-ml"><div class="border-mr"><div class="border-mc float-break">
    {def $children = array()
         $classes_type = 'exclude'
         $classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )}

    {if is_unset( $limit )}
        {def $limit = 5}
    {/if}

    {if is_unset( $offset )}
        {def $offset = 0}
    {/if}

    {if le( $#node.depth, '3')}
        {set $classes = $classes|append('folder')}
    {/if}
    
    {* choose menu mode to specify what classes to include *}
	{switch match=$like}
	    {case match='left_menu'}
	        {set $classes = ezini( 'MenuContentSettings', 'LeftIdentifierList', 'menu.ini' )}
	    	{set $classes_type = 'include'}
	    {/case}
	    {case match='top_menu'}
	    	{set $classes = ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' )}
	    	{set $classes_type = 'include'}
	    {/case}
	    {case}
	    {/case}
	{/switch}

    {set $children=fetch( content, list, hash( 'parent_node_id', $#node.node_id, 
                                               'limit', $limit,
                                               'offset', $offset,
                                               'class_filter_type', $classes_type,
                                               'class_filter_array', $classes,
                                               'sort_by', $#node.sort_array ) ) }

    {if $children|count()}

    <ul>
    {foreach $children as $child}
       <li><div><a href={$child.url_alias|ezurl}>{$child.name|wash()}</a></div></li>
    {/foreach}
    </ul>
    
    {/if}
    
    </div></div></div>
    <div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
    </div>

    </div>
</div>
</div>