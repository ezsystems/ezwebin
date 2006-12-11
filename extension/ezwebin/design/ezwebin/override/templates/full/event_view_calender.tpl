{* Event Calendar - Full Calendar view *}
{def

	$event_node = $node.node_id

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

{def	$events=fetch( 'content', 'list', hash(
			'parent_node_id', $event_node,
			'sort_by', array( 'attribute', true(), 'event/from_time'),
			'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
			'main_node_only', true(),
	 		'attribute_filter',
			array( 'or',
					array( 'event/from_time', 'between', array( sum($first_ts,1), sub($last_ts,1)  )),
					array( 'event/to_time', 'between', array( sum($first_ts,1), sub($last_ts,1) )) )
				))

	$url_reload=concat("/content/view/full/",  $event_node, "/day/", $temp_today, "/month/", $temp_month, "/year/", $temp_year, "/offset/2")
	$url_back=concat("/content/view/full/",  $event_node,  "/month/", sub($temp_month, 1), "/year/", $temp_year)
	$url_forward=concat("/content/view/full/",  $event_node, "/month/", sum($temp_month, 1), "/year/", $temp_year)
}

{if eq($temp_month, 1)}
	{set $url_back=concat("/content/view/full/",  $event_node,"/month/", "12", "/year/", sub($temp_year, 1))}
{elseif eq($temp_month, 12)}
	{set $url_forward=concat("/content/view/full/",  $event_node,"/month/", "1", "/year/", sum($temp_year, 1))}
{/if}

{foreach $events as $event}
	{if eq($temp_month|int(), $event.data_map.from_time.content.month|int())}
		{set $loop_dayone = $event.data_map.from_time.content.day}
	{else}
		{set $loop_dayone = 1}
	{/if}
	{if eq($temp_month|int(), $event.data_map.to_time.content.month|int())}
		{set $loop_daylast = $event.data_map.to_time.content.day}
	{else}
		{set $loop_daylast = $days}
	{/if}
	{for $loop_dayone|int() to $loop_daylast|int() as $counter}
		{set $day_array = concat($day_array, $counter, ', ')}
		{if eq($counter,$temp_today)}
			{set $day_events = $day_events|append($event)}
		{/if}
	{/for}
{/foreach}

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-view-full">
 <div class="class-event-calendar event-calendar-calendarview">

<div class="attribute-header">
	<h1>{$node.name|wash()}</h1>
</div>


<div id="ezagenda_calendar_left">
<div id="ezagenda_calendar_container">
<table cellspacing="0" cellpadding="0" border="0" summary="Event Calendar">
<thead>
<tr>
<th><a href={$url_back|ezurl} title=" Previous month ">&lt;&lt;</a></th>
<th colspan="5">{$temp_ts|datetime( custom, '%F' )|upfirst()}&nbsp;{$temp_year}</th>
<th><a href={$url_forward|ezurl} title=" Next Month ">&gt;&gt;</a></th>
</tr>
<tr>
	<th>{"Mon"|i18n("design/ezwebin/full/event_view_calendar")}</th>
	<th>{"Tue"|i18n("design/ezwebin/full/event_view_calendar")}</th>
	<th>{"Wed"|i18n("design/ezwebin/full/event_view_calendar")}</th>
	<th>{"Thu"|i18n("design/ezwebin/full/event_view_calendar")}</th>
	<th>{"Fri"|i18n("design/ezwebin/full/event_view_calendar")}</th>
	<th>{"Sat"|i18n("design/ezwebin/full/event_view_calendar")}</th>
	<th>{"Sun"|i18n("design/ezwebin/full/event_view_calendar")}</th>
</tr>
</thead>
<tbody>


{def $counter=1 $col_counter=1}
{while le( $counter, $days )}
	{set $dayofweek=makedate( $temp_month, $counter, $temp_year )|datetime( custom, '%w' )}
	{if or( eq( $counter, 1 ), eq( $dayofweek, 1 ) )}
		<tr class="days">
	{/if}
	{if and( $span1|gt( 1 ), eq( $counter, 1 ) )}
		{set $col_counter=1}
		{while ne( $col_counter, $span1 )}
			<td>&nbsp;</td>
			{set $col_counter=inc( $col_counter )}
		{/while}
	{/if}
	{if and( eq($span1, 0 ), eq( $counter, 1 ) )}
		{set $col_counter=1}
		{while le( $col_counter, 6 )}
			<td>&nbsp;</td>
			{set $col_counter=inc( $col_counter )}
		{/while}
	{/if}
	<td class="{if eq($counter, $temp_today)}ezagenda_selected{/if} {if and(eq($counter, $curr_today), eq($curr_month, $temp_month))}ezagenda_current{/if}">
	{if $day_array|contains(concat(' ', $counter, ',')) }
		<a href={concat("/content/view/full/", $event_node,"/day/", $counter, "/month/", $temp_month, "/year/", $temp_year)|ezurl}>{$counter}</a>
	{else}
		{$counter}
	{/if}
	</td>
	{if and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne(7))}
		{set $col_counter=1}
		{while le( $col_counter, $span2 )}
			<td></td>
			{set $col_counter=inc( $col_counter )}
		{/while}
	{/if}
	{if or( eq( $dayofweek, 0 ), eq( $counter, $days ) )}
		</tr>
	{/if}
	{set $counter=inc( $counter )}
{/while}
</tbody>
</table>
</div>


<div id="ezagenda_calendar_today">
	{if eq($curr_ts|datetime( custom, '%j'),$temp_ts|datetime( custom, '%j'))} 
		<h2>{"Today"|i18n("design/ezwebin/full/event_view_calendar")}:</h2> 
	{else} 
		<h2>{$temp_ts|datetime( custom, '%l %j')|upfirst()}:</h2> 
	{/if} 
{foreach $day_events as $day_event}
	{if gt($curr_ts , $day_event.object.data_map.to_time.content.timestamp)}
		<div class="ezagenda_day_event ezagenda_event_old">
	{else}
		<div class="ezagenda_day_event">
	{/if}
	<h2><a href={$day_event.url_alias|ezurl}>{$day_event.name|wash}</a></h2>
	
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
		<a id="ezagenda_month_hidden_show" href={$url_reload|ezurl} onclick="document.getElementById('ezagenda_month_hidden').style.display='';this.style.display='none';return false;">Show All Events..</a>
		<div id="ezagenda_month_hidden" style="display:none;">
	{/if}
	{if gt($curr_ts , $event.object.data_map.to_time.content.timestamp)}
		<table cellpadding="0" cellspacing="0" class="ezagenda_event_old" summary="Previw of event">
	{else}
		<table cellpadding="0" cellspacing="0" summary="Previw of event">
	{/if}
	<tr>
	<td class="ezagenda_month_head">
		<h2>{$event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}</h2>
	</td>
	<td class="ezagenda_month_info">
	<h2><a href={$event.url_alias|ezurl}>{$event.name|wash}</a></h2>
	
	<p>
	{if $event.object.data_map.category.has_content}
	<span class="ezagenda_keyword">
	{attribute_view_gui attribute=$event.object.data_map.category}
	</span>
	{/if}

	<span class="ezagenda_date">
	{$event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
	{if and($event.object.data_map.to_time.has_content,  ne( $event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M"), $event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M") ))}
		- {$event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
	{/if}
	</span>
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

</div></div></div></div></div>
</div>