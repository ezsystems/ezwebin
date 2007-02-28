{* Article (sub-page) - Full view *}

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-view-full">
    <div class="class-article-mainpage">
	
		<div class="attribute-header">
        	<h1>{$node.data_map.title.content|wash()}</h1>
		</div>
	
        <div class="attribute-byline">
		{if $node.parent.data_map.author.content.is_empty|not()}
        <p class="author">
             {attribute_view_gui attribute=$node.parent.data_map.author}
        </p>
		{/if}
        <p class="date">
             {$node.parent.data_map.publication_date.content.timestamp|l10n(shortdatetime)}
        </p>
        </div>

		<div class="object-right">
			<div class="box">
			<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">
			{* Article index *}
			{def $article_subpages=fetch( content, list, hash( parent_node_id, $node.parent.node_id,
                                                               class_filter_type, include,
                                                              class_filter_array, array( 'article_subpage' ),
														      sort_by, $node.sort_array ) )}
{if $article_subpages|count}
	    <h2>{"Article index"|i18n( "design/ezwebin/full/article_subpage" )}</h2>

    <div class="attribute-related-articles">
        <ol>

                <li><a href={$node.parent.url_alias|ezurl}>
                 {if $node.parent.object.data_map.index_title.has_content}
                	{attribute_view_gui attribute=$node.parent.object.data_map.index_title}
                {else}
                	{$node.parent.name|wash}
                {/if}
                </a></li>
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
    </div>
{/if}
			
			</div></div></div></div></div>
			</div>
		</div>

        {if $node.data_map.body.content.is_empty|not}
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.body}
            </div>
        {/if}

{def $sort_order = 1
     $sort_column = 'priority'
     $sort_column_value = $node.priority
     $previous_log=fetch( content, list, hash( parent_node_id, $node.parent_node_id,
                                              class_filter_type, include,
                                              class_filter_array, array( 'article_subpage' ),
                                              limit, 1,
                                              attribute_filter, array( and, array( $sort_column, $sort_order|choose( '>', '<' ), $sort_column_value ) ),
                                              sort_by, array( $sort_column, $sort_order|not ) ) )
     $next_log=fetch( content, list, hash( parent_node_id, $node.parent_node_id,
                                          class_filter_type, include,
                                          class_filter_array, array( 'article_subpage' ),
                                          limit, 1,
                                          attribute_filter, array( and, array( $sort_column, $sort_order|choose( '<', '>' ), $sort_column_value ) ),
                                          sort_by, array( $sort_column, $sort_order ) ) )}

 <div class="pagenavigator">
 <p>
            {if $previous_log}
                <span class="previous"><a href={$previous_log[0].url_alias|ezurl} title="{$previous_log[0].name|wash}"><span class="text">&laquo;&nbsp;{if $previous_log[0].data_map.index_title.has_content}{attribute_view_gui attribute=$previous_log[0].data_map.index_title}{else}{$previous_log[0].name|wash}{/if}</span></a></span>
            {else}
				<span class="previous"><a href={$node.parent.url_alias|ezurl} title="{$node.parent.name|wash}"><span class="text">&laquo;&nbsp;{if $node.parent.object.data_map.index_title.has_content}{attribute_view_gui attribute=$node.parent.object.data_map.index_title}{else}{$node.parent.name|wash}{/if}</span></a></span>
            {/if}

            {if $next_log}
                    <span class="next"><a href={$next_log[0].url_alias|ezurl} title="{$next_log[0].name|wash}"><span class="text">{if $next_log[0].data_map.index_title.has_content}{attribute_view_gui attribute=$next_log[0].data_map.index_title}{else}{$next_log[0].name|wash}{/if}&nbsp;&raquo;</span></a></span>
            {/if}
</p>
</div>

        {* Should we allow comments? *}
        {if is_unset( $versionview_mode )}
        {if $node.parent.data_map.enable_comments.data_int}
            <h1>{"Comments"|i18n("design/ezwebin/full/article_subpage")}</h1>
                <div class="content-view-children">
                    {foreach fetch_alias( comments, hash( parent_node_id, $node.parent.node_id ) ) as $comment}
                        {node_view_gui view='line' content_node=$comment}
                    {/foreach}
                </div>

                {* Are we allowed to create new object under this node? *}
                {if fetch( content, access,
                                     hash( access, 'create',
                                           contentobject, $node.parent,
                                           contentclass_id, 'comment' ) )}
                    <form method="post" action={"content/action"|ezurl}>
                    <input type="hidden" name="ClassIdentifier" value="comment" />
                    <input type="hidden" name="NodeID" value="{$node.parent.object.main_node.node_id}" />
					<input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'Locale', 'site.ini')}" />
                    <input class="button new_comment" type="submit" name="NewButton" value="{'New Comment'|i18n( 'design/ezwebin/full/article_subpage' )}" />
                    </form>
                {else}
                    <p>{'%login_link_startLog in%login_link_end or %create_link_startcreate a user account%create_link_end to comment.'|i18n( 'design/ezwebin/full/article_subpage', , hash( '%login_link_start', concat( '<a href="', '/user/login'|ezurl(no), '">' ), '%login_link_end', '</a>', '%create_link_start', concat( '<a href="', "/user/register"|ezurl(no), '">' ), '%create_link_end', '</a>' ) )}</p>
                {/if}
        {/if}
        {/if}
		
		<div class="links">
			<p class="tipafriend"><a href={concat( "/content/tipafriend/", $node.parent.node_id )|ezurl} title="{'Tip a friend'|i18n( 'design/ezwebin/full/article_subpage' )}">{'Tip a friend'|i18n( 'design/ezwebin/full/article_subpage' )}</a></p>
		</div>
    </div>
</div>

</div></div></div></div></div>
</div>
