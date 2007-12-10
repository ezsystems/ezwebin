{def $sort_column = 'priority'
     $sort_column_value = eq( $used_node.node_id, $node.node_id)|choose( $node.priority, '0' )
     $previous_log=fetch( content, list, hash( parent_node_id, $used_node.node_id,
                                          class_filter_type, include,
                                          class_filter_array, array( 'article_subpage' ),
                                          limit, 1,
                                          attribute_filter, array( and, array( $sort_column, '<', $sort_column_value ) ),
                                          sort_by, array( $sort_column, false() ) ) )
     $next_log=fetch( content, list, hash( parent_node_id, $used_node.node_id,
                                              class_filter_type, include,
                                              class_filter_array, array( 'article_subpage' ),
                                              limit, 1,
                                              attribute_filter, array( and, array( $sort_column, '>', $sort_column_value ) ),
                                              sort_by, array( $sort_column, false()|not ) ) )}
<div class="pagenavigator">
<p>
    {if ne( $node.object.class_identifier, 'article_mainpage' )}
        {if $previous_log}
            <span class="previous"><a href={$previous_log[0].url_alias|ezurl} title="{$previous_log[0].name|wash}"><span class="text">&laquo;&nbsp;{if $previous_log[0].data_map.index_title.has_content}{attribute_view_gui attribute=$previous_log[0].data_map.index_title}{else}{$previous_log[0].name|wash}{/if}</span></a></span>
        {else}
            <span class="previous"><a href={$used_node.url_alias|ezurl} title="{$used_node.name|wash}"><span class="text">&laquo;&nbsp;{if $used_node.object.data_map.index_title.has_content}{attribute_view_gui attribute=$used_node.object.data_map.index_title}{else}{$used_node.name|wash}{/if}</span></a></span>
        {/if}
    {/if}
    {if $next_log}
         <span class="next"><a href={$next_log[0].url_alias|ezurl} title="{$next_log[0].name|wash}"><span class="text">{if $next_log[0].data_map.index_title.has_content}{attribute_view_gui attribute=$next_log[0].data_map.index_title}{else}{$next_log[0].name|wash}{/if}&nbsp;&raquo;</span></a></span>
     {/if}
</p>
</div>