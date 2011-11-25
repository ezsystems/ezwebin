{* Event Calendar - Full Calendar view *}
{def

    $event_node    = $node
    $event_node_id = $event_node.node_id

    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year = $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')

    $temp_ts = cond( and(ne($view_parameters.month, ''), ne($view_parameters.year, '')), makedate($view_parameters.month, cond(ne($view_parameters.day, ''),$view_parameters.day, eq($curr_month, $view_parameters.month), $curr_today, 1 ), $view_parameters.year), currentdate() )

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
    $loop_count = 0
    }

{if ne($temp_month, 12)}
    {set $last_ts=makedate($temp_month|sum( 1 ), 1, $temp_year)}
{else}
    {set $last_ts=makedate(1, 1, $temp_year|sum(1))}
{/if}

{def    $events=fetch( 'content', 'list', hash(
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
            {set $day_events = $day_events|append($event)}
        {/if}
    {/for}
{/foreach}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
 <div class="class-event-calendar event-calendar-calendarview">

<div class="attribute-header">
    <h1>{$event_node.name|wash()}</h1>
</div>

<div id="ezagenda_calendar_left">
<div id="ezagenda_calendar_container">

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<table cellspacing="0" cellpadding="0" border="0" summary="Event Calendar">
<thead>
<tr class="calendar_heading">
    <th class="calendar_heading_prev first_col"><a href={$url_back|ezurl} title=" Previous month ">&#8249;&#8249;</a></th>
    <th class="calendar_heading_date" colspan="5">{$temp_ts|datetime( custom, '%F' )|upfirst()}&nbsp;{$temp_year}</th>
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
        <tr class="days{if eq( $counter, 1 )} first_row{elseif lt( $days|sub( $counter ), 7 )} last_row{/if}">
        {set $css_col_class=' first_col'}
    {elseif and( $col_end, not( and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne( 7 ) ) ) )}
        {set $css_col_class=' last_col'}
    {/if}
    {if and( $span1|gt( 1 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while ne( $col_counter, $span1 )}
            <td>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {elseif and( eq($span1, 0 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while le( $col_counter, 6 )}
            <td>&nbsp;</td>
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
            {set $css_col_class=''}
            {if eq( $col_counter, $span2 )}
                {set $css_col_class=' last_col'}
            {/if}
            <td class="{$css_col_class}">&nbsp;</td>
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

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

</div>

<div id="ezagenda_calendar_today">
    {if eq($curr_ts|datetime( custom, '%j'),$temp_ts|datetime( custom, '%j'))} 
        <h2>{"Today"|i18n("design/ezwebin/full/event_view_calendar")}:</h2> 
    {else} 
        <h2>{$temp_ts|datetime( custom, '%l %j')|upfirst()}:</h2> 
    {/if} 
{foreach $day_events as $day_event}
    
    <div class="ezagenda_day_event{if gt($curr_ts , $day_event.object.data_map.to_time.content.timestamp)} ezagenda_event_old{/if}">
    <h4><a href={$day_event.url_alias|ezurl}>{$day_event.name|wash}</a></h4>
    <p>
    {if $day_event.object.data_map.category.has_content}
    <span class="ezagenda_keyword">
    {"Category"|i18n("design/ezwebin/full/event_view_calendar")}:
    {attribute_view_gui attribute=$day_event.object.data_map.category}
    </span>
    {/if}

    <span class="ezagenda_date">
    {$day_event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M %H:%i")} 
    {if $day_event.object.data_map.to_time.has_content}
        - {$day_event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {/if}
    </span>
    </p>    
    </div>
{/foreach}
</div>
</div>


<div id="ezagenda_calendar_right">
<h2>{$temp_ts|datetime( custom, '%F %Y' )|upfirst()}:</h2> 
{foreach $events as $event}
    {if and( ne($view_parameters.offset, 2), eq($loop_count, 8))}
        <a id="ezagenda_month_hidden_show" href={$url_reload|ezurl} onclick="document.getElementById('ezagenda_month_hidden').style.display='';this.style.display='none';return false;">{"Show All Events.."|i18n("design/ezwebin/full/event_view_calendar")}</a>
        <div id="ezagenda_month_hidden" style="display:none;">
    {/if}
    
    <table class="ezagenda_month_event" cellpadding="0" cellspacing="0"{if gt($curr_ts , $event.object.data_map.to_time.content.timestamp)} class="ezagenda_event_old"{/if} summary="Previw of event">
    <tr>
    <td class="ezagenda_month_label">
        <h2>
        <span class="ezagenda_month_label_date">{$event.object.data_map.from_time.content.timestamp|datetime(custom,"%j")}</span>
        {$event.object.data_map.from_time.content.timestamp|datetime(custom,"%M")|extract_left( 3 )}
        </h2>
    </td>
    <td class="ezagenda_month_info">

    <h4><a href={$event.url_alias|ezurl}>{$event.name|wash}</a></h4>

    <p>
    <span class="ezagenda_date">
    {$event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
    {if and($event.object.data_map.to_time.has_content,  ne( $event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M"), $event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M") ))}
        - {$event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
    {/if}
    </span>
    
    {if $event.object.data_map.category.has_content}
    <span class="ezagenda_keyword">
    {attribute_view_gui attribute=$event.object.data_map.category}
    </span>
    {/if}
    </p>
    
    {if $event.object.data_map.text.has_content}
        <div class="attribute-short">{attribute_view_gui attribute=$event.object.data_map.text}</div>
    {/if}

    </td>
    </tr>
    </table>
    {set $loop_count = inc($loop_count)}
{/foreach}
{if and(  ne($view_parameters.offset, 2) , gt($loop_count, 8))}
    </div>
{/if}
</div>

{undef}
</div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
