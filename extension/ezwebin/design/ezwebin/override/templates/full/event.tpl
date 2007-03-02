{set-block scope=root variable=cache_ttl}600{/set-block}
{* Event - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-event">
    
    <div class="attribute-header">
    {if $node.data_map.title.has_content}
        <h1>{$node.data_map.title.content|wash()}</h1>
    {else}
        <h1>{$node.name|wash()}</h1>
    {/if}
    </div>
    
    <div class="attribute-byline">
    <p>
    {if $node.object.data_map.category.has_content}
    <span class="ezagenda_keyword">
    {"Category"|i18n("design/ezwebin/full/event")}:
    {attribute_view_gui attribute=$node.object.data_map.category}
    </span>
    {/if}
    
    <span class="ezagenda_date">{$node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {if $node.object.data_map.to_time.has_content}
          - {$node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {/if}
    </span>
    </p>
    </div>

    {* if $node.object.data_map.image.content}
         <div class="attribute-image">
             {attribute_view_gui attribute=$node.object.data_map.image align=center image_class=imagelarge}
        </div>
    {/if *}

    {if $node.object.data_map.text.has_content}
        <div class="attribute-short">{attribute_view_gui attribute=$node.object.data_map.text}</div>
    {/if}


    {* if $node.object.data_map.url.has_content}
        <p style="text-align:center;">
        <a href={$node.object.data_map.url.content|ezurl}>{$node.object.data_map.url.data_text|wash()}</a>
        </p>
    {/if *}
  </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>