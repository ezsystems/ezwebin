{* Article - Full view *}

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-view-full">
    <div class="class-article">
	
		<div class="attribute-header">
        	<h1>{$node.data_map.title.content|wash()}</h1>
		</div>
	
        <div class="attribute-byline">
		{if $node.data_map.author.content.is_empty|not()}
        <p class="author">
             {attribute_view_gui attribute=$node.data_map.author}
        </p>
		{/if}
        <p class="date">
             {$node.object.published|l10n(shortdatetime)}
        </p>
        </div>

		{if eq( ezini( 'article', 'ImageInFullView', 'content.ini' ), 'enabled' )}
        	{if $node.data_map.image.has_content}
            	<div class="attribute-image">
                	{attribute_view_gui attribute=$node.data_map.image image_class=medium}
					
					{if $node.data_map.caption.has_content}
					<div class="caption">
						{attribute_view_gui attribute=$node.data_map.caption}
					</div>
					{/if}
            	</div>
        	{/if}
		{/if}

		{if eq( ezini( 'article', 'SummaryInFullView', 'content.ini' ), 'enabled' )}
        	{if $node.data_map.intro.content.is_empty|not}
            	<div class="attribute-short">
                	{attribute_view_gui attribute=$node.data_map.intro}
            	</div>
        	{/if}
		{/if}

        {if $node.data_map.body.content.is_empty|not}
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.body}
            </div>
        {/if}

        {* Should we allow comments? *}
        {if is_unset( $versionview_mode )}
        {if $node.data_map.enable_comments.data_int}
            <h1>{"Comments"|i18n("design/ezwebin/full/article")}</h1>
                <div class="content-view-children">
                    {foreach fetch_alias( comments, hash( parent_node_id, $node.node_id ) ) as $comment}
                        {node_view_gui view='line' content_node=$comment}
                    {/foreach}
                </div>

                {* Are we allowed to create new object under this node? *}
                {if fetch( content, access,
                                     hash( access, 'create',
                                           contentobject, $node,
                                           contentclass_id, 'comment' ) )}
                    <form method="post" action={"content/action"|ezurl}>
                    <input type="hidden" name="ClassIdentifier" value="comment" />
                    <input type="hidden" name="NodeID" value="{$node.object.main_node.node_id}" />
					<input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'Locale', 'site.ini')}" />
                    <input class="button new_comment" type="submit" name="NewButton" value="{'New Comment'|i18n( 'design/ezwebin/full/article' )}" />
                    </form>
                {else}
                    <p>{'%login_link_startLog in%login_link_end or %create_link_startcreate a user account%create_link_end to comment.'|i18n( 'design/ezwebin/full/article', , hash( '%login_link_start', concat( '<a href="', '/user/login'|ezurl(no), '">' ), '%login_link_end', '</a>', '%create_link_start', concat( '<a href="', "/user/register"|ezurl(no), '">' ), '%create_link_end', '</a>' ) )}</p>
                {/if}
        {/if}
        {/if}
		
		
		<div class="links">
			<p class="tipafriend"><a href={concat( "/content/tipafriend/", $node.node_id )|ezurl} title="{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}">{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}</a></p>
		</div>
    </div>
</div>

</div></div></div></div></div>
</div>
