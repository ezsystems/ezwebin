{* Event Program- Full view *}
{def
	$event_node = $node.node_id
	$curr_ts = currentdate()
	$curr_today = $curr_ts|datetime( custom, '%j')
	$curr_year = $curr_ts|datetime( custom, '%Y')
	$curr_month = $curr_ts|datetime( custom, '%n')
	$oldest_event = ''
	$newest_event = ''
	$temp_oldest_event = ''
	$temp_newest_event = ''
	$temp_ts = cond( and(ne($view_parameters.month, ''), ne($view_parameters.year, '')), makedate($view_parameters.month, cond(ne($view_parameters.day, ''),$view_parameters.day, eq($curr_month, $view_parameters.month), $curr_today, 1 ), $view_parameters.year), currentdate() )

	$temp_offset = cond( ne($view_parameters.offset, ''), $view_parameters.offset, 1)
	$temp_month = ''
	$temp_year = ''
	$events = ''
	$daymode = false()
}
{if gt($temp_offset,0)}
{set $events = fetch( 'content', 'list', hash(
			'parent_node_id', $event_node,
			'sort_by', array( 'attribute', true(), 'event/from_time' ),
			'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
			'limitation', 15,
			'attribute_filter',	array( array( 'event/to_time', '>=', $curr_ts )) ))
}
{else}
{set $events = fetch( 'content', 'list', hash(
			'parent_node_id', $event_node,
			'sort_by', array( 'attribute', true(), 'event/from_time' ),
			'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
			'limitation', 15,
			'attribute_filter',	array( array( 'event/to_time', '<', $curr_ts )) ))
}
{/if}

{foreach $node.children as $event}
{if or(eq($newest_event,''),gt($event.object.data_map.from_time.content.timestamp, $newest_event))}
	{set $newest_event = $event.object.data_map.from_time.content.timestamp}
{/if}
{if or(eq($oldest_event,''),lt($event.object.data_map.from_time.content.timestamp, $oldest_event))}
	{set $oldest_event = $event.object.data_map.from_time.content.timestamp}
{/if}
{/foreach}

{foreach $events as $event}
{if or(eq($temp_newest_event,''),gt($event.object.data_map.from_time.content.timestamp, $temp_newest_event))}
	{set $temp_newest_event=$event.object.data_map.from_time.content.timestamp}
{/if}
{if or(eq($temp_oldest_event,''),lt($event.object.data_map.from_time.content.timestamp, $temp_oldest_event))}
	{set $temp_oldest_event=$event.object.data_map.from_time.content.timestamp}
{/if}
{/foreach}

{if eq($temp_oldest_event|datetime(custom,"%M"),  $temp_newest_event|datetime(custom,"%M"))}
{set $daymode=true()}
{/if}

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-view-full">
 <div class="class-event class-ezagenda-program">

<div class="attribute-header">
	<h1>{$node.name|wash()}</h1>
</div>

