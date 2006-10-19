{* Feedback form - Full view *}

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

<div class="content-view-full">
    <div class="class-feedback-form">
	
		<div class="attribute-header">
        	<h1>{$node.name|wash()}</h1>
		</div>
		
        {include name=Validation uri='design:content/collectedinfo_validation.tpl'
                 class='message-warning'
                 validation=$validation collection_attributes=$collection_attributes}

        <div class="attribute-short">
                {attribute_view_gui attribute=$node.data_map.description}
        </div>
        <form method="post" action={"content/action"|ezurl}>

        <h4>{"Name"|i18n("design/base")}</h4>
        <div class="attribute-sender-name">
                {attribute_view_gui attribute=$node.data_map.sender_name}
        </div>

        <h4>{"Your E-mail address"|i18n("design/base")}</h4>
        <div class="attribute-email">
                {attribute_view_gui attribute=$node.data_map.email}
        </div>

        <h4>{"Subject"|i18n("design/base")}</h4>
        <div class="attribute-subject">
                {attribute_view_gui attribute=$node.data_map.subject}
        </div>

        <h4>{"Message"|i18n("design/base")}</h4>
        <div class="attribute-message">
                {attribute_view_gui attribute=$node.data_map.message}
        </div>

        <div class="content-action">
            <input type="submit" class="defaultbutton" name="ActionCollectInformation" value="{"Send form"|i18n("design/base")}" />
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="ViewMode" value="full" />
        </div>
        </form>

    </div>
</div>

</div></div></div></div></div>
</div>