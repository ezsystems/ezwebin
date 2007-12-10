<!--START: CAL NAV -->

{def

    $blog_node    = $used_node
    $blog_node_id = $blog_node.node_id

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
    $day_blogs = array()
    $loop_count = 0
    }

{if ne($temp_month, 12)}
    {set $last_ts=makedate($temp_month|sum( 1 ), 1, $temp_year)}
{else}
    {set $last_ts=makedate(1, 1, $temp_year|sum(1))}
{/if}

{def    $blog_items=fetch( 'content', 'list', hash(
            'parent_node_id', $blog_node_id,
            'sort_by', array( 'attribute', true(), 'blog_post/publication_date'),
            'class_filter_type',  'include',
            'class_filter_array', array( 'blog_post' ),
            'main_node_only', true(),
             'attribute_filter',
            array( array( 'blog_post/publication_date', 'between', array( sum($first_ts,1), sub($last_ts,1)  )) )
                ))

    $url_reload=concat( $blog_node.url_alias, "/(day)/", $temp_today, "/(month)/", $temp_month, "/(year)/", $temp_year, "/offset/2")
    $url_back=concat( $blog_node.url_alias,  "/(month)/", sub($temp_month, 1), "/(year)/", $temp_year)
    $url_forward=concat( $blog_node.url_alias, "/(month)/", sum($temp_month, 1), "/(year)/", $temp_year)
}

{if eq($temp_month, 1)}
    {set $url_back=concat( $blog_node.url_alias,"/(month)/", "12", "/(year)/", sub($temp_year, 1))}
{elseif eq($temp_month, 12)}
    {set $url_forward=concat( $blog_node.url_alias,"/(month)/", "1", "/(year)/", sum($temp_year, 1))}
{/if}

{foreach $blog_items as $blog}
    {if eq($temp_month|int(), $blog.data_map.publication_date.content.month|int())}
        {set $loop_dayone = $blog.data_map.publication_date.content.day}
    {else}
        {set $loop_dayone = 1}
    {/if}
    {if eq($temp_month|int(), $blog.data_map.publication_date.content.month|int())}
        {if $blog.data_map.to_time.content.is_valid}
            {set $loop_daylast = $blog.data_map.publication_date.content.day}
        {else}
            {set $loop_daylast = $loop_dayone}
        {/if}
    {else}
        {set $loop_daylast = $days}
    {/if}
    {for $loop_dayone|int() to $loop_daylast|int() as $counter}
        {set $day_array = concat($day_array, $counter, ', ')}
        {if eq($counter,$temp_today)}
            {set $day_blogs = $day_blogs|append($event)}
        {/if}
    {/for}
{/foreach}

<div class="calendar">
<div class="calendar-tl"><div class="calendar-tr"><div class="calendar-bl"><div class="calendar-br">
<div class="content">

<div class="month">
<div class="previous">
<p><a href={$url_back|ezurl} title="{'Previous month'|i18n('design/ezwebin/blog/calendar')}">&#8249;&#8249;<span class="hide"> {'Previous month'|i18n('design/ezwebin/blog/calendar')}</span></a></p>
</div>
<div class="next">
<p><a href={$url_forward|ezurl} title="{'Next month'|i18n('design/ezwebin/blog/calendar')}"><span class="hide">{'Next month'|i18n('design/ezwebin/blog/calendar')} </span>&#8250;&#8250;</a></p>
</div>
<h2>{$temp_ts|datetime( custom, '%F' )|upfirst()}&nbsp;{$temp_year}</h2>
</div>

<div class="table">
<table cellspacing="0" border="0" summary="{'Calendar'|i18n('design/ezwebin/blog/calendar')}">
<tr class="top">
    <th class="left">{"Mon"|i18n("design/ezwebin/blog/calendar")}</th>
    <th>{"Tue"|i18n("design/ezwebin/blog/calendar")}</th>
    <th>{"Wed"|i18n("design/ezwebin/blog/calendar")}</th>
    <th>{"Thu"|i18n("design/ezwebin/blog/calendar")}</th>
    <th>{"Fri"|i18n("design/ezwebin/blog/calendar")}</th>
    <th>{"Sat"|i18n("design/ezwebin/blog/calendar")}</th>
    <th class="right">{"Sun"|i18n("design/ezwebin/blog/calendar")}</th>
</tr>
{def $counter = 1 $col_counter=1 $css_col_class='' $col_end=0}
{while le( $counter, $days )}
    {set $dayofweek     = makedate( $temp_month, $counter, $temp_year )|datetime( custom, '%w' )
         $css_col_class = ''
         $col_end       = or( eq( $dayofweek, 0 ), eq( $counter, $days ) )}
    {if or( eq( $counter, 1 ), eq( $dayofweek, 1 ) )}
        <tr class="{if le( $days|sub( $counter ), 7 )}bottom{/if}">
        {set $css_col_class=' left'}
    {elseif and($col_end, not(and(eq( $counter, $days ), $span2|gt( 0 ), $span2|ne(7))) )}
        {set $css_col_class=' right'}
    {/if}
    {if and( $span1|gt( 1 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while ne( $col_counter, $span1 )}
            <td{if $col_counter|eq( 1 )} class="left"{/if}>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {elseif and( eq($span1, 0 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while le( $col_counter, 6 )}
            <td{if $col_counter|eq( 1 )} class="right"{/if}>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {/if}
    <td class="{if eq($counter, $temp_today)}currentselected{/if} {if and(eq($counter, $curr_today), eq($curr_month, $temp_month))}today{/if}{$css_col_class}">
    {if $day_array|contains(concat(' ', $counter, ',')) }
        <em><a href={concat( $blog_node.url_alias, "/(day)/", $counter, "/(month)/", $temp_month, "/(year)/", $temp_year)|ezurl}>{$counter}</a></em>
    {else}
        {$counter}
    {/if}
    </td>
    {if and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne(7))}
        {set $col_counter=1}
        {while le( $col_counter, $span2 )}
            <td{if $col_counter|eq( $span2 )} class="right"{/if}>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {/if}
    {if $col_end}
        </tr>
    {/if}
    {set $counter=inc( $counter )}
{/while}
</table>
</div>

</div>
</div></div></div></div>
</div>

{undef}

<!-- END: CAL NAV -->