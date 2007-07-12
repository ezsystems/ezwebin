{* Event - Line view *}

<div class="content-view-line">
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
    {"Category"|i18n("design/ezwebin/line/event")}:
    {$node.data_map.category.class_content.options[$node.data_map.category.value[0]].name|wash()}
    </span>
    {/if}

    <span class="ezagenda_date">
    {$node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {if $node.object.data_map.from_time.has_content}
          - {$node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {/if}
    </span>
    </p>
    </div>
  </div>
</div>