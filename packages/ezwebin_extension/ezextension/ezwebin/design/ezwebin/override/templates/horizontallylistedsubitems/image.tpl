{* Image - Horizontally Listed Subitems view *}

<div class="content-view-horizontallylistedsubitems">
    <div class="class-image">

    {if $node.data_map.caption.has_content|not}
    <h2>{$node.name|wash}</h2>
    {/if}
    <div class="content-image">
        {attribute_view_gui attribute=$node.data_map.image image_class=listitem href=$node.url_alias|ezurl()}
    </div>

    <div class="caption">
        {attribute_view_gui attribute=$node.data_map.caption}
    </div>

    </div>
</div>