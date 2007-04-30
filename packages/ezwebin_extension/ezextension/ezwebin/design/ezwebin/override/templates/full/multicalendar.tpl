{set-block scope=root variable=cache_ttl}900{/set-block}
{* Multicalendar - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-multicalendar">

        <div class="attribute-header">
            <h1>{$node.name|wash()}</h1>
        </div>
        
       {if $node.data_map.description.has_content}
        <div class="attribute-short">
        {attribute_view_gui attribute=$node.data_map.description}
        </div>
       {/if}
       
       {foreach $node.data_map.calendars.content.relation_list as $relation}
            {def $related_node = fetch( 'content', 'node', hash( 'node_id', $relation.node_id ) )
                 $related_node_children = fetch( 'content', 'list', hash( 'parent_node_id', $related_node.node_id,
                                                                           'limit', '5',
                                                                           'class_filter_type', 'include',
                                                                          'class_filter_array', array( 'event' ),
                                                                           'sort_by', array( 'attribute', true(), 'event/from_time' ) ) )}
            <h2><a href="{$related_node.url_alias|ezurl(no)}">{$related_node.name}</a></h2>
            <table class="list" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <th>{'Event'|i18n( 'design/ezwebin/full/multicalendar' )}</th>
                <th>{'Start date'|i18n( 'design/ezwebin/full/multicalendar' )}</th>
                <th>{'Category'|i18n( 'design/ezwebin/full/multicalendar' )}</th>
                <th>{'Description'|i18n( 'design/ezwebin/full/multicalendar' )}</th>
            </tr>
            {foreach $related_node_children as $child sequence array( 'bglight', 'bgdark' ) as $style}
            <tr class="{$style}">
                <td><a href="{$child.url_alias|ezurl(no)}">{$child.name|wash()}</a></td>
                <td>{attribute_view_gui attribute=$child.data_map.from_time}</td>
                <td>{attribute_view_gui attribute=$child.data_map.category}</td>
                <td>{attribute_view_gui attribute=$child.data_map.text}</td>
            </tr>
            {/foreach}
            </table>
            {undef}
       {/foreach}

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>