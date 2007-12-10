{* Event Calendar - Line view *}

<div class="content-view-line">
    <div class="class-event-calendar">
    <h2><a href={$node.url_alias|ezurl}>{$node.object.data_map.title.content|wash()}</a></h2>
    {def     $event_ts=currentdate()
             $list_data=fetch( 'content', 'list', hash( 
                'parent_node_id', $node.node_id,
                'class_filter_type', 'include',
                'attribute_filter',    array( array( 'event/to_time', '>=', $event_ts )),
                'class_filter_type', 'include',
                'class_filter_array', array('event'),
                'sort_by', array( 'attribute', true(), 'event/from_time' ),
                'ignore_visibility', true(),
                'limit',  3 ) )}

    {if gt(count($list_data),0)}
    <div class="content-view-children">
    <strong>{"Next events"|i18n("design/ezwebin/line/event_calendar")}:</strong>
        {foreach $list_data as $event}
        {if or( eq($event.object.data_map.to_time.content.timestamp|datetime( custom, '%j%m'), $event_ts|datetime( custom, '%j%m')),
                eq($event.object.data_map.from_time.content.timestamp|datetime( custom, '%j%m'), $event_ts|datetime( custom, '%j%m')),
                and(lt($event.object.data_map.from_time.content.timestamp, $event_ts),
                    gt($event.object.data_map.to_time.content.timestamp, $event_ts))
     )}
        <p class="ezagenda_today">
        {else}
        <p>
        {/if}
        <span class="ezagenda_date">{$event.object.data_map.from_time.content.timestamp|datetime(custom,"%d %M")}</span>
        <a href={$event.url_alias|ezurl}>{$event.name|wash()}</a>
        </p>
        {/foreach}
    </div>
    {/if}
{undef $list_data $event_ts}
  </div>
</div>