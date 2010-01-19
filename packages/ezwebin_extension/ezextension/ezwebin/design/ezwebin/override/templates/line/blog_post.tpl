{* Blog post - Line view *}
<div class="content-view-line">
    <div class="class-blog-post float-break">

    <div class="attribute-header">
        <h1><a href={$node.url_alias|ezurl} title="{$node.data_map.title.content|wash}">{$node.data_map.title.content|wash}</a></h1>
     </div>

    <div class="attribute-byline">
        <p class="date">{$node.data_map.publication_date.content.timestamp|l10n(shortdatetime)}</p>
        <p class="author">{$node.object.owner.name}</p>
        <p class="tags"> {"Tags:"|i18n("design/ezwebin/line/blog_post")} {foreach $node.data_map.tags.content.keywords as $keyword}
                                           <a href={concat( $node.parent.url_alias, "/(tag)/", $keyword|rawurlencode )|ezurl} title="{$keyword}">{$keyword}</a>
                                           {delimiter}
                                               ,
                                           {/delimiter}
                                     {/foreach}
        </p>
    </div>

        <div class="attribute-body float-break">
            {attribute_view_gui attribute=$node.data_map.body}
        </div>

        {if $node.data_map.enable_comments.data_int}
        <div class="attribute-comments">
        <p>
        {def $comment_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                    'class_filter_type', 'include',
                                                                    'class_filter_array', array( 'comment' ) ) )}
        {if $comment_count|gt( 0 )}
            <a href={concat( $node.url_alias, "#comments" )|ezurl}>{"View comments"|i18n("design/ezwebin/line/blog_post")} ({$comment_count})</a>
        {else}
            <a href={concat( $node.url_alias, "#comments" )|ezurl}>{"Add comment"|i18n("design/ezwebin/line/blog_post")}</a>
        {/if}
        </p>
        </div>
        {/if}

    </div>
</div>