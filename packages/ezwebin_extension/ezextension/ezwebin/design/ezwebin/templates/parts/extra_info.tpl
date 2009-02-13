{def $infoboxes=fetch( 'content', 'list', hash( 'parent_node_id', $pagedata.extra_menu_node_id,
                                                'class_filter_type', 'include',
                                                'class_filter_array', $pagedata.extra_menu_class_list,
                                                'sort_by', array( 'priority', false() ) ) )}
                                                
{foreach $infoboxes as $infobox}
    {node_view_gui content_node=$infobox view='infobox'}
{/foreach}