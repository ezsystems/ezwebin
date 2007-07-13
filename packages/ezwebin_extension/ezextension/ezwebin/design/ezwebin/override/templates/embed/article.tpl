<div class="content-view-embed">
    <div class="class-article float-break">

        <h2><a href={$object.main_node.url_alias|ezurl}>{$object.data_map.title.content|wash}</a></h2>
        
    {if $object.data_map.image.has_content}
        <div class="attribute-image">
            {attribute_view_gui image_class=articlethumbnail attribute=$object.data_map.image}
        </div>
    {/if}

    {if $object.data_map.intro.content.is_empty|not}
    <div class="attribute-short">
        {attribute_view_gui attribute=$object.data_map.intro}
    </div>
    {/if}

    </div>
</div>