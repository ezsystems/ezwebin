{* Image - Horizontally Listed Subitems view *}

<div class="content-view-horizontallylistedsubitems">
    <div class="class-image">

    <h2>{$node.name|wash}</h2>

    <div class="content-image">
        <p>{attribute_view_gui attribute=$node.data_map.image image_class=listitem href=$node.url_alias|ezurl()}</p>
    </div>

    <div class="attribute-caption">
        {attribute_view_gui attribute=$node.data_map.caption}
    </div>

    </div>
</div>