{if is_set( ezini( 'RSSSettings', 'DefaultFeedItemClasses', 'site.ini' )[ $content_object.class_identifier ] )}
    {def $create_rss_access = fetch( 'user', 'has_access_to', hash( 'module', 'rss', 'function', 'edit' ) )}
    {if $create_rss_access}
        {if fetch( 'rss', 'has_export_by_node', hash( 'node_id', $current_node.node_id ) )}
            <input class="ezwt-input-image" type="image" src={"websitetoolbar/ezwt-icon-rss-remove.png"|ezimage} name="RemoveNodeFeed" title="{'Remove node RSS/ATOM feed'|i18n( 'design/ezwebin/parts/website_toolbar' )}" />
        {else}
            <input class="ezwt-input-image" type="image" src={"websitetoolbar/ezwt-icon-rss-add.png"|ezimage} name="CreateNodeFeed" title="{'Create node RSS/ATOM feed'|i18n( 'design/ezwebin/parts/website_toolbar' )}" />
        {/if}
    {/if}
{/if}
