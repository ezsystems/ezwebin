{* Documentation page - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-documentation-page">

        <div class="attribute-header">
            <h1>{attribute_view_gui attribute=$node.object.data_map.title}</h1>
        </div>

        {if eztoc( $node.object.data_map.body )}
        <div class="attribute-toc">
            <h2>{'Table of contents'|i18n( 'design/ezwebin/full/documentation_page' )}</h2>
            {eztoc( $node.object.data_map.body )}
        </div>
        {/if}

        <div class="attribute-body">
            {attribute_view_gui attribute=$node.object.data_map.body}
        </div>
        
        <div class="attribute-byline">
            <p class="published">{'Created:'|i18n( 'design/ezwebin/full/documentation_page' )} {$node.object.published|l10n(shortdatetime)}</p>
            <p class="modified">{'Modified:'|i18n( 'design/ezwebin/full/documentation_page' )} {$node.object.modified|l10n(shortdatetime)}</p>
        </div>

        {if $node.object.data_map.show_children.data_int}
            {def $page_limit=10
                 $children_count=fetch_alias( 'children_count', hash( parent_node_id, $node.node_id,
                                                             class_filter_type, exclude,
                                                             class_filter_array, ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' ) ) )}

            <div class="content-view-children">
                {if $children_count}
                    {foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', $node.sort_array,
                                                            'class_filter_type', exclude,
                                                            'class_filter_array', ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' ),
                                                            'limit', $page_limit ) ) as $child }
                        {node_view_gui view='line' content_node=$child}
                    {/foreach}
                {/if}
            </div>

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

        {/if}
    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>