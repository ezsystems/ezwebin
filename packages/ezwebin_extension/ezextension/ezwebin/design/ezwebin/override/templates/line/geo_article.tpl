{* Geo Article - Line view *}

<div class="content-view-line">
    <div class="class-geo-article float-break">

    <h2><a href="{$node.url_alias|ezurl( 'no' )}">{$node.name|wash()}</a></h2>

    {if $node.data_map.image.has_content}
        <div class="attribute-image">
            {attribute_view_gui image_class=articlethumbnail href=$node.url_alias|ezurl attribute=$node.data_map.image}
        </div>
    {/if}

    {if $node.data_map.intro.has_content}
    <div class="attribute-short">
        {attribute_view_gui attribute=$node.data_map.intro}
    </div>
    {/if}

    </div>
</div>