{* Image - Horizontally Listed Subitems view *}

<div class="content-view-horizontallylistedsubitems">
    <div class="class-image">

    <div class="content-image">
        {attribute_view_gui attribute=$node.data_map.image image_class=listitem href=$node.url_alias|ezurl()}
    </div>

    <div class="caption">
        <p><a href="{$node.url_alias|ezurl(no)}">{$node.name}</a></p>
    </div>

    </div>
</div>