{* Image - Gallery line view *}
<div class="content-view-galleryline"{if is_set($#image_style)} style="{$#image_style}"{/if}>
    <div class="class-image">

    <div class="attribute-image">
        <p>{attribute_view_gui attribute=$node.data_map.image image_class=gallerythumbnail
                               href=$node.url_alias|ezurl}</p>
    </div>

    <div class="attribute-caption">
        {attribute_view_gui attribute=$node.data_map.caption}
    </div>

    </div>
</div>