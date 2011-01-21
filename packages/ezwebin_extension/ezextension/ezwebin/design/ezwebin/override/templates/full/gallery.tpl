{* Gallery - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-gallery">

        <div class="attribute-header">
            <h1>{$node.name|wash()}</h1>
        </div>

        {if $node.data_map.image.content}
            <div class="attribute-image">
                {attribute_view_gui image_class=medium attribute=$node.data_map.image.content.data_map.image}
            </div>
        {/if}

        <div class="attribute-short">
           {attribute_view_gui attribute=$node.data_map.short_description}
        </div>

        <div class="attribute-long">
           {attribute_view_gui attribute=$node.data_map.description}
        </div>

        {def $page_limit=12
             $children_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                     'class_filter_type', 'include',
                                                                     'class_filter_array', array( 'image', 'flash_player' ) ) )}

        {if $children_count}
            {* NOTE: Remember to modify templates for classes listed in class_filter_array if filters / sort_by is changed! *}
            {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                             'offset', $view_parameters.offset,
                                                             'limit', $page_limit,
                                                             'class_filter_type', 'include',
                                                             'class_filter_array', array( 'image', 'flash_player' ),
                                                             'sort_by', $node.sort_array ) )}
            <div class="attribute-link">
                <p>
                <a href={$children[0].url_alias|ezurl}>{'View as slideshow'|i18n( 'design/ezwebin/full/gallery' )}</a>
                </p>
            </div>

            <div class="content-view-children">
                {def $filters = ezini( 'gallerythumbnail', 'Filters', 'image.ini' )}

                    {foreach $filters as $filter}
                    {if or($filter|contains( "geometry/scale" ), $filter|contains( "geometry/scaledownonly" ), $filter|contains( "geometry/crop" ) )}
                        {def $image_style = $filter|explode("=").1}
                        {set $image_style = concat("width:", $image_style|explode(";").0, "px ;", "height:", $image_style|explode(";").1, "px")}
                        {break}
                    {/if}
                    {/foreach}

                {foreach $children as $child}
                    {node_view_gui view=galleryline content_node=$child}
                {/foreach}

            </div>
        {/if}

        {include name=navigator
                 uri='design:navigator/google.tpl'
                 page_uri=$node.url_alias
                 item_count=$children_count
                 view_parameters=$view_parameters
                 item_limit=$page_limit}
    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>