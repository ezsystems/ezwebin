{* Folder - Embed *}

<div class="content-view-embed">
    <div class="class-folder">

    <h2><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash()}</a></h2>

    <div class="attribute-short">
        {attribute_view_gui attribute=$object.main_node.object.data_map.short_description}
    </div>

    </div>
</div>