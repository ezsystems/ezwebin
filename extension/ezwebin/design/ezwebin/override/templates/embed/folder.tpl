{* Folder - Embed *}

<div class="content-view-embed">
    <div class="class-folder">

    <h2><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash()}</a></h2>

    <div class="border-box">
    <div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
    <div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

    {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $object.main_node_id, 
                                                     'limit', '5',
                                                     'sort_by', $object.main_node.sort_array ) ) }

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