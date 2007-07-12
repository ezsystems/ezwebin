{* Article - Horizontally Listed Subitems view view *}
<div class="content-view-horizontallylistedsubitems">
{if gt(currentdate() , $node.object.data_map.to_time.content.timestamp)}
    <div class="class-event ezagenda_event_old">
{else}
    <div class="class-event">
{/if}
    <h2>
        <a href={$node.url_alias|ezurl}>{$node.name|wash()}</a>
    </h2>
    <div class="attribute-byline">
    <p>
    {if $node.object.data_map.category.has_content}
        <span class="ezagenda_keyword">
        {"Category"|i18n("design/ezwebin/full/event")}:
        {attribute_view_gui attribute=$node.object.data_map.category}
        </span>
    {/if}
    
    <span class="ezagenda_date">
    {$node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {if $node.object.data_map.to_time.has_content}
          - {$node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {/if}
    </span>
    </p>
    </div>
  </div>
</div>