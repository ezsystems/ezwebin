<div class="content-view-embed">
    <div class="class-event-calendar">
{def

    $event_node    = $object.main_node
    $event_node_id = $object.main_node_id

    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year = $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')

    $temp_ts = currentdate()

    $temp_month = $temp_ts|datetime( custom, '%n')
    $temp_year = $temp_ts|datetime( custom, '%Y')
    $temp_today = $temp_ts|datetime( custom, '%j')

    $days = $temp_ts|datetime( custom, '%t')

    $first_ts = makedate($temp_month, 1, $temp_year)
    $dayone = $first_ts|datetime( custom, '%w' )

    $last_ts = makedate($temp_month, $days, $temp_year)
    $daylast = $last_ts|datetime( custom, '%w' )

    $span1 = $dayone
    $span2 = sub( 7, $daylast )

    $dayofweek = 0

    $day_array = " "
    $loop_dayone = 1
    $loop_daylast = 1
    $day_events = array()
    }

{if ne($temp_month, 12)}
    {set $last_ts = makedate( $temp_month|sum( 1 ), 1, $temp_year )}
{else}
    {set $last_ts = makedate( 1, 1, $temp_year|sum(1) )}
{/if}

{def    $events = fetch( 'content', 'list', hash(
            'parent_node_id', $event_node_id,
            'sort_by', array( 'attribute', true(), 'event/from_time'),
            'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
            'main_node_only', true(),
             'attribute_filter',
            array( 'or',
                    array( 'event/from_time', 'between', array( sum($first_ts,1), sub($last_ts,1)  )),
                    array( 'event/to_time', 'between', array( sum($first_ts,1), sub($last_ts,1) )) )
                ))
     $events_range=fetch( 'content', 'list', hash(
            'parent_node_id', $event_node_id,
            'sort_by', array( 'attribute', true(), 'event/from_time'),
            'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
            'main_node_only', true(),
             'attribute_filter',
            array( 'and',
                    array( 'event/from_time', '<', sum($first_ts,1) ),
                    array( 'event/to_time', '>', sub($last_ts,1) ) )
                ))

    $url_reload=concat( $event_node.url_alias, "/(day)/", $temp_today, "/(month)/", $temp_month, "/(year)/", $temp_year, "/offset/2")
    $url_back=concat( $event_node.url_alias,  "/(month)/", sub($temp_month, 1), "/(year)/", $temp_year)
    $url_forward=concat( $event_node.url_alias, "/(month)/", sum($temp_month, 1), "/(year)/", $temp_year)
}
{set $events = $events_range|merge($events)}

{if eq($temp_month, 1)}
    {set $url_back=concat( $event_node.url_alias,"/(month)/", "12", "/(year)/", sub($temp_year, 1))}
{elseif eq($temp_month, 12)}
    {set $url_forward=concat( $event_node.url_alias,"/(month)/", "1", "/(year)/", sum($temp_year, 1))}
{/if}

{foreach $events as $event}
    {if eq($temp_month|int(), $event.data_map.from_time.content.month|int())}
        {set $loop_dayone = $event.data_map.from_time.content.day}
    {else}
        {set $loop_dayone = 1}
    {/if}
    {if $event.data_map.to_time.content.is_valid}
       {if eq($temp_month|int(), $event.data_map.to_time.content.month|int())}
            {set $loop_daylast = $event.data_map.to_time.content.day}
        {else}
            {set $loop_daylast = $days}
        {/if}
    {else}
         {set $loop_daylast = $loop_dayone}
    {/if}
    {for $loop_dayone|int() to $loop_daylast|int() as $counter}
        {set $day_array = concat($day_array, $counter, ', ')}
        {if eq($counter,$temp_today)}
            {set $day_events = $day_events|append( $event )}
        {/if}
    {/for}
{/foreach}

<div id="ezagenda_calendar_container">

