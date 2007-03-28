
            {* Article index *}
            {def $article_subpages=fetch( content, list, hash( parent_node_id, $used_node.node_id,
                                                               class_filter_type, include,
                                                              class_filter_array, array( 'article_subpage' ),
                                                              sort_by, $used_node.sort_array ) )}
{if $article_subpages|count}
        <div class="attribute-article-index">
            <div class="border-box">
            <div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
            <div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

        <h2>{'Article index'|i18n( 'design/ezwebin/article/article_index' )}</h2>

            <ol>
            {if eq( $used_node.node_id, $node.node_id )}
                <li>
                {if $used_node.object.data_map.index_title.has_content}
                    {attribute_view_gui attribute=$used_node.object.data_map.index_title}
                {else}
                    {$used_node.name|wash}
                {/if}
                </li>
            {else}
                <li><a href={$used_node.url_alias|ezurl}>
                 {if $used_node.object.data_map.index_title.has_content}
                    {attribute_view_gui attribute=$used_node.object.data_map.index_title}
                {else}
                    {$used_node.name|wash}
                {/if}
                </a></li>
            {/if}
            {foreach $article_subpages as $article_subpage}
                {if eq( $node.node_id, $article_subpage.node_id )}
                    <li>
                    {if $article_subpage.object.data_map.index_title.has_content}
                        {attribute_view_gui attribute=$article_subpage.object.data_map.index_title}
                    {else}
                        {$article_subpage.name|wash}
                    {/if}
                    </li>
                {else}
                    <li><a href={$article_subpage.url_alias|ezurl}>
                    {if $article_subpage.object.data_map.index_title.has_content}
                        {attribute_view_gui attribute=$article_subpage.object.data_map.index_title}
                    {else}
                        {$article_subpage.name|wash}
                    {/if}
                    </a></li>
                {/if}
            {/foreach}
            </ol>
            </div></div></div>
            <div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
            </div>
        </div>
{/if}