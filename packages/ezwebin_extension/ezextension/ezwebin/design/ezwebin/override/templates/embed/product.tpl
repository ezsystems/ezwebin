{* Product - List embed view *}

<div class="content-view-embed">
    <div class="class-product">

<div class="border-box productbox-header">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">

    {if $object.data_map.image.content}
    <div class="attribute-image">
        {attribute_view_gui image_class=listitem attribute=$object.data_map.image href=$object.main_node.url_alias|ezurl}
    </div>
    {else}
    <div class="attribute-short">
        {attribute_view_gui attribute=$object.data_map.short_description}
    </div>
    {/if}

</div></div></div>
</div>
<div class="border-box productbox">
<div class="border-ml"><div class="border-mr"><div class="border-mc">

    <p><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a></p>

    <div class="attribute-price">
        {attribute_view_gui attribute=$object.data_map.price}
    </div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

    </div>
</div>