<table cellspacing="0" id="ezagenda" width="100%">
{if $daymode}
	{foreach $events as $event}
	{set $temp_month = $event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M")}
		<tr>
		<td  class="ezagenda_month_label"><h2>{$temp_month}</h2></td>
		<td class="ezagenda_month">
	 <table cellpadding="0" cellspacing="0" summary="Agenda Month preview event" {if gt($curr_ts , $event.object.data_map.to_time.content.timestamp)} class="ezagenda_event_old"{/if} width="99%">
	<tr><td class="ezagenda_month_head">
	<h2>
		<a href={$event.url_alias|ezurl}>{$event.name|wash}</a>
	</h2>
	{if $event.object.data_map.text.has_content}
		<div class="attribute-short">{attribute_view_gui attribute=$event.object.data_map.text}</div>
	{/if}
	</td>
	<td align="right" class="ezagenda_month_info">
	<p>{attribute_view_gui attribute=$event.object.data_map.category}
	<br />
	{$event.object.data_map.from_time.content.timestamp|datetime(custom,"%H:%i")}
	{if and($event.object.data_map.to_time.has_content,  ne( $event.object.data_map.to_time.content.timestamp|datetime(custom,"%H:%i"), $event.object.data_map.from_time.content.timestamp|datetime(custom,"%H:%i") ))}
	- {$event.object.data_map.to_time.content.timestamp|datetime(custom,"%H:%i")}
	{/if}
	</p>
	</td></tr>
	</table>
	<tr>
	<td colspan="2">&nbsp;</td>
</tr>
	{/foreach}
{else}
	{foreach $events as $event}
	{set	$temp_month = $event.object.data_map.from_time.content.timestamp|datetime(custom,"%M")}
	{set	$temp_year = $event.object.data_map.from_time.content.timestamp|datetime(custom,"%y")}
		<tr>
		<td class="ezagenda_month_label"><h2>{$temp_month}<br />{$temp_year}</h2></td>
		<td class="ezagenda_month">
	 <table cellpadding="0" cellspacing="0" summary="Agenda Month preview event" {if gt($curr_ts , $event.object.data_map.to_time.content.timestamp)} class="ezagenda_event_old"{/if} width="99%">
	<tr><td class="ezagenda_month_head">
	<h2>
		<a href={$event.url_alias|ezurl}>{$event.name|wash}</a>
	</h2>
	</td>
	<td align="right" class="ezagenda_month_info">
	<p>{attribute_view_gui attribute=$event.object.data_map.category}
	<br />
	{$event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
	{if and($event.object.data_map.to_time.has_content,  ne( $event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M"), $event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M") ))}
	- {$event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
	{/if}
	</p>
	</td></tr>
	<tr><td colspan="2" class="ezagenda_month_body">
	{if $event.object.data_map.text.has_content}
	<div class="attribute-short">{attribute_view_gui attribute=$event.object.data_map.text}</div>
	{/if}
	</td>
	</tr>
	</table>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	{/foreach}
{/if}
</td></tr>
<tr>
<td style="width: 50px">
{if and($temp_oldest_event|ne(''), lt($oldest_event, $temp_oldest_event))}
	<a href={concat("/content/view/full/",  $node.node_id,  "/month/", $temp_oldest_event|datetime(custom,"%n"), "/year/", $temp_oldest_event|datetime(custom,"%Y"), "/day/", $temp_oldest_event|datetime(custom,"%j"), "/offset/-1")|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezwebin/full/event_view_program")}</a>
{elseif and( $temp_oldest_event|eq(''), $oldest_event|ne(''), lt($oldest_event, $temp_ts) )}
	<a href={concat("/content/view/full/",  $node.node_id,  "/month/", $temp_ts|datetime(custom,"%n"), "/year/", $temp_ts|datetime(custom,"%Y"), "/day/", $temp_ts|datetime(custom,"%j"), "/offset/-1")|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezwebin/full/event_view_program")}</a>
{/if}
</td>
<td style="text-align:right;">
{if and($temp_newest_event|ne( '' ), gt($newest_event, $temp_newest_event))}
	<a href={concat("/content/view/full/",  $node.node_id,  "/month/", $temp_newest_event|datetime(custom,"%n"), "/year/", $temp_newest_event|datetime(custom,"%Y"), "/day/", $temp_newest_event|datetime(custom,"%j"), "/offset/1")|ezurl}>{"Future events"|i18n("design/ezwebin/full/event_view_program")} &gt;&gt;</a>
{elseif and( $temp_newest_event|eq(''), $newest_event|ne(''), gt($newest_event, $temp_ts) )}
	<a href={concat("/content/view/full/",  $node.node_id,  "/month/", $temp_ts|datetime(custom,"%n"), "/year/", $temp_ts|datetime(custom,"%Y"), "/day/", $temp_ts|datetime(custom,"%j"), "/offset/1")|ezurl}>{"Future events"|i18n("design/ezwebin/full/event_view_program")} &gt;&gt;</a>
{/if}
</td>
</tr>
</table>
{undef}
</div>
</div>

</div></div></div></div></div>
</div>