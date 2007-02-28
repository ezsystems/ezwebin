<div class="class-blog extrainfo">
    <div class="columns-blog float-break">
        <div class="main-column-position">
            <div class="main-column float-break">
                <div class="box">
                    <div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

{def $page_limit = 10
     $blogs = array()
     $blogs_count = 0}

{if $view_parameters.tag}
    {set $blogs = fetch( 'content', 'keyword', hash( 'alphabet', rawurldecode( $view_parameters.tag ),
                                                     'classid', 'blog_post',
                                                     'parent_node_id', $node.node_id,
                                                     'offset', $view_parameters.offset,
                                                     'sort_by', array( 'attribute', false(), 'blog_post/publication_date' ),
                                                     'limit', $page_limit ) )
         $blogs_count = fetch( 'content', 'keyword_count', hash( 'alphabet', rawurldecode( $view_parameters.tag ),
                                                     'classid', 'blog_post',
                                                     'parent_node_id', $node.node_id ) )}

    {foreach $blogs as $blog}
        {node_view_gui view=line content_node=$blog.link_object}
    {/foreach}
{else}
    {if and( $view_parameters.month, $view_parameters.year )}
        {def $start_date = maketime( 0,0,0, $view_parameters.month, cond( ne( $view_parameters.day , ''), $view_parameters.day, '01' ), $view_parameters.year)
             $end_date = maketime( 23, 59, 59, $view_parameters.month, cond( ne( $view_parameters.day , ''), $view_parameters.day, makedate( $view_parameters.month, '01', $view_parameters.year)|datetime( 'custom', '%t' ) ), $view_parameters.year)}

        {set $blogs = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                              'offset', $view_parameters.offset,
                                              'attribute_filter', array( and,
                                                                         array( 'blog_post/publication_date', '>=', $start_date ),
                                                                         array( 'blog_post/publication_date', '<=', $end_date ) ),
                                              'sort_by', array( 'attribute', false(), 'blog_post/publication_date' ),
                                              'limit', $page_limit ) )
             $blogs_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                  'attribute_filter', array( and,
                                                                         array( 'blog_post/publication_date', '>=', $start_date ),
                                                                         array( 'blog_post/publication_date', '<=', $end_date) ) ) )}

        {foreach $blogs as $blog}
            {node_view_gui view=line content_node=$blog}
        {/foreach}
    {else}
        {set $blogs = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                              'offset', $view_parameters.offset,
                                              'sort_by', array( 'attribute', false(), 'blog_post/publication_date' ),
                                              'limit', $page_limit ) )
             $blogs_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id ) )}

        {foreach $blogs as $blog}
            {node_view_gui view=line content_node=$blog}
        {/foreach}
    {/if}
{/if}

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$blogs_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

                    </div></div></div></div></div>
                </div>
            </div>
        </div>

        <div class="extrainfo-column-position">
            <div class="extrainfo-column">
                <div class="box">
                    <div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">
                        {include uri='design:parts/blog/extra_info.tpl' used_node=$node}
                    </div></div></div></div></div>
                </div>
            </div>
        </div>
    </div>
</div>