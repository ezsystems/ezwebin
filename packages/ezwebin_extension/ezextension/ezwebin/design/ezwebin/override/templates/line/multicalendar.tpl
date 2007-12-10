{* Multicalendar - Line view *}

<div class="content-view-line">
    <div class="class-multicalendar">

        <h2><a href={$node.url_alias|ezurl}>{$node.name|wash()}</a></h2>

       {if $node.data_map.description.has_content}
        <div class="attribute-short">
        {attribute_view_gui attribute=$node.data_map.description}
        </div>
       {/if}

    </div>
</div>