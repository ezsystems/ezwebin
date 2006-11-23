{* Forum topic - Edit *}

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-edit">
    <div class="class-forum-topic">

        <form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>

		<div class="attribute-header">
        	<h1 class="long">{"Edit %1 - %2"|i18n("design/ezwebin/edit/forum_topic",,array($class.name|wash,$object.name|wash))}</h1>
		</div>

        {include uri="design:content/edit_validation.tpl"}

        <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
		
		<div class="block">
        	<label>{'Subject'|i18n('design/ezwebin/edit/forum_topic')}</label>
        	{attribute_edit_gui attribute=$object.data_map.subject}
		</div>
		
		<div class="block">
        	<label>{'Message'|i18n('design/ezwebin/edit/forum_topic')}</label>
        	{attribute_edit_gui attribute=$object.data_map.message}
		</div>

		<div class="block">
        	<label>{'Notify me about updates'|i18n('design/ezwebin/edit/forum_topic')}</label>
        	{attribute_edit_gui attribute=$object.data_map.notify_me}
		</div>

        {def $current_user=fetch( 'user', 'current_user' )
             $sticky_groups=ezini( 'ForumSettings', 'StickyUserGroupArray', 'forum.ini' )}

            {foreach $sticky_groups as $sticky}
                {if $current_user.groups|contains($sticky)}
                <h3>{'Sticky'|i18n('design/ezwebin/edit/forum_topic')}</h3>
                {attribute_edit_gui attribute=$object.data_map.sticky}
                {/if}
            {/foreach}

        <br />

        <div class="buttonblock">
            <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/ezwebin/edit/forum_topic')}" />
            <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/ezwebin/edit/forum_topic')}" />
            <input type="hidden" name="DiscardConfirm" value="0" />
        </div>

        </form>
    </div>
</div>

</div></div></div></div></div>
</div>