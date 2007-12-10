{def $infoboxes=fetch( 'content', 'list', hash( 'parent_node_id', $current_node_id,
                                                'class_filter_type', 'include',
                                                'class_filter_array', array( 'infobox' ),
                                                'sort_by', array( 'priority', false() ) ) )}
                                                
{if gt($infoboxes|count, 0)}
{foreach $infoboxes as $infobox}
    {node_view_gui content_node=$infobox view='infobox'}
{/foreach}
{/if}