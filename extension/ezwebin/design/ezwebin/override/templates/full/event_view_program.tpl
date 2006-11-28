{* Event Calendar - Full Program view *}
{def
	$event_node = $node.node_id
	$curr_ts = currentdate()
	$curr_today = $curr_ts|datetime( custom, '%j')
	$curr_year = $curr_ts|datetime( custom, '%Y')
	$curr_month = $curr_ts|datetime( custom, '%n')
	$temp_oldest_event = ''
	$temp_newest_event = ''

	$temp_offset = cond( ne($view_parameters.offset, ''), $view_parameters.offset, 0)
	$temp_month = ''
	$temp_year = ''
	$daymode = false()
	$direction = ""
	$newer_event_count = fetch( 'content', 'list_count', hash(
			'parent_node_id', $event_node,
			'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
			'attribute_filter',	array( array( 'event/to_time', '>=', $curr_ts )) ))
	$older_event_count = fetch( 'content', 'list_count', hash(
			'parent_node_id', $event_node,
			'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
			'attribute_filter',	array( array( 'event/to_time', '<', $curr_ts )) ))
}
{if ge($temp_offset,0)}
{set $temp_offset = $temp_offset|abs}
{def $events = fetch( 'content', 'list', hash(
			'parent_node_id', $event_node,
			'sort_by', array( 'attribute', true(), 'event/from_time' ),
			'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
			'limitation', 15,
			'offset', $temp_offset|mul(15),
			'attribute_filter',	array( array( 'event/to_time', '>=', $curr_ts )) ))
}
{set $newer_event_count = $newer_event_count|sub( 15|mul( $temp_offset|inc ) )}
{else}
{set $temp_offset = $temp_offset|abs|dec
     $direction = "-"}
{def $events = fetch( 'content', 'list', hash(
			'parent_node_id', $event_node,
			'sort_by', array( 'attribute', true(), 'event/from_time' ),
			'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
			'limitation', 15,
			'offset', $temp_offset|mul(15),
			'attribute_filter',	array( array( 'event/to_time', '<', $curr_ts )) ))
}
{set $older_event_count = $older_event_count|sub( 15|mul( $temp_offset|inc ) )}
{/if}
<!-- debug:
$direction          :{$direction};
$events|count       :{$events|count};
$temp_offset        :{$temp_offset};
$temp_offset|mul(15):{$temp_offset|mul(15)};
$newer_event_count  :{$newer_event_count};
$older_event_count  :{$older_event_count};
-->


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

<table cellspacing="0" id="ezagenda" width="100%" summary="List of events">
{if $daymode}
	{foreach $events as $event}
	{set $temp_month = $event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M")}
	<tr>
	<td  class="ezagenda_month_label"><h2>{$temp_month}</h2></td>
	<td class="ezagenda_month">
	 <table cellpadding="0" cellspacing="0" summary="preview of event" {if gt($curr_ts , $event.object.data_map.to_time.content.timestamp)} class="ezagenda_event_old"{/if} width="99%">
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
	</td></tr>
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
	 <table cellpadding="0" cellspacing="0" summary="preview of event" {if gt($curr_ts , $event.object.data_map.to_time.content.timestamp)} class="ezagenda_event_old"{/if} width="99%">
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
	</td>
	</tr>
	<tr>
	<td colspan="2" class="ezagenda_month_body">
	{if $event.object.data_map.text.has_content}
		<div class="attribute-short">{attribute_view_gui attribute=$event.object.data_map.text}</div>
	{/if}
	</td>
	</tr>
	</table>
	</td></tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	{/foreach}
{/if}
<tr>
{if $direction}{* '-' direction  *}
	<td>
	{if $older_event_count|gt(0)}
		<a href={concat("/content/view/full/",  $node.node_id, "/offset/-", $temp_offset|sum(2))|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezwebin/full/event_view_program")}</a>
	{/if}
	</td>
	<td style="text-align:right;">
	{if $temp_offset|gt(0)}
		<a href={concat("/content/view/full/",  $node.node_id, "/offset/-", $temp_offset)|ezurl}>{"Future events"|i18n("design/ezwebin/full/event_view_program")} &gt;&gt;</a>
	{elseif $newer_event_count|gt(0)}
		<a href={concat("/content/view/full/",  $node.node_id, "/offset/0")|ezurl}>{"Future events"|i18n("design/ezwebin/full/event_view_program")} &gt;&gt;</a>
	{/if}
	</td>
{else}
	<td>
	{if $temp_offset|gt(0)}
		<a href={concat("/content/view/full/",  $node.node_id, "/offset/", $temp_offset|dec)|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezwebin/full/event_view_program")}</a>
	{elseif $older_event_count|gt(0)}
		<a href={concat("/content/view/full/",  $node.node_id, "/offset/-1")|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezwebin/full/event_view_program")}</a>
	{/if}
	</td>
	<td style="text-align:right;">
	{if $newer_event_count|gt(0)}
		<a href={concat("/content/view/full/",  $node.node_id, "/offset/", $temp_offset|inc)|ezurl}>{"Future events"|i18n("design/ezwebin/full/event_view_program")} &gt;&gt;</a>
	{/if}
	</td>
{/if}
</tr>
</table>
{undef}
</div>
</div>

</div></div></div></div></div>
</div>