<table cellspacing="0" cellpadding="0" border="0" summary="Event Calendar">
<thead>
<tr class="calendar_heading">
    <th class="calendar_heading_prev first_col"><a href={$url_back|ezurl} title=" Previous month ">&#8249;&#8249;</a></th>
    <th class="calendar_heading_date" colspan="5">{$temp_ts|datetime( custom, '%F' )|upfirst()}{if $curr_year|ne( $temp_year )}&nbsp;{$temp_year}{/if}</th>
    <th class="calendar_heading_next last_col"><a href={$url_forward|ezurl} title=" Next Month ">&#8250;&#8250;</a></th>
</tr>
<tr class="calendar_heading_days">
    <th class="first_col">{"Mon"|i18n("design/ezwebin/full/event_view_calendar")}</th>
    <th>{"Tue"|i18n("design/ezwebin/full/event_view_calendar")}</th>
    <th>{"Wed"|i18n("design/ezwebin/full/event_view_calendar")}</th>
    <th>{"Thu"|i18n("design/ezwebin/full/event_view_calendar")}</th>
    <th>{"Fri"|i18n("design/ezwebin/full/event_view_calendar")}</th>
    <th>{"Sat"|i18n("design/ezwebin/full/event_view_calendar")}</th>
    <th class="last_col">{"Sun"|i18n("design/ezwebin/full/event_view_calendar")}</th>
</tr>
</thead>
<tbody>

{if is_unset( $counter )}
    {def $counter=1}
{else}
    {set $counter=1}
{/if}

{def $col_counter=1 $css_col_class='' $col_end=0}
{while le( $counter, $days )}
    {set $dayofweek     = makedate( $temp_month, $counter, $temp_year )|datetime( custom, '%w' )
         $css_col_class = ''
         $col_end       = or( eq( $dayofweek, 0 ), eq( $counter, $days ) )}
    {if or( eq( $counter, 1 ), eq( $dayofweek, 1 ) )}
        <tr class="days{if eq( $counter, 1 )} first_row{elseif le( $days|sub( $counter ), 7 )} last_row{/if}">
        {set $css_col_class=' first_col'}
    {elseif and($col_end, not(and(eq( $counter, $days ), $span2|gt( 0 ), $span2|ne(7))) )}
        {set $css_col_class=' last_col'}
    {/if}
    {if and( $span1|gt( 1 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while ne( $col_counter, $span1 )}
            <td{if $col_counter|eq( 1 )} class="first_col"{/if}>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {elseif and( eq($span1, 0 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while le( $col_counter, 6 )}
            <td{if $col_counter|eq( 1 )} class="first_col"{/if}>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {/if}
    <td class="{if eq($counter, $temp_today)}ezagenda_selected{/if} {if and(eq($counter, $curr_today), eq($curr_month, $temp_month))}ezagenda_current{/if}{$css_col_class}">
    {if $day_array|contains(concat(' ', $counter, ',')) }
        <a href={concat( $event_node.url_alias, "/(day)/", $counter, "/(month)/", $temp_month, "/(year)/", $temp_year)|ezurl}>{$counter}</a>
    {else}
        {$counter}
    {/if}
    </td>
    {if and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne(7))}
        {set $col_counter=1}
        {while le( $col_counter, $span2 )}
            <td{if $col_counter|eq( $span2 )} class="last_col"{/if}>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {/if}
    {if $col_end}
        </tr>
    {/if}
    {set $counter=inc( $counter )}
{/while}
</tbody>
</table>

<!-- day array here ?? -->
<div class="block">
    {if is_set($day_events.0.name)}
    <div id="sidebar_calendar_today">
    <h5>{"Today"|i18n("design/ezwebin/full/event_view_calendar")}:</h5>
    <div class="float-break">
    {foreach $day_events  as $event}
    <a href={$event.url_alias|ezurl}>{$event.name|wash}
    <span class="ezagenda_date">
    {$event.object.data_map.from_time.content.timestamp|datetime(custom,"%H:%i")}
    {if $event.object.data_map.to_time.has_content}
        {if $event.object.data_map.to_time.content.day|int()|eq( $event.object.data_map.from_time.content.day|int() )}
        - {$event.object.data_map.to_time.content.timestamp|datetime(custom,"%H:%i")}
        {else}
        - {$event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
        {/if}
    {/if}
    </span>
    </a>
    {/foreach}
    </div>
    </div>
    {/if}
</div>

</div>
{undef}

    </div>
</div>
