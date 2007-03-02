{* Link - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-link">

    <div class="attribute-header">
        <h1>{attribute_view_gui attribute=$node.data_map.name}</h1>
    </div>
    {if $node.data_map.description.content.is_empty|not}
        <div class="attribute-long">
            {attribute_view_gui attribute=$node.data_map.description}
        </div>
    {/if}

    {if ne( $node.data_map.location.content, '' )}
        <div class="attribute-link">
            <p><a href="{$node.data_map.location.content}" target="_blank">{$node.data_map.location.data_text}</a></p>
        </div>
    {/if}

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>