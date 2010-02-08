{def $page_limit = 20
     $topic_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id ) )}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-forum">

    <div class="attribute-header">
        <h1>{$node.name|wash}</h1>
    </div>

    <div class="attribute-short">
        {attribute_view_gui attribute=$node.data_map.description}
    </div>


    {if is_unset( $versionview_mode )}
    {if $node.object.can_create}
        {def $notification_access=fetch( 'user', 'has_access_to', hash( 'module', 'notification', 'function', 'addtonotification' ) )}
        <form method="post" action={"content/action/"|ezurl}>
            <input class="button forum-new-topic" type="submit" name="NewButton" value="{'New topic'|i18n( 'design/ezwebin/full/forum' )}" />
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />
            <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
            {if $notification_access }
                <input class="button forum-keep-me-updated" type="submit" name="ActionAddToNotification" value="{'Keep me updated'|i18n( 'design/ezwebin/full/forum' )}" />
            {/if}
            <input type="hidden" name="NodeID" value="{$node.node_id}" />
            <input type="hidden" name="ClassIdentifier" value="forum_topic" />
        </form>
    {else}
        <p>
        {"You need to be logged in to get access to the forums. You can do so %login_link_start%here%login_link_end%"|i18n( "design/ezwebin/full/forum",,
         hash( '%login_link_start%', concat( '<a href=', '/user/login/'|ezurl, '>' ), '%login_link_end%', '</a>' ) )}
        </p>
    {/if}
    {/if}


    <div class="content-view-children">

        <table class="list forum" cellspacing="0">
        <tr>
            <th class="topic">
                {"Topic"|i18n( "design/ezwebin/full/forum" )}
            </th>
            <th class="replies">
                {"Replies"|i18n( "design/ezwebin/full/forum" )}
            </th>
            <th class="author">
                {"Author"|i18n( "design/ezwebin/full/forum" )}
            </th>
            <th class="lastreply">
                {"Last reply"|i18n( "design/ezwebin/full/forum" )}
            </th>
        </tr>

        {if $topic_count}
            {section var=topic
                     loop=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                          'limit', $page_limit,
                                                          'offset', $view_parameters.offset,
                                                          'sort_by', array( array( attribute, false(), 'forum_topic/sticky' ), array( 'modified_subnode', false() ), array( 'node_id', false() ) ) ) )
                     sequence=array( bglight, bgdark )}
            {let topic_reply_count=fetch( 'content', 'tree_count', hash( parent_node_id, $topic.node_id ) )
                topic_reply_pages=sum( int( div( sum( $topic_reply_count, 1 ), 20 ) ), cond( mod( sum( $topic_reply_count, 1 ), 20 )|gt( 0 ), 1, 0 ) )}
            <tr class="{$topic.sequence}">
                <td class="topic">
                    <p>{section show=$topic.object.data_map.sticky.content}<img class="forum-topic-sticky" src={"sticky-16x16-icon.gif"|ezimage} height="16" width="16" align="middle" alt="" />{/section}
                    <a href={$topic.url_alias|ezurl}>{$topic.object.name|wash}</a></p>
                    {section show=$topic_reply_count|gt( sub( 20, 1 ) )}
                        <p>
                        {'Pages'|i18n( 'design/ezwebin/full/forum' )}:
                        {section show=$topic_reply_pages|gt( 5 )}
                            <a href={$topic.url_alias|ezurl}>1</a>...
                            {section var=reply_page loop=$topic_reply_pages offset=sub( $topic_reply_pages, sub( 5, 1 ) )}
                                <a href={concat( $topic.url_alias, '/(offset)/', mul( sub( $reply_page, 1 ), 20 ) )|ezurl}>{$reply_page}</a>
                            {/section}
                        {section-else}
                            <a href={$topic.url_alias|ezurl}>1</a>
                            {section var=reply_page loop=$topic_reply_pages offset=1}
                                <a href={concat( $topic.url_alias, '/(offset)/', mul( sub( $reply_page, 1 ), 20 ) )|ezurl}>{$reply_page}</a>
                            {/section}
                        {/section}
                        </p>
                    {/section}
                </td>
                <td class="replies">
                    <p>{$topic_reply_count}</p>
                </td>
                <td class="author">
                    <div class="attribute-byline">
                    <p class="author">{$topic.object.owner.name|wash}</p>
                    </div>
                </td>
                <td class="lastreply">
                {let last_reply=fetch('content','list',hash( parent_node_id, $topic.node_id,
                                                            sort_by, array( array( 'published', false() ) ),
                                                            limit, 1 ) )}
                    {section var=reply loop=$last_reply show=$last_reply}
                    <div class="attribute-byline">
                    <p class="date">{$reply.object.published|l10n(shortdatetime)}</p>
                    <p class="author">
                    {section show=$topic_reply_count|gt( 19 )}
                        <a href={concat( $reply.parent.url_alias, '/(offset)/', sub( $topic_reply_count, mod( $topic_reply_count, 20 ) ) , '#msg', $reply.node_id )|ezurl}>Last reply by:</a>
                    {section-else}
                        <a href={concat( $reply.parent.url_alias, '#msg', $reply.node_id )|ezurl}>Last reply by:</a>
                    {/section}
                    {$reply.object.owner.name|wash}
                    </p>
                    </div>

                    {/section}
            {/let}
            </td>
            </tr>
            {/let}
            {/section}
        {/if}
        </table>

    </div>

    </div>
</div>
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat('/content/view','/full/',$node.node_id)
         item_count=$topic_count
         view_parameters=$view_parameters
         item_limit=$page_limit}

